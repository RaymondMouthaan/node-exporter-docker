ARG BUILD_FROM
FROM $BUILD_FROM

# Define ARGs again to make them available after FROM
ARG BUILD_DATE
ARG BUILD_VERSION
ARG BUILD_REF
ARG OS
ARG ARCH
ARG QEMU_ARCH
ARG NODE_EXPORTER_VERSION

# Basic build-time metadata as defined at http://label-schema.org
LABEL org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.dockerfile=".docker/Dockerfile" \
    org.label-schema.license="GNU" \
    org.label-schema.name="node-exporter" \
    org.label-schema.version=${BUILD_VERSION} \
    org.label-schema.description="Prometheus exporter for hardware and OS metrics exposed by *NIX kernels, written in Go with pluggable metric collectors." \
    org.label-schema.url="https://github.com/prometheus/node_exporter" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/RaymondMouthaan/node-exporter-docker" \
    maintainer="Raymond M Mouthaan <raymondmmouthaan@gmail.com>"

# Copy ARCHs to ENVs to make them available at runtime
ENV OS=$OS
ENV ARCH=$ARCH
ENV NODE_EXPORTER_VERSION=${NODE_EXPORTER_VERSION}
ENV NODE_ID=none

COPY tmp/qemu-${QEMU_ARCH}-static /usr/bin/qemu-${QEMU_ARCH}-static
COPY ./docker-entrypoint.sh /etc/node-exporter/docker-entrypoint.sh

RUN chmod +x /etc/node-exporter/docker-entrypoint.sh

EXPOSE     9100

ENTRYPOINT [ "/etc/node-exporter/docker-entrypoint.sh" ]
CMD [ "/bin/node_exporter" ]
