Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:26272 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751567AbeA3UXI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 Jan 2018 15:23:08 -0500
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [RFC v3 00/25] Fix watchdog on Renesas R-Car Gen2 and RZ/G1
Date: Tue, 30 Jan 2018 20:22:33 +0000
Message-Id: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

v3 takes into account all the feedbacks recieved, and implements a
different logic in the reset vector in order to get rid of
shmobile_wdt_clock_status.

This work was rebased on top of tag renesas-devel-20180122-v4.15-rc9
from the below repository:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

What do you guys think about this?

Any volunteer for testing this work?

Comments welcome!

Best Regards,

Fabrizio Castro (25):
  ARM: shmobile: Add watchdog support
  ARM: dts: r8a7743: Adjust SMP routine size
  ARM: dts: r8a7745: Adjust SMP routine size
  ARM: dts: r8a7790: Adjust SMP routine size
  ARM: dts: r8a7791: Adjust SMP routine size
  ARM: dts: r8a7792: Adjust SMP routine size
  ARM: dts: r8a7793: Adjust SMP routine size
  ARM: dts: r8a7794: Adjust SMP routine size
  soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
  dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
  watchdog: renesas_wdt: Add R-Car Gen2 support
  ARM: shmobile: rcar-gen2: Add watchdog support
  ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
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

 .../devicetree/bindings/watchdog/renesas-wdt.txt   | 18 +++++--
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |  5 ++
 arch/arm/boot/dts/r8a7743.dtsi                     | 12 ++++-
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |  5 ++
 arch/arm/boot/dts/r8a7745.dtsi                     | 12 ++++-
 arch/arm/boot/dts/r8a7790.dtsi                     | 12 ++++-
 arch/arm/boot/dts/r8a7791.dtsi                     | 12 ++++-
 arch/arm/boot/dts/r8a7792.dtsi                     |  2 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  2 +-
 arch/arm/boot/dts/r8a7794.dtsi                     | 12 ++++-
 arch/arm/configs/shmobile_defconfig                |  1 +
 arch/arm/mach-shmobile/common.h                    |  6 +++
 arch/arm/mach-shmobile/headsmp.S                   | 55 +++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c              |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c              | 13 +++--
 drivers/clk/renesas/r8a7743-cpg-mssr.c             |  2 +
 drivers/clk/renesas/r8a7745-cpg-mssr.c             |  2 +
 drivers/clk/renesas/r8a7790-cpg-mssr.c             |  2 +
 drivers/clk/renesas/r8a7791-cpg-mssr.c             |  2 +
 drivers/clk/renesas/r8a7794-cpg-mssr.c             |  2 +
 drivers/soc/renesas/rcar-rst.c                     | 35 ++++++++++---
 drivers/watchdog/renesas_wdt.c                     | 61 ++++++++++++++++++++--
 22 files changed, 248 insertions(+), 26 deletions(-)

-- 
2.7.4

