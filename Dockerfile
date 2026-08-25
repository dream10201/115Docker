FROM docker.io/xiuxiu10201/webvnc:latest
ENV \
    XDG_CONFIG_HOME=/tmp \
    XDG_CACHE_HOME=/tmp \
    HOME=/opt \
    DISPLAY=:115 \
    WEB_PORT=1150 \
    LD_LIBRARY_PATH=/usr/local/115Browser

ARG VERSION=""
RUN apt update \
    && apt install -y --no-install-recommends libnss3 fonts-liberation libgbm1 \
    && wget -q https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64 -O /usr/bin/jq \
    && chmod +x /usr/bin/jq \
    && if [ -z "$VERSION" ]; then VERSION=$(curl -k -s https://appversion.115.com/1/web/1.0/api/getMultiVer | jq -r '.data["Linux-115chrome"].version_code'); fi \
    && wget -q --no-check-certificate "https://down.115.com/client/115pc/lin/115br_v${VERSION}.deb" -O /tmp/tmp.deb \
    && apt install -y /tmp/tmp.deb \
    && rm /tmp/tmp.deb \
    && wget -q https://github.com/dream10201/115Cookie/archive/refs/heads/master.zip -O /tmp/tmp.zip \
    && unzip -j /tmp/tmp.zip -d /usr/local/115Cookie/ \
    && rm /tmp/tmp.zip \
    && mkdir -p /opt/Desktop /etc/115 \
    && cp /usr/share/applications/115Browser.desktop /usr/share/applications/pcmanfm.desktop /opt/Desktop \
    && sed -i 's|^Exec=.*|Exec=/usr/local/115Browser/115.sh|' /opt/Desktop/115Browser.desktop \
    && chmod 777 -R /opt /etc/115 \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chmod=755 115.sh /usr/local/115Browser/115.sh
COPY run.sh /opt/run.sh
EXPOSE 1150
CMD ["bash","/opt/run.sh"]
