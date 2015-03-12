Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40581 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752806AbbCLMIM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Mar 2015 08:08:12 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v5 00/10] Atmel System Timer cleanups
Date: Thu, 12 Mar 2015 13:07:24 +0100
Message-Id: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch set cleans up the system timer driver.

The main goal is to get rid of the mach/ headers dependency. At the same time,
it introduces proper probing and locking (using a regmap) for the watchdog
driver.

This is based on 4.0-rc1 and will have two merge conflicts with my cleanup #1 in
mach-at91/at91rm9200.c

It also needs this patch to probe the watchdog properly:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327274.html

Changes in v5:
 - Documented the watchdog compatible
 - Switched to simple-mfd to probe the system timer subnodes
 - Selected ATMEL_ST from mach-at91/Kconfig instead of using def_bool SOC_AT91RM9200
 - Reordered the atmel-st probe cleanup and its move to driver/clocksource
 - Added a patch to replace setup_irq by request_irq
 - Merged the reset handling in the watchdog timer as we are using the watchdog
   anyway to reset the board.
 - Used a simple space after a #define for registers

Changes in v4:
 - Added MODULE_* metadata in at91rm9200-reset
 - Proper copyright in at91rm9200-reset
 - Use BIT() in atmel-st.h
 - changed MODULE_ALIAS in at91rm9200_wdt.c

Changes in v3:
 - stop using an mfd and get the syscon directly from the watchdog driver
 - introduce a proper reset driver to handle reset

Changes in v2:
 - cleaned up more includes in the watchdog driver
 - stop using if OF when selecting CLKSRC_OF
 - stop initializing .owner


Alexandre Belloni (10):
  ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
  mfd: syscon: Add atmel system timer registers definition
  watchdog: at91rm9200: use the system timer syscon
  watchdog: at91rm9200: implement restart handler
  ARM: at91: at91rm9200: remove deprecated arm_pm_restart
  ARM: at91: properly initialize timer
  ARM: at91: time: move the system timer driver to drivers/clocksource
  clocksource: atmel-st: use syscon/regmap
  clocksource: atmel-st: remove mach/hardware dependency
  ARM: at91: remove useless include

 .../devicetree/bindings/arm/atmel-at91.txt         |   4 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   6 +-
 arch/arm/mach-at91/Kconfig                         |   1 +
 arch/arm/mach-at91/Makefile                        |   2 +-
 arch/arm/mach-at91/at91rm9200.c                    |  19 ----
 arch/arm/mach-at91/generic.h                       |   3 -
 arch/arm/mach-at91/include/mach/at91_st.h          |  61 -----------
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 .../clocksource/timer-atmel-st.c                   | 115 ++++++++-------------
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/at91rm9200_wdt.c                  |  61 +++++++++--
 include/linux/mfd/syscon/atmel-st.h                |  49 +++++++++
 13 files changed, 164 insertions(+), 164 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_st.h
 rename arch/arm/mach-at91/at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c (74%)
 create mode 100644 include/linux/mfd/syscon/atmel-st.h

-- 
2.1.0

