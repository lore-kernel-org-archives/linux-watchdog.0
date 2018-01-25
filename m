Return-Path: <fabrizio.castro@bp.renesas.com>
Return-path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [RFC 00/37] Fix watchdog on Renesas R-Car Gen2 and RZ/G1
Date: Thu, 25 Jan 2018 18:02:34 +0000
Message-Id: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

Dear All,

while trying to add watchdog support to RZ/G1M and RZ/G1E I discovered
that it couldn't work out of the box. R-Car Gen2 and RZ/G1 are very
similar from a design perspective, and therefore the same problem is
observable on R-Car Gen2 too.

To deal with SMP on R-Car Gen2 and RZ/G1, we install a reset vector
to ICRAM1 and we program the [S]BAR registers so that when we turn ON
the non-boot CPUs they are redirected to the reset vector installed by
Linux in ICRAM1, and eventually they continue the execution to RAM,
where the SMP bring-up code will take care of the rest.
The content of the [S]BAR registers survives a watchdog triggered reset,
and as such after the watchdog fires the boot core will try and execute
the SMP bring-up code instead of jumping to the bootrom code.

This series is a proposal for a fix to the aforementioned problem.
The main strategy for the solution is to let the reset vector decide
if it needs to jump to shmobile_boot_fn or to the bootrom code.
In a watchdog triggered reset scenario, since the [S]BAR registers keep
their values, the boot CPU will jump into the newly designed reset
vector, the assembly routine will eventually test WOVF (a bit in register
RWTCSRA that indicates if the watchdog counter has overflown, the value
of this bit gets retained in this scenario), and jump to the bootrom code
which will in turn load up the bootloader, etc.
When bringing up SMP or using CPU hotplug, the reset vector will jump
to shmobile_boot_fn instead.

I think it's worth giving an overview of the implementation here to make
it easier for the reader to understand the full picture.
Patch "ARM: shmobile: Add watchdog support" modifies the reset vector,
and since the size in bytes of the reset vector changes we need to update
all of the .dtsi accordingly with patches "Adjust SMP routine size" for
the various SoC.
In order for the watchdog IP to actually trigger a reset we need to clear
bit RWDT_RSTMSK first, this leads to patches:
* "soc: renesas: rcar-rst: Add generic compatible strings",
* "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
* "soc: renesas: rcar-rst: Document generic compatible strings", and
* "Use fallback rst compatible string" for the various SoC.
This RFC provides a driver specifically designed for R-Car Gen2 and
RZ/G1, its implementation may be merged with the R-Car Gen3 one instead
of being delivered by a new driver. The patches taking care of the
driver are:
* "ARM: shmobile: rcar-gen2: Export shmobile_set_wdt_clock_status function"
* "watchdog: renesas_wdt_gen2: Add Gen2 specific driver"
Patch "watchdog: renesas_wdt: Add restart support" is simply an ehancement
to the Gen3 driver.
The "Add rwdt clock" patches add the definitions required by the rwdt clock,
please note that we are declaring the rwdt clocks as critical, and that's
because having the rwdt always ON guarantees that it is (almost) always
safe to read the WOVF bit and also purges the implementation from race
conditions.
The remaining patches define the rwdt DT node for the platforms we have
tested, and finally add support watchdof to the iwg20m and iwg22m SoM.

Speaking of testing, we tested this series on top of the following boards:
* iwg20d,
* iwg22d,
* Lager (only running on the CA15s),
* Koelsh, and
* Alt

This work was rebased on top of tag renesas-devel-20180122-v4.15-rc9
from the below repository:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

What do you guys think about this?

Any volunteer for testing this work on other platforms using the
same reset vector?

Comments welcome!

Best Regards,

Fabrizio Castro (37):
  ARM: shmobile: Add watchdog support
  ARM: dts: r8a7743: Adjust SMP routine size
  ARM: dts: r8a7745: Adjust SMP routine size
  ARM: dts: r8a7790: Adjust SMP routine size
  ARM: dts: r8a7791: Adjust SMP routine size
  ARM: dts: r8a7792: Adjust SMP routine size
  ARM: dts: r8a7793: Adjust SMP routine size
  ARM: dts: r8a7794: Adjust SMP routine size
  soc: renesas: rcar-rst: Add generic compatible strings
  soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
  soc: renesas: rcar-rst: Document generic compatible strings
  ARM: dts: r8a7743: Use fallback rst compatible string
  ARM: dts: r8a7745: Use fallback rst compatible string
  ARM: dts: r8a7790: Use fallback rst compatible string
  ARM: dts: r8a7791: Use fallback rst compatible string
  ARM: dts: r8a7794: Use fallback rst compatible string
  arm64: dts: renesas: r8a7795: Use fallback rst compatible string
  arm64: dts: renesas: r8a7796: Use fallback rst compatible string
  arm64: dts: renesas: r8a77970: Use fallback rst compatible string
  arm64: dts: renesas: r8a77995: Use fallback rst compatible string
  dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
  watchdog: renesas_wdt: Add restart support
  ARM: shmobile: rcar-gen2: Export shmobile_set_wdt_clock_status
    function
  watchdog: renesas_wdt_gen2: Add Gen2 specific driver
  ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN2
  clk: renesas: r8a7743: Add rwdt clock
  clk: renesas: r8a7745: Add rwdt clock
  clk: renesas: r8a7790: Add rwdt clock
  clk: renesas: r8a7791/r8a7793: Add rwdt clock
  clk: renesas: r8a7794: Add rwdt clock
  ARM: dts: r8a7743: Add watchdog support to SoC dtsi
  ARM: dts: r8a7745: Add watchdog support to SoC dtsi
  ARM: dts: r8a7790: Add watchdog support to SoC dtsi
  ARM: dts: r8a7791: Add watchdog support to SoC dtsi
  ARM: dts: r8a7794: Add watchdog support to SoC dtsi
  ARM: dts: iwg20m: Add watchdog support to SoM dtsi
  ARM: dts: iwg22m: Add watchdog support to SoM dtsi

 .../devicetree/bindings/reset/renesas,rst.txt      |  11 +-
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  13 +-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |   5 +
 arch/arm/boot/dts/r8a7743.dtsi                     |  15 +-
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |   5 +
 arch/arm/boot/dts/r8a7745.dtsi                     |  15 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  15 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |  15 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |  15 +-
 arch/arm/configs/shmobile_defconfig                |   1 +
 arch/arm/mach-shmobile/common.h                    |   1 +
 arch/arm/mach-shmobile/headsmp.S                   |  53 ++++
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |  16 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   3 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   3 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |   3 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |   3 +-
 drivers/clk/renesas/r8a7743-cpg-mssr.c             |   2 +
 drivers/clk/renesas/r8a7745-cpg-mssr.c             |   2 +
 drivers/clk/renesas/r8a7790-cpg-mssr.c             |   2 +
 drivers/clk/renesas/r8a7791-cpg-mssr.c             |   2 +
 drivers/clk/renesas/r8a7794-cpg-mssr.c             |   2 +
 drivers/soc/renesas/rcar-rst.c                     |  41 +++-
 drivers/watchdog/Kconfig                           |  15 +-
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/renesas_wdt.c                     |  19 ++
 drivers/watchdog/renesas_wdt_gen2.c                | 270 +++++++++++++++++++++
 drivers/watchdog/renesas_wdt_gen2.h                |  22 ++
 30 files changed, 541 insertions(+), 33 deletions(-)
 create mode 100644 drivers/watchdog/renesas_wdt_gen2.c
 create mode 100644 drivers/watchdog/renesas_wdt_gen2.h

-- 
2.7.4
