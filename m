Return-path: <str@pengutronix.de>
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	kernel@pengutronix.de,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v3 0/3] watchdog: dw_wdt: add reset lines
Date: Thu, 18 May 2017 10:42:35 +0200
Message-Id: <cover.9d687e41ad8d91c267143a43d703f656f7d5689c.1495096910.git-series.s.trumtrar@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

Hi!

This series adds support for the reset line that is (potentially) holding
the watchdog in reset.

As the watchdog is useless if this happens, it needs to be deasserted in
the probe function.

Tested on a Socrates board.

Regards,
Steffen

Changes since v2:

  - use optional reset functions
  - add Acked-by to devicetree bindings

Changes since v1:

  - remove reset-names property
  - remove warning if reset property is missing

Steffen Trumtrar (3):
  watchdog: bindings: dw_wdt: add reset lines
  watchdog: dw_wdt: get reset lines from dt
  ARM: socfpga: dtsi: add dw-wdt reset lines

 Documentation/devicetree/bindings/watchdog/dw_wdt.txt |  3 +++
 arch/arm/boot/dts/socfpga.dtsi                        |  2 ++
 drivers/watchdog/dw_wdt.c                             |  9 +++++++++
 3 files changed, 14 insertions(+)

base-commit: 2ea659a9ef488125eb46da6eb571de5eae5c43f6
-- 
git-series 0.9.1
