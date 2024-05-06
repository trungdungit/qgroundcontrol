#
# QGroundControl ubuntu build environment
#

FROM ubuntu:20.04
LABEL authors="dungpt"

ARG QT_VERSION=5.15.2
ARG QT_MODULES="qtcharts qtquick3d"

ENV DEBIAN_FRONTEND noninteractive

ENV DISPLAY :99

ENV QT_PATH /opt/Qt
ENV QT_DESKTOP $QT_PATH/${QT_VERSION}/gcc_64

ENV PATH /usr/lib/ccache:$QT_DESKTOP/bin:$PATH

COPY tools/setup/install-dependencies-debian.sh /tmp/qt/
RUN /tmp/qt/install-dependencies-debian.sh

# Install Qt
COPY tools/setup/install-qt-debian.sh /tmp/qt/
RUN /tmp/qt/install-qt-debian.sh

# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

WORKDIR /project/build
CMD cmake -S /project/source -B . -G Ninja -DCMAKE_BUILD_TYPE=Debug; \
	cmake --build . --target all --config Debug ; \
	cmake --install . --config Debug
