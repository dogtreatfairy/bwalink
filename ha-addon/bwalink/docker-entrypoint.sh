#!/usr/bin/with-contenv bashio

bashio::log.info "Starting BWALink addon..."

# --- No changes needed in this section ---
BRIDGE_IP=$(bashio::config 'bridge_ip')
BRIDGE_PORT=$(bashio::config 'bridge_port')
export TZ=$(bashio::info.timezone)
export LOG_LEVEL=$(bashio::config 'log_level')
bashio::log.info "Setting addon timezone to ${TZ} based on the system timezone."

if bashio::config.has_value 'mqtt_uri'; then
    MQTT_URI=$(bashio::config 'mqtt_uri')
elif bashio::var.has_value "$(bashio::services 'mqtt')"; then
    MQTT_USER="$(bashio::services 'mqtt' 'username')"
    MQTT_PASSWORD="$(bashio::services 'mqtt' 'password')"
    if bashio::var.true "$(bashio::services 'mqtt' 'ssl')"; then
        MQTT_URI="mqtts://${MQTT_USER}:${MQTT_PASSWORD}@$(bashio::services 'mqtt' 'host'):$(bashio::services 'mqtt' 'port')"
    else
        MQTT_URI="mqtt://${MQTT_USER}:${MQTT_PASSWORD}@$(bashio::services 'mqtt' 'host'):$(bashio::services 'mqtt' 'port')"
    fi
else
    bashio::log.error "No MQTT configuration found. Exiting..."
    exit 1
fi

if bashio::var.true "$(bashio::config 'socat')"; then
    DEVICE=/run/service/hottub
    bashio::log.info "Starting socat connecting ${DEVICE} to ${BRIDGE_IP}:${BRIDGE_PORT}"
    socat pty,link=${DEVICE},b115200,raw,echo=0 tcp4:${BRIDGE_IP}:${BRIDGE_PORT},forever,interval=10,fork &
else
    DEVICE="tcp://${BRIDGE_IP}:${BRIDGE_PORT}/"
fi

# --- This is the updated section ---
bashio::log.info "Locating bwa_mqtt_bridge executable..."
BWA_EXEC=$(command -v bwa_mqtt_bridge)

# Check if the executable was found
if [ -z "$BWA_EXEC" ]; then
    bashio::log.fatal "The 'bwa_mqtt_bridge' executable could not be found in the system's PATH. Exiting."
    exit 1
fi

bashio::log.info "Found executable at ${BWA_EXEC}"
bashio::log.info "Starting mqtt bridge connecting ${DEVICE} to ${MQTT_URI/:*@/://}"

# Execute the program using the dynamically found path
exec "$BWA_EXEC" "${MQTT_URI}" "${DEVICE}"