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
Subject: [PATCH v4 0/3] watchdog: dw_wdt: add reset lines
Date: Mon, 22 May 2017 10:51:37 +0200
Message-Id: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

Hi!

This series adds support for the reset line that is (potentially) holding
the watchdog in reset.

As the watchdog is useless if this happens, it needs to be deasserted in
the probe function.

Tested on a Socrates board.

Regards,
Steffen


Changes since v3:

  - goto out_disable_clk
  - add Reviewed-by

Changes since v2:

  - use optional reset functions
  - add Acked-by to devictree bindings

Changes since v1:

  - remove reset-names property
  - remove warning if reset property is missing

Steffen Trumtrar (3):
  watchdog: bindings: dw_wdt: add reset lines
  watchdog: dw_wdt: get reset lines from dt
  ARM: socfpga: dtsi: add dw-wdt reset lines

 Documentation/devicetree/bindings/watchdog/dw_wdt.txt |  3 +++
 arch/arm/boot/dts/socfpga.dtsi                        |  2 ++
 drivers/watchdog/dw_wdt.c                             | 11 +++++++++++
 3 files changed, 16 insertions(+)

base-commit: 2ea659a9ef488125eb46da6eb571de5eae5c43f6
-- 
git-series 0.9.1
