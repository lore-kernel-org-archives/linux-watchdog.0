Return-Path: <hayashibara.keiji@socionext.com>
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
Subject: [PATCH V4 0/3] add UniPhier watchdog support
Date: Wed, 14 Jun 2017 16:53:42 +0900
Message-Id: <1497426825-25450-1-git-send-email-hayashibara.keiji@socionext.com>
List-ID: <linux-watchdog@vger.kernel.org>

This series adds support for watchdog timer implemented on UniPhier LD11 and
LD20 SoCs. This driver supports watchdog and system reset for SoCs.

patch V3
http://www.spinics.net/lists/linux-watchdog/msg11889.html

patch V2
http://www.spinics.net/lists/linux-watchdog/msg11852.html

patch V1
http://www.spinics.net/lists/linux-watchdog/msg11782.html


Changes between V4 and V3
=========================

 * Add own dependencies to Kconfig.

Changes between V3 and V2
=========================

 * Make it possible to take a timeout from devicetree.
 * Sort #include headlers alphabetically.
 * Correct the description of dt-bindings document and this patch comment.
 * Correct the description of license as GPLv2.
 * Correct MODULE_AUTHOR()
 * Remove unnecessary code.

Changes between V2 and V1
=========================
1. Add barrier code in uniphier_watchdog_ping() and __uniphier_watchdog_start().
2. Fix issues according to review comments.

Keiji Hayashibara (3):
  dt-bindings: watchdog: add description for UniPhier WDT controller
  watchdog: uniphier: add UniPhier watchdog driver
  arm64: dts: uniphier: add watchdog node for LD11 and LD20

 .../devicetree/bindings/watchdog/uniphier-wdt.txt  |  20 ++
 Documentation/watchdog/watchdog-parameters.txt     |   6 +
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   4 +
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/uniphier_wdt.c                    | 268 +++++++++++++++++++++
 7 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
 create mode 100644 drivers/watchdog/uniphier_wdt.c

-- 
2.7.4
