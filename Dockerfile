FROM debian:latest AS base
ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8
RUN apt update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt install -y wget curl unzip locales locales-all fonts-nanum fonts-noto-cjk fonts-noto-cjk-extra fonts-dejavu fonts-liberation fonts-noto fonts-unfonts-core fonts-unfonts-extra \
    && locale-gen zh_CN.UTF-8 \
    && update-locale LANG=zh_CN.UTF-8 \
    && rm -rf /var/lib/apt/lists/* \
    && echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

FROM base AS desktop
RUN apt update \
    && DEBIAN_FRONTEND=noninteractive \
    # thunar 
    && apt install -y pcmanfm tint2 openbox xauth xinit \
    && rm -rf /var/lib/apt/lists/*

FROM desktop AS tigervnc
RUN wget -qO- https://sourceforge.net/projects/tigervnc/files/stable/1.14.1/tigervnc-1.14.1.x86_64.tar.gz | tar xz --strip 1 -C /


FROM tigervnc AS novnc
ENV NO_VNC_HOME=/usr/share/usr/local/share/noVNCdim
RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y python3-numpy \
    && mkdir -p "${NO_VNC_HOME}/utils/websockify" \
    && wget -qO- "https://github.com/novnc/noVNC/archive/v1.5.0.tar.gz" | tar xz --strip 1 -C "${NO_VNC_HOME}" \
    && wget -qO- "https://github.com/novnc/websockify/archive/v0.12.0.tar.gz" | tar xz --strip 1 -C "${NO_VNC_HOME}/utils/websockify" \
    && chmod +x -v "${NO_VNC_HOME}/utils/novnc_proxy" \
    && sed -i '1s/^/if(localStorage.getItem("resize") == null){localStorage.setItem("resize","remote");}\n/' "${NO_VNC_HOME}/app/ui.js" \
    && rm -rf /var/lib/apt/lists/*

FROM novnc AS oneonefive
ENV \
    XDG_CONFIG_HOME=/tmp \
    XDG_CACHE_HOME=/tmp \
    HOME=/opt \
    DISPLAY=:115 \
    LD_LIBRARY_PATH=/usr/local/115Browser:\$LD_LIBRARY_PATH
RUN apt update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt install -y libnss3 libasound2 libgbm1 \
    && wget -q --no-check-certificate -c https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64 \
    && chmod +x jq-linux-amd64 \
    && mv jq-linux-amd64 /usr/bin/jq \
    && export VERSION=`curl -s https://appversion.115.com/1/web/1.0/api/getMultiVer | jq '.data["Linux-115chrome"].version_code'  | tr -d '"'` \
    && wget -q --no-check-certificate -c "https://down.115.com/client/115pc/lin/115br_v${VERSION}.deb" \
    && apt install "./115br_v${VERSION}.deb"  \
    && rm "115br_v${VERSION}.deb" \
    && wget -q --no-check-certificate -c https://github.com/dream10201/115Cookie/archive/refs/heads/master.zip \
    && unzip -j master.zip -d /usr/local/115Cookie/ \
    && rm master.zip \
    && mkdir -p /opt/Desktop \
    && mkdir -p /opt/Downloads \
    && chmod 777 -R /opt/Downloads \
    && cp /usr/share/applications/115Browser.desktop /opt/Desktop \
    && cp /usr/share/applications/pcmanfm.desktop /opt/Desktop \
    && chmod 777 -R /opt \
    && mkdir -p /etc/115 \
    && chmod 777 -R /etc/115 \
    && echo "cd /usr/local/115Browser" > /usr/local/115Browser/115.sh \
    && echo "/usr/local/115Browser/115Browser \
    --test-type \
    --disable-backgrounding-occluded-windows \
    --user-data-dir=/etc/115 \
    --disable-cache \
    --load-extension=/usr/local/115Cookie \
    --disable-wav-audio \
    --disable-logging \
    --disable-notifications \
    --no-default-browser-check \
    --disable-background-networking \
    --enable-features=ParallelDownloading \
    --start-maximized \
    --no-sandbox \
    --disable-vulkan \
    --disable-gpu \
    --ignore-certificate-errors \
    --disable-bundled-plugins \
    --disable-dev-shm-usage \
    --reduce-user-agent-sniffing \
    --no-first-run \
    --disable-breakpad \
    --disable-gpu-process-crash-limit \
    --enable-low-res-tiling \
    --disable-heap-profiling \
    --disable-features=IsolateOrigins,site-per-process \
    --disable-smooth-scrolling \
    --lang=zh-CN \
    --disable-software-rasterizer \
    >/tmp/115Browser.log 2>&1 &" >> /usr/local/115Browser/115.sh \
    && rm -rf /var/lib/apt/lists/*

FROM oneonefive
EXPOSE 1150
COPY run.sh /opt/run.sh
CMD ["bash","/opt/run.sh"]
