#!/bin/bash
sed -i "1s/^/const CID=\"${CID}\"\nconst SEID=\"${SEID}\"\nconst UID=\"${UID}\"\nconst KID=\"${KID}\"\n/" /usr/local/115Cookie/worker.js
if [ -z "${DISPLAY_WIDTH}" ]; then
    DISPLAY_WIDTH=1366
fi
if [ -z "${DISPLAY_HEIGHT}" ]; then
    DISPLAY_HEIGHT=768
fi

mkdir -p "${HOME}/.vnc"
export PASSWD_PATH="${HOME}/.vnc/passwd"
echo ${PASSWORD} | vncpasswd -f > "${PASSWD_PATH}"
chmod 0600 "${HOME}/.vnc/passwd"
"${NO_VNC_HOME}"/utils/novnc_proxy --vnc localhost:6015 --listen 1150 &
echo "geometry=${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}" > ~/.vnc/config
/usr/libexec/vncserver :115 &
sleep 2;
pcmanfm --desktop &
/usr/local/115Browser/115.sh
tint2
