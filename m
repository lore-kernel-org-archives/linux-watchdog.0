Return-path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	James Hartley <james.hartley@imgtec.com>, Andrew Bresticker
	<abrestic@chromium.org>, James Hogan <james.hogan@imgtec.com>
CC: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, "Ezequiel
 Garcia" <ezequiel.garcia@imgtec.com>
Subject: [PATCH v7 0/2] watchdog: ImgTec PDC Watchdog Timer Driver
Date: Tue, 6 Jan 2015 10:19:33 -0300
Message-ID: <1420550375-22867-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Here's the seventh round for IMG PDC Watchdog driver.
The series is based on v3.19-rc3.

Thanks!

Changes from v6:

  * Reworked set_timeout function to get rid of the min_delay field.
  * Addressed a few comments made by Guenter Roeck.
  * Added a description of the clocks to the devicetree binding doc.

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

 .../devicetree/bindings/watchdog/imgpdc-wdt.txt    |  19 ++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/imgpdc_wdt.c                      | 289 +++++++++++++++++++++
 4 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
 create mode 100644 drivers/watchdog/imgpdc_wdt.c

-- 
2.2.1
