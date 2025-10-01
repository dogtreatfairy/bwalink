# BWALink Home Assistant Add-on

![Logo][logo]

[![Release][release-shield]][release] ![Project Maintenance][maintenance-shield]

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

BWALink is an add-on for Home Assistant that allows you to connect and control Balboa Water Group spa controllers using a serial-to-IP gateway and MQTT. This enables seamless integration of your spa with Home Assistant, providing access to sensors and switches for spa features.

## Features
- Connects Balboa spa controllers to Home Assistant via MQTT
- Supports aarch64, amd64, armhf, armv7, and i386 architectures
- Provides sensors and switches for spa control
- Simple configuration using MQTT Discovery

## Getting Started
1. Make sure you have an MQTT broker set up and running.
2. Install the BWALink add-on in Home Assistant.
3. Configure the add-on with your spa's IP address and MQTT URI.

### Example MQTT URI
```
mqtt://username:password@mqtt-broker-ip:1883
```
If your password contains special characters, use URL encoding (e.g., `%23` for `#`).

### Configuration Options
- `bridge_ip`: IP address of your serial-to-IP device (e.g., EW11)
- `bridge_port`: Port number (default: 8899)
- `mqtt_uri`: URI for your MQTT broker
- `socat`: Enable/disable socat (default: false)
- `log_level`: Set log level (FATAL, ERROR, WARN, INFO, DEBUG)

## Home Assistant Integration
If MQTT Discovery is enabled in Home Assistant, BWALink will automatically create entities for your spa's sensors and switches. No manual configuration is required.

For more details, visit the [BWALink GitHub repository](https://github.com/dogtreatfairy/bwalink).

[logo]: https://github.com/dogtreatfairy/bwalink/raw/main/bwalink/icon.png
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[release-shield]: https://img.shields.io/badge/version-v2025.7.1-blue.svg
[release]: https://github.com/dogtreatfairy/bwalink/releases/tag/2025.7.1

Join us on Discord:

<a target="_blank" href="https://discord.gg/5wjQ2asb64"><img src="https://dcbadge.limes.pink/api/server/5wjQ2asb64" alt="" /></a>