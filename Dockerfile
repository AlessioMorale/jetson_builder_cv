# syntax=docker/dockerfile:1
FROM alessiomorale/jetson-builder:r32.5.0_1.3
# install the base environment and all build tools
ARG OPENCV_VERSION="4.4.0"
ARG OPENCV_DO_TEST="FALSE"
# note: 8 jobs will fail on Nano. Try 1 instead.
ARG OPENCV_BUILD_JOBS="10"
# required for apt-get -y to work properly:
ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

WORKDIR /usr/local/src/build_opencv
ADD https://github.com/AlessioMorale/nano_build_opencv/raw/jetson_builder/build_opencv.sh .

ENV CCACHE_ROOT_FOLDER=/ccache
RUN mkdir -p ${CCACHE_ROOT_FOLDER}
RUN --mount=type=secret,id=secrets,dst=/secrets \
    --mount=type=cache,target=/ccache \
    ls -al /secrets && \
    source /secrets && \
    source /root/setup_ccache && \
    download_cache && \
    touch /.dockerenv && \
    time /bin/bash ./build_opencv.sh && \
    upload_cache
