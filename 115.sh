#!/bin/bash
cd /usr/local/115Browser
/usr/local/115Browser/115Browser \
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
    --ignore-certificate-errors \
    --disable-bundled-plugins \
    --disable-dev-shm-usage \
    --reduce-user-agent-sniffing \
    --no-first-run \
    --disable-breakpad \
    --enable-low-res-tiling \
    --disable-heap-profiling \
    --disable-features=IsolateOrigins,site-per-process,OptimizationHints,MediaRouter,Translate,SidePanel,ReadingMode,GlobalMediaControls,TabHoverCardImages,PasswordManager,ReadAnything,Autofill,PictureInPicture,WebUITabStrip,FocusMode,LensStandalone,DomainReliability,SendMouseEventsToCompositor,BackgroundFetch,WebBluetooth,WebNfc,CooperativeScheduling,Sharing,WebCodecs,WebRtc,WebGpu,PrivacySandbox,FederatedLearningOfCohorts,IdleDetection,ClientSidePhishingDetection \
    --disable-smooth-scrolling \
    --lang=zh-CN \
    >/tmp/115Browser.log 2>&1 &
