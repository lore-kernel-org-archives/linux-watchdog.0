Return-path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
To: wim@iguana.be, linux@roeck-us.net, James.Hartley@imgtec.com,
        abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Jude.Abraham@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: [PATCH v3 0/2] watchdog: Add support for ImgTec PowerDown Controller Watchdog Timer
Date: Tue, 18 Nov 2014 17:37:20 +0530
Message-Id: <1416312442-15688-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

This patchset provides support for the PowerDown Controller (PDC) Watchdog Timer
found on Pistachio SOC from Imagination Technologies (ImgTec).

The series is based on 3.18-rc4.

Changes from v2:

 * Removed interrupt.h header file.

 * Removed clock rate-change notifier callback.

Changes from v1:

 * Arranged all include files in alphabetical order.

 * Arranged register field masks/shifts defines next to their
   corresponding register

 * Registered clock rate-change notifier callback.

 * Removed all references to 32 kHz fixed clock rate.
   Now the clock rate is read dynamically using clk_get_rate().

 * Defined a macro PDC_WD_CONFIG_ENABLE.

 * Added code for getting system clock.

 * Moved module_param stuffs next to the corresponding variable defines.

 * Added code in the function pdc_wdt_remove for stopping watchdog.

 * Removed MODULE_ALIAS.

 * Removed few unwanted spaces and unwanted blank lines.


Naidu Tellapati (2):
  watchdog: ImgTec PDC Watchdog Timer Driver
  DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation

 .../devicetree/bindings/watchdog/imgpdc-wdt.txt    |   18 ++
 drivers/watchdog/Kconfig                           |   11 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/imgpdc_wdt.c                      |  311 ++++++++++++++++++++
 4 files changed, 341 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
 create mode 100644 drivers/watchdog/imgpdc_wdt.c
