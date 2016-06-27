Return-path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] arm64: dts: r8a7796: Add watchdog support
Date: Mon, 27 Jun 2016 19:50:44 +0200
Message-Id: <1467049847-7469-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

	Hi Wim, Günter, Simon, Magnus,

This patch series adds support for the Watchdog Timer (WDT) Controller
in the Renesas R-Car M3-W (r8a7796) SoC.
        
  - The first patch updates the DT binding documentation for the Renesas
    WDT driver, and should go in through the watchdog tree.
  - The remaining patches update the DTS for the r8a7796 SoC and
    Salvator-X development board, and should go in through the renesas
    tree. This can happen as soon as the DT binding update has been
    accepted.

To use the watchdog, there is a runtime dependency on "[PATCH 0/2] clk:
renesas: r8a7796: Add watchdog clocks".

This has been tested on r8a7796/Salvator-X.

Thanks!

Geert Uytterhoeven (3):
  watchdog: renesas-wdt: Add support for the r8a7796 wdt
  arm64: dts: r8a7796: Add RWDT node
  arm64: dts: r8a7796/salvator-x: Enable watchdog timer

 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 6 +++++-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts         | 5 +++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi                   | 9 +++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
