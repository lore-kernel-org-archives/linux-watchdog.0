Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58353 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdHHWxQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 8 Aug 2017 18:53:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v9 00/16] MIPS: lantiq: handle RCU register by separate drivers
Date: Wed,  9 Aug 2017 00:52:31 +0200
Message-Id: <20170808225247.32266-1-hauke@hauke-m.de>
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

This is based on patches from Martin Blumenstingl and is a preparation 
to convert the Lantiq target to the common clock framework which was 
also started by Martin Blumenstingl.

Changelog:
v9:
 * usb phy: remove ctrl clock, this should be controlled by the USB core,
   not the phy.
 * usb phy: build under COMPILE_TEST
 * usb phy: move code from ltq_rcu_usb2_start_cores() to init() and
   power_on()
 * usb phy: use of_get_address() to get address offset.
 * reset: use of_get_address() to get address offset.

v8:
 * reset: instead of offset-set and offset-status use the reg property 
   and calculate the offset based on that.
 * usb phy: instead of offset-phy and offset-ana use the reg property 
   and calculate the offset based on that.
 * wtd: remove lantiq,xrx200-wdt and use lantiq,xrx100-wdt for that SoC

v7:
 * fix usb phy clock name in sysctrl.c
 * change assert bit setting suggested by Andy
 * Always request lantiq,rcu in fpi bus driver, this driver is only 
   used on xrx200 SoCs, and there it is not optional.

v6:
 * use lantiq,rcu instated of regmap in device tree
 * remove simple-bus from FPI bus
 * add reg entry to devices 

v5:
 * fixed some checkpatch errors and warnings
 * call clk_disable_unprepare() in some error paths where needed in 
   gphy FW and USB phy driver
 * simplify lantiq_rcu_reset_status_timeout() in reset driver
 * use dmam_alloc_coherent() in the gphy fw driver
 * fix CPU0RS register offset for falcon in wdt driver

v4:
 * rename compatible strings to lantiq,<soc>-<core>
 * removed rcu from most compatible string names, these components are 
   only on the RCU register range in these SoCs
 * removed big-endian attribute from fpi-bus.txt and hard code it to 
   that value
 * make gphy driver use reg directly, this register is used exclusively 
   by the gphy firmware loader driver
 * make drivers fetch the regmap from the parent node
 * hard code offset and mask of the boot status registers in the 
   watchdog driver depending on the compatible string probed
 * handle errors in the usb phy device tree parsing
 * use of_device_get_match_data() in multiple drivers
 * extract lantiq_rcu_reset_status_timeout() from the reset driver set 
   function

v3:
 * renamed xbar driver into fpi-bus driver and make it manage the bus,
   this way we make sure it is initialized before the child drivers.
 * converted the lantiq,rcu-syscon into a "regmap" and an "offset"
   property, this way we have a offset property for each register we
   want to access on the regmap.
 * make the gphy PUM clock mandatory.
 * renamed the lantiq,rcu-reset to lantiq,reset-xrx200
 * add binding description for watchdog driver
 * make watchdog driver use offset and mask to find the correct
   register to get the watchdog reset cause bit.
 * use of_platform_default_populate() instead of of_platform_populate()
 * use device_property_read_u32() instead of
   of_property_read_u32_index()
 * changed John's email address to blogic@phrozen.org
 * check the reset bit numbers in the xlate function
 * use platform_get_resource() in FPI bus driver
 * make it possible to unload the GPHY driver

v2:
 * remove the rcu_ prefix for device names in device tree
 * add both clocks to the gphy driver documentation
 * use 2 cells for the reset controller, one for the status bit and one
   for the set bit, they are different for some reset bits.
   reset-status and reset-request attribute were removed then.
 * remove the documentation of the not existing sub nodes of the usb phy
 * remove manual gpio vbus handling in the usb phy driver and use the
   generic phy regulator now.
 * do not check if the usb phy reset is not null, the reset framework does this.
 * do not print an error message when -EPROBE_DEFER was returned

Hauke Mehrtens (10):
  mtd: lantiq-flash: drop check of boot select
  mtd: spi-falcon: drop check of boot select
  watchdog: lantiq: access boot cause register through regmap
  watchdog: lantiq: add device tree binding documentation
  MIPS: lantiq: Convert the fpi bus driver to a platform_driver
  MIPS: lantiq: remove ltq_reset_cause() and ltq_boot_select()
  MIPS: lantiq: remove old reset controller implementation
  MIPS: lantiq: remove old GPHY loader code
  phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module
  MIPS: lantiq: remove old USB PHY initialisation

Martin Blumenstingl (6):
  MIPS: lantiq: Use of_platform_default_populate instead of
    __dt_register_buses
  MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD
  Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
  reset: Add a reset controller driver for the Lantiq XWAY based SoCs
  MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd
  MIPS: lantiq: Remove the arch/mips/lantiq/xway/reset.c implementation

 .../devicetree/bindings/mips/lantiq/fpi-bus.txt    |  31 ++
 .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  36 ++
 .../devicetree/bindings/mips/lantiq/rcu.txt        |  90 +++++
 .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  40 +++
 .../devicetree/bindings/reset/lantiq,reset.txt     |  30 ++
 .../devicetree/bindings/watchdog/lantiq-wdt.txt    |  24 ++
 MAINTAINERS                                        |   1 +
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   4 -
 arch/mips/lantiq/Kconfig                           |   2 +
 arch/mips/lantiq/falcon/reset.c                    |  22 --
 arch/mips/lantiq/prom.c                            |   2 +-
 arch/mips/lantiq/xway/Makefile                     |   4 +-
 arch/mips/lantiq/xway/reset.c                      | 387 ---------------------
 arch/mips/lantiq/xway/sysctrl.c                    |  83 ++---
 arch/mips/lantiq/xway/xrx200_phy_fw.c              | 113 ------
 drivers/mtd/maps/lantiq-flash.c                    |   6 -
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   2 +-
 drivers/phy/lantiq/Kconfig                         |   9 +
 drivers/phy/lantiq/Makefile                        |   1 +
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           | 254 ++++++++++++++
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lantiq.c                       | 212 +++++++++++
 drivers/soc/Makefile                               |   1 +
 drivers/soc/lantiq/Makefile                        |   2 +
 drivers/soc/lantiq/fpi-bus.c                       |  87 +++++
 drivers/soc/lantiq/gphy.c                          | 260 ++++++++++++++
 drivers/spi/spi-falcon.c                           |   5 -
 drivers/watchdog/lantiq_wdt.c                      |  74 +++-
 include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 +
 31 files changed, 1197 insertions(+), 608 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
 delete mode 100644 arch/mips/lantiq/xway/reset.c
 delete mode 100644 arch/mips/lantiq/xway/xrx200_phy_fw.c
 create mode 100644 drivers/phy/lantiq/Kconfig
 create mode 100644 drivers/phy/lantiq/Makefile
 create mode 100644 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
 create mode 100644 drivers/reset/reset-lantiq.c
 create mode 100644 drivers/soc/lantiq/Makefile
 create mode 100644 drivers/soc/lantiq/fpi-bus.c
 create mode 100644 drivers/soc/lantiq/gphy.c
 create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h

-- 
2.11.0

