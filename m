Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:13526 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751217AbeAaSYy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 13:24:54 -0500
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
Subject: [RFC v4 00/26] Fix watchdog on Renesas R-Car Gen2 and RZ/G1
Date: Wed, 31 Jan 2018 18:24:04 +0000
Message-Id: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear All,

the forth version of this series aims at consolidating the watchdog fix.
There is a discussion still in progress about the changes to the
watchdog driver, please see the following for more information:
https://patchwork.kernel.org/patch/10192435/

It doesn't look like leaving the restart handler in for Gen3 is going
to do any harm (but it may be unwelcome), perhaps esplicitly setting
its priority to a medium level (128) will help its adoption on Gen3
as well? This is what this particular version is proposing.

Also, although the latest implmentation of the reset vector hasn't
raised any problem so far, it hasn't received any feedback either.
Please do look into it to espose problems and weaknesses (if any).

Finally, it would be great if someone could test this patch set on his
Gen2/Gen3/RZ/G1 board, and it would be awesome if that board was a
Lager with all of the cores enabled and working at the same time ;-)

Best Regards,

Fabrizio Castro (26):
  ARM: shmobile: Add watchdog support
  ARM: dts: r8a7743: Adjust SMP routine size
  ARM: dts: r8a7745: Adjust SMP routine size
  ARM: dts: r8a7790: Adjust SMP routine size
  ARM: dts: r8a7791: Adjust SMP routine size
  ARM: dts: r8a7792: Adjust SMP routine size
  ARM: dts: r8a7793: Adjust SMP routine size
  ARM: dts: r8a7794: Adjust SMP routine size
  soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
  ARM: shmobile: rcar-gen2: Add watchdog support
  dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
  watchdog: renesas_wdt: Add R-Car Gen2 support
  watchdog: renesas_wdt: Add restart handler
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

 .../devicetree/bindings/watchdog/renesas-wdt.txt   | 19 +++++--
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
 drivers/soc/renesas/rcar-rst.c                     | 35 +++++++++---
 drivers/watchdog/renesas_wdt.c                     | 62 ++++++++++++++++++++--
 22 files changed, 250 insertions(+), 26 deletions(-)

-- 
2.7.4

