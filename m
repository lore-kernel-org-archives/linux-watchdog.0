Return-Path: <chris.brandt@renesas.com>
Return-path: <chris.brandt@renesas.com>
From: Chris Brandt <chris.brandt@renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>,
	Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v3 0/2] Add support for RZ/A2 wdt
Date: Thu,  6 Sep 2018 20:22:41 -0500
Message-Id: <20180907012243.86603-1-chris.brandt@renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

Slightly modify the rza_wdt.c driver and update the binding docs.


Chris Brandt (2):
  watchdog: rza_wdt: Support longer timeouts
  dt-bindings: watchdog: renesas-wdt: Add support for R7S9210

 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  1 +
 drivers/watchdog/rza_wdt.c                         | 81 +++++++++++++++++-----
 2 files changed, 64 insertions(+), 18 deletions(-)

-- 
2.16.1
