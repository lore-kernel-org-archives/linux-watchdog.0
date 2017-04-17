Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49204 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752928AbdDQT3v (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Apr 2017 15:29:51 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/13] MIPS: lantiq: handle RCU register by separate drivers
Date: Mon, 17 Apr 2017 21:29:29 +0200
Message-Id: <20170417192942.32219-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The RCU (Reset controller Unit) register block provides many different 
functionalities. Before they were handed by the code in arch/mips/lantiq
/xway/reset.c, now there are separate drivers for the functionality.
This block provides support for reset controller, GPHY firmware 
loading, USB PHY initialization and cross bar configuration. 

These changes are making the old device tree incompatible with the 
current kernel. The upstream Linux kernel supports loading the device 
tree blob from the boot loader since about one year, the latest 
released vendor kernel does not support loading the device tree from a 
bot loader.

I would prefer if this would go through the mips tree.
There are more patches planed which would convert the Lantiq code 
to the common clock framework.

Hauke Mehrtens (4):
  mtd: lantiq-flash: drop check of boot select
  mtd: spi-falcon: drop check of boot select
  watchdog: lantiq: access boot cause register through regmap
  MIPS: lantiq: remove old GPHY loader code

Martin Blumenstingl (9):
  MIPS: lantiq: Use of_platform_populate instead of __dt_register_buses
  MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD
  MIPS: lantiq: Convert the xbar driver to a platform_driver
  MIPS: lantiq: remove ltq_reset_cause() and ltq_boot_select()
  reset: Add a reset controller driver for the Lantiq XWAY based SoCs
  MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd
  phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module
  Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
  MIPS: lantiq: Remove the arch/mips/lantiq/xway/reset.c implementation

 .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  54 +++
 .../devicetree/bindings/mips/lantiq/rcu.txt        |  82 +++++
 .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 ++
 .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  59 ++++
 .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  43 +++
 MAINTAINERS                                        |   1 +
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   4 -
 arch/mips/lantiq/Kconfig                           |   2 +
 arch/mips/lantiq/falcon/reset.c                    |  22 --
 arch/mips/lantiq/prom.c                            |   3 +-
 arch/mips/lantiq/xway/Makefile                     |   4 +-
 arch/mips/lantiq/xway/reset.c                      | 387 ---------------------
 arch/mips/lantiq/xway/sysctrl.c                    |  69 +---
 arch/mips/lantiq/xway/xrx200_phy_fw.c              | 113 ------
 drivers/mtd/maps/lantiq-flash.c                    |   6 -
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-lantiq-rcu-usb2.c                  | 325 +++++++++++++++++
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lantiq-rcu.c                   | 231 ++++++++++++
 drivers/soc/Makefile                               |   1 +
 drivers/soc/lantiq/Makefile                        |   2 +
 drivers/soc/lantiq/gphy.c                          | 242 +++++++++++++
 drivers/soc/lantiq/xbar.c                          | 100 ++++++
 drivers/spi/spi-falcon.c                           |   5 -
 drivers/watchdog/lantiq_wdt.c                      |  47 ++-
 include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 +
 28 files changed, 1255 insertions(+), 600 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
 delete mode 100644 arch/mips/lantiq/xway/reset.c
 delete mode 100644 arch/mips/lantiq/xway/xrx200_phy_fw.c
 create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
 create mode 100644 drivers/reset/reset-lantiq-rcu.c
 create mode 100644 drivers/soc/lantiq/Makefile
 create mode 100644 drivers/soc/lantiq/gphy.c
 create mode 100644 drivers/soc/lantiq/xbar.c
 create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h

-- 
2.11.0

