ARG BUILD_FROM
FROM ${BUILD_FROM}

# Add standard build arguments for Home Assistant
ARG BUILD_ARCH
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_VERSION

# Install dependencies in a single layer to keep the image smaller
RUN apk add --no-cache --update \
    bash \
    build-base \
    curl \
    libffi-dev \
    ruby \
    ruby-bundler \
    ruby-dev \
    socat \
    tzdata \
    zlib-dev \
  # Configure bundler and install the gem
  && bundle config set deployment 'true' \
  && gem install balboa_worldwide_app \
  # Clean up build dependencies and apk cache
  && apk del build-base \
  && rm -rf /var/cache/apk/*

# Copy the run script into the container
COPY docker-entrypoint.sh /
# Make the run script executable
RUN chmod +x /docker-entrypoint.sh

# Set standard labels for Home Assistant
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION}

# Set the entrypoint to the run script
ENTRYPOINT ["/docker-entrypoint.sh"]