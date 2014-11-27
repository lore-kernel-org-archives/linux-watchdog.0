Return-path: <naidu.tellapati@gmail.com>
From: Naidu Tellapati <naidu.tellapati@gmail.com>
To: wim@iguana.be,
	linux@roeck-us.net,
	abrestic@chromium.org,
	ezequiel.garcia@imgtec.com,
	james.hartley@imgtec.com,
	james.hogan@imgtec.com
Cc: naidu.tellapati@imgtec.com,
	arul.ramasamy@imgtec.com,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	Naidu Tellapati <Naidu.Tellapati@gmail.com>
Subject: [PATCH  RESEND v6 0/2] watchdog: Add support for ImgTec PowerDown Controller Watchdog Timer
Date: Thu, 27 Nov 2014 10:24:03 +0530
Message-Id: <1417064045-13274-1-git-send-email-Naidu.Tellapati@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patchset provides support for the PowerDown Controller (PDC) Watchdog Timer
found on Pistachio SOC from Imagination Technologies (ImgTec).

The series is based on 3.18-rc5.

I am re-sending the series with correct Signed-off-by headers.

Changes from v5:

 * Removed unused struct pdc_wdt_dev variables.

 * Removed out_wdt label in probe function.

Changes from v4:

 * Added warning message if initial timeout value exceeds maximum timeout.

Changes from v3:

 * Removed PDC_WD_MAX_DELAY.

 * Removed spinlock.

 * Removed timeout check inside pdc_wdt_set_timeout function.

 * Changed identity to IMG PDC Watchdog.

 * Removed pdc_wdt_set_timeout call from the probe function.

 * Removed pdc_wdt_shutdown function call from pdc_wdt_remove function
   and added pdc_wdt_stop function call instead.

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
 drivers/watchdog/imgpdc_wdt.c                      |  298 ++++++++++++++++++++
 4 files changed, 328 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
 create mode 100644 drivers/watchdog/imgpdc_wdt.c
