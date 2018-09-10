Return-Path: <chris.brandt@renesas.com>
Return-path: <chris.brandt@renesas.com>
From: Chris Brandt <chris.brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>,
	Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v4 0/2] Add support for RZ/A2 wdt
Date: Mon, 10 Sep 2018 14:52:31 -0500
Message-Id: <20180910195233.25296-1-chris.brandt@renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

Slightly modify the rza_wdt.c driver and update the binding docs.

Chris Brandt (2):
  watchdog: rza_wdt: Support longer timeouts
  dt-bindings: watchdog: renesas-wdt: Add support for R7S9210

 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  1 +
 drivers/watchdog/rza_wdt.c                         | 88 +++++++++++++++++-----
 2 files changed, 71 insertions(+), 18 deletions(-)

-- 
2.16.1
