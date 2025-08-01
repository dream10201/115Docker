#!/bin/bash
rm -rf /etc/115/SingletonLock /etc/115/SingletonSocket /etc/115/SingletonCookie
sed -i \
    -e "s/\(CID:\s*'\)[^']*'/\1$COOKIE_CID'/" \
    -e "s/\(SEID:\s*'\)[^']*'/\1$COOKIE_SEID'/" \
    -e "s/\(UID:\s*'\)[^']*'/\1$COOKIE_UID'/" \
    -e "s/\(KID:\s*'\)[^']*'/\1$COOKIE_KID'/" \
    -e "s/\(EXPIRATION_DATE:\s*\)[0-9]*/\1$(date -d "+1 year" +%s)/" \
    "/usr/local/115Cookie/worker.js"
if [ -z "${DISPLAY_WIDTH}" ]; then
    DISPLAY_WIDTH=1366
fi
if [ -z "${DISPLAY_HEIGHT}" ]; then
    DISPLAY_HEIGHT=768
fi
mkdir -p "${HOME}/.vnc"
export PASSWD_PATH="${HOME}/.vnc/passwd"
echo ${PASSWORD} | vncpasswd -f >"${PASSWD_PATH}"
chmod 0600 "${HOME}/.vnc/passwd"
"${NO_VNC_HOME}"/utils/novnc_proxy --vnc localhost:$((5900+${DISPLAY#:})) --listen ${WEB_PORT} &
echo "geometry=${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}" >~/.vnc/config
/usr/libexec/vncserver ${DISPLAY} &
sleep 2
pcmanfm --desktop &
/usr/local/115Browser/115.sh
G_SLICE=always-malloc tint2
