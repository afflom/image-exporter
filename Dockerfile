FROM centos:centos7.7.1908 AS build-stage

# Setup Directories and stage scripts
RUN mkdir -p /build/payload/images
WORKDIR /build

# Copy in binary scripts
COPY installer payload/
COPY decompress .
COPY build .
COPY images/* /build/payload/images

# Build it
RUN bash build

FROM scratch AS export-stage
COPY --from=build-stage /build/selfextract.bsx /