ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH
ARG BAZEL_VERSION=6.0.0
ARG WHEEL_LINKS=https://wheels.home-assistant.io/musllinux/

WORKDIR /usr/src
RUN apk add --no-cache \
        autoconf \
        automake \
        build-base \
        cmake \
        curl \
        cython \
        freetype \
        freetype-dev \
        gfortran \
        git \
        hdf5-dev \
        lapack-dev \
        libexecinfo-dev \
        libexecinfo-static \
        libjpeg-turbo \
        libjpeg-turbo-dev \
        libpng \
        libpng-dev \
        libtool \
        linux-headers \
        musl \
        openblas-dev \
        openjdk11 \
        patchelf \
        pkgconfig \
        rsync \
        sed \
        zip \
    \
    && rm -rf /usr/lib/jvm/java-11-openjdk/jre

ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk"

RUN pip3 install \
        --no-cache-dir \
        --find-links "${WHEEL_LINKS}" \
        wheel \
        six \
        numpy \
        auditwheel

RUN cd /usr/src \
    && curl -SLO \
        https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-$BAZEL_VERSION-dist.zip \
    && mkdir bazel-$BAZEL_VERSION \
    && unzip -qd bazel-$BAZEL_VERSION bazel-$BAZEL_VERSION-dist.zip \
    && cd /usr/src/bazel-$BAZEL_VERSION \
    && EXTRA_BAZEL_ARGS=--host_javabase=@local_jdk//:jdk ./compile.sh \
    && cp -p output/bazel /usr/bin/
    
RUN bazel build @upb//python/dist:binary_wheel
