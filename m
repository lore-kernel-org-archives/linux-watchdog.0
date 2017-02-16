Return-path: <chris.brandt@renesas.com>
From: Chris Brandt <chris.brandt@renesas.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v2 0/3] power: reset: add reset for renesas r7s72100
Date: Thu, 16 Feb 2017 12:23:17 -0500
Message-Id: <20170216172320.10897-1-chris.brandt@renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

Some Renesas SoCs do not have a reset register and the only way to do a SW
controlled reset is to use the watchdog timer.

Additionally, since all the WDT timeout options are so quick, a system
reset is about the only thing it's good for.
For example, the longest WDT overflow you can get with a RZ/A1 (R7S72100)
with its 8-bit wide counter is 125ms.

v2:
* added to renesas-wdt.txt instead of creating a new file
* changed "renesas,r7s72100-reset" to "renesas,r7s72100-wdt"
* changed "renesas,wdt-reset" to "renesas,rza-wdt"
* added "renesas,rza-wdt" as a fallback
* added interupt property (even though it is not used)
* added clocks property
* changed hard coded register values to defines
* added msleep to while(1) loop
* removed unnecessary #include files
* added Reviewed-by: Geert Uytterhoeven for renesas-reset.c

Chris Brandt (3):
  power: reset: Add Renesas reset driver
  watchdog: renesas-wdt: add support for rza
  ARM: dts: r7s72100: Add reset handler

 .../devicetree/bindings/watchdog/renesas-wdt.txt   |   4 +-
 arch/arm/boot/dts/r7s72100.dtsi                    |   7 ++
 drivers/power/reset/Kconfig                        |   9 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/renesas-reset.c                | 112 +++++++++++++++++++++
 5 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/reset/renesas-reset.c

-- 
2.10.1
