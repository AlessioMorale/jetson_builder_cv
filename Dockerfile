FROM alessiomorale/jetson-builder:r32.4.4_1.0.1
# install the base environment and all build tools
ARG OPENCV_VERSION="4.3.0"
ARG OPENCV_DO_TEST="FALSE"
# note: 8 jobs will fail on Nano. Try 1 instead.
ARG OPENCV_BUILD_JOBS="4"
# required for apt-get -y to work properly:
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/local/src/build_opencv
ADD https://github.com/AlessioMorale/nano_build_opencv/raw/jetson_builder/build_opencv.sh .
RUN /bin/bash build_opencv.sh