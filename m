Return-path: <hayashibara.keiji@socionext.com>
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	masami.hiramatsu@linaro.org,
	jaswinder.singh@linaro.org,
	yamada.masahiro@socionext.com,
	hayashi.kunihiko@socionext.com,
	owada.kiyoshi@socionext.com,
	Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH V2 0/3] add UniPhier watchdog support
Date: Tue,  6 Jun 2017 18:11:31 +0900
Message-Id: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com>
List-ID: <linux-watchdog@vger.kernel.org>

This series adds support for watchdog timer implemented on UniPhier LD11 and
LD20 SoCs. This driver supports watchdog and system reset for SoCs.

patch V1
http://www.spinics.net/lists/linux-watchdog/msg11782.html

Changes between V2 and V1
=========================
1. Add barrier code in uniphier_watchdog_ping() and __uniphier_watchdog_start().

 When writing WDTCTRL_CLEAR to WDTCTRL register, WDTCTRL_STATUS is updated
 about 62.5usec(2cycle of 32kHz) later. However, if WDTCTRL_CLEAR is written
 before WDTCTRL_STATUS is updated, it can't reboot as SoC specification.
 Therefore, I added barrier code, it waits until WDTCTRL_STATUS is updated.
   
2. Fix issues according to review comments.

 * Use WDOG_STOP_ON_REBOOT instead of shutdown method of struct platform_driver.
 * Separate uniphier-wdt bindings documentation as a patch.
 * Remove delay.h and add bitops.h header file.
 * Use devm_watchdog_register_device().
 * Remove unnecessary code.

Keiji Hayashibara (3):
  devicetree: add UniPhier WDT devicetree bindings documentation
  watchdog: uniphier: add UniPhier watchdog driver
  arm64: dts: uniphier: add watchdog node for LD11 and LD20

 .../devicetree/bindings/watchdog/uniphier-wdt.txt  |  20 ++
 Documentation/watchdog/watchdog-parameters.txt     |   6 +
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   4 +
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/uniphier_wdt.c                    | 275 +++++++++++++++++++++
 7 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
 create mode 100644 drivers/watchdog/uniphier_wdt.c

-- 
2.7.4
