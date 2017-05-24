Return-path: <hayashibara.keiji@socionext.com>
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	masami.hiramatsu@linaro.org,
	jaswinder.singh@linaro.org,
	yamada.masahiro@socionext.com,
	hayashi.kunihiko@socionext.com,
	owada.kiyoshi@socionext.com,
	Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH 0/2] add UniPhier watchdog support
Date: Wed, 24 May 2017 15:34:50 +0900
Message-Id: <1495607692-657-1-git-send-email-hayashibara.keiji@socionext.com>
List-ID: <linux-watchdog@vger.kernel.org>

This series adds support for watchdog timer implemented on UniPhier LD11 and
LD20 SoCs. This driver supports watchdog and system reset for SoCs.

Keiji Hayashibara (2):
  watchdog: uniphier: add UniPhier watchdog driver
  arm64: dts: uniphier: add watchdog node for LD11 and LD20

 .../devicetree/bindings/watchdog/uniphier-wdt.txt  |  20 ++
 Documentation/watchdog/watchdog-parameters.txt     |   6 +
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   4 +
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/uniphier_wdt.c                    | 273 +++++++++++++++++++++
 7 files changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
 create mode 100644 drivers/watchdog/uniphier_wdt.c

-- 
2.7.4
