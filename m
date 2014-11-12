Return-path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
To: wim@iguana.be, linux@roeck-us.net, James.Hartley@imgtec.com,
        abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Jude.Abraham@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: [PATCH 0/2] watchdog: Add support for ImgTec PowerDown Controller Watchdog Timer
Date: Wed, 12 Nov 2014 20:48:01 +0530
Message-Id: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

Hi all,

This patchset provides support for the PowerDown Controller (PDC)
Watchdog Timer found on Pistachio SOC from Imagination Technologies (ImgTec).

Upstream support for the SoC is on the way and will be submitted soon.

The series is based on 3.18-rc4. We appreciate your feedback.

Naidu Tellapati (2):
  watchdog: ImgTec PDC Watchdog Timer Driver
  DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation

 .../devicetree/bindings/watchdog/imgpdc-wdt.txt    |   18 +
 drivers/watchdog/Kconfig                           |  167 +++------
 drivers/watchdog/Makefile                          |   12 +-
 drivers/watchdog/imgpdc_wdt.c                      |  388 ++++++++++++++++++++
 4 files changed, 468 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
 create mode 100644 drivers/watchdog/imgpdc_wdt.c
