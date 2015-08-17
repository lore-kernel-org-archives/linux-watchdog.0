Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35721 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbbHQR0i (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Aug 2015 13:26:38 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 4.3
Date: Mon, 17 Aug 2015 10:26:30 -0700
Message-Id: <1439832390-15453-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

This is my watchdog pull request for 4.3. The branch is currently based
on v4.2-rc6. It includes a merge with the immutable branch published by Lee
Jones.

Please consider pulling watchdog updates for Linux 4.3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim-4.3

The tag has been applied on top of the watchdog-next branch. The branch includes
a number of patches I collected over the last few months. It does not include
all submitted patches; only the ones I reviewed and felt comfortable with are
included. Some may already be in your -next branch.

I reviewed all patches and ran build tests as well as source verification tests
with both smatch and spatch. The branch has been on my Linux repository for a
while, so presumably Fenguang's robot will have built the code as well. The most
recent build results are available at http://server.roeck-us.net:8010/builders,
in the watchdog-next column.

If you don't want to apply the entire series, please consider applying whatever
subset you might feel comfortable with.

Thanks,
Guenter

------

The following changes since commit f7644cbfcdf03528f0f450f3940c4985b2291f49:

  Linux 4.2-rc6 (2015-08-09 15:54:30 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-wim-4.3

for you to fetch changes up to e07c1407dcf9d4c5645f753a997d6f24ff93ce97:

  watchdog: at91rm9200: Correct check for syscon_node_to_regmap() errors (2015-08-17 09:34:03 -0700)

----------------------------------------------------------------
Watchdog patches queued for 4.3

watchdog: at91rm9200: Correct check for syscon_node_to_regmap() errors
watchdog: mpc8xxx: allow to compile for MPC512x
watchdog: mpc8xxx: use better error code when watchdog cannot be enabled
watchdog: mpc8xxx: use dynamic memory for device specific data
watchdog: mpc8xxx: use devm_ioremap_resource to map memory
watchdog: mpc8xxx: make use of of_device_get_match_data
Merge tag 'tags/ib-mfd-i2c-x86-watchdog-v4.3' into watchdog-next
watchdog: at91sam9: get and use slow clock
watchdog: lpc18xx_wdt_get_timeleft() can be static
Documentation: dt: binding: atmel-sama5d4-wdt: for SAMA5D4 watchdog driver
drivers: watchdog: add a driver to support SAMA5D4 watchdog timer
watchdog: mpc8xxx: simplify registration
watchdog: mpc8xxx: remove dead code
DT: watchdog: Add NXP LPC18xx Watchdog Timer binding documentation
watchdog: NXP LPC18xx Watchdog Timer Driver
watchdog: gpio-wdt: ping already at startup for always running devices
watchdog: gpio-wdt: be more strict about hw_algo matching
Documentation: watchdog: at91sam9_wdt: add clocks property
watchdog: booke_wdt: Use infrastructure to check timeout limits
watchdog: (nv_tco) add support for MCP79
watchdog: sunxi: fix activation of system reset
watchdog: mtk_wdt: add wdt shutdown callback to disable wdt if enabled
watchdog: mtk_wdt: add suspend/resume support
watchdog: imgpdc: Unregister restart handler on remove
watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint
i2c: i801: Create iTCO device on newer Intel PCHs
mfd: watchdog: iTCO_wdt: Expose watchdog properties using platform data

----------------------------------------------------------------
Alexandre Belloni (2):
      Documentation: watchdog: at91sam9_wdt: add clocks property
      watchdog: at91sam9: get and use slow clock

Ariel D'Alessandro (2):
      watchdog: NXP LPC18xx Watchdog Timer Driver
      DT: watchdog: Add NXP LPC18xx Watchdog Timer binding documentation

Bjorn Andersson (1):
      watchdog: at91rm9200: Correct check for syscon_node_to_regmap() errors

Ezequiel Garcia (1):
      watchdog: imgpdc: Unregister restart handler on remove

Francesco Lavra (1):
      watchdog: sunxi: fix activation of system reset

Greta Zhang (2):
      watchdog: mtk_wdt: add suspend/resume support
      watchdog: mtk_wdt: add wdt shutdown callback to disable wdt if enabled

Guenter Roeck (2):
      watchdog: booke_wdt: Use infrastructure to check timeout limits
      Merge tag 'tags/ib-mfd-i2c-x86-watchdog-v4.3' into watchdog-next

Matt Fleming (2):
      mfd: watchdog: iTCO_wdt: Expose watchdog properties using platform data
      watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint

Mika Westerberg (1):
      i2c: i801: Create iTCO device on newer Intel PCHs

Uwe Kleine-König (9):
      watchdog: gpio-wdt: be more strict about hw_algo matching
      watchdog: gpio-wdt: ping already at startup for always running devices
      watchdog: mpc8xxx: remove dead code
      watchdog: mpc8xxx: simplify registration
      watchdog: mpc8xxx: make use of of_device_get_match_data
      watchdog: mpc8xxx: use devm_ioremap_resource to map memory
      watchdog: mpc8xxx: use dynamic memory for device specific data
      watchdog: mpc8xxx: use better error code when watchdog cannot be enabled
      watchdog: mpc8xxx: allow to compile for MPC512x

Vivien Didelot (1):
      watchdog: (nv_tco) add support for MCP79

Wenyou Yang (2):
      drivers: watchdog: add a driver to support SAMA5D4 watchdog timer
      Documentation: dt: binding: atmel-sama5d4-wdt: for SAMA5D4 watchdog driver

kbuild test robot (1):
      watchdog: lpc18xx_wdt_get_timeleft() can be static

 .../bindings/watchdog/atmel-sama5d4-wdt.txt        |  35 +++
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   2 +
 .../devicetree/bindings/watchdog/lpc18xx-wdt.txt   |  19 ++
 drivers/i2c/busses/i2c-i801.c                      | 120 +++++++-
 drivers/mfd/lpc_ich.c                              |  32 +-
 drivers/platform/x86/intel_pmc_ipc.c               |   9 +-
 drivers/watchdog/Kconfig                           |  25 +-
 drivers/watchdog/Makefile                          |   2 +
 drivers/watchdog/at91rm9200_wdt.c                  |   2 +-
 drivers/watchdog/at91sam9_wdt.c                    |  22 +-
 drivers/watchdog/at91sam9_wdt.h                    |   2 +
 drivers/watchdog/booke_wdt.c                       |   4 +-
 drivers/watchdog/gpio_wdt.c                        |  64 ++--
 drivers/watchdog/iTCO_wdt.c                        |  82 +++--
 drivers/watchdog/imgpdc_wdt.c                      |   1 +
 drivers/watchdog/lpc18xx_wdt.c                     | 340 +++++++++++++++++++++
 drivers/watchdog/mpc8xxx_wdt.c                     | 156 ++++------
 drivers/watchdog/mtk_wdt.c                         |  39 +++
 drivers/watchdog/nv_tco.c                          |   2 +
 drivers/watchdog/sama5d4_wdt.c                     | 280 +++++++++++++++++
 drivers/watchdog/sunxi_wdt.c                       |   2 +-
 include/linux/mfd/lpc_ich.h                        |   6 -
 include/linux/platform_data/itco_wdt.h             |  19 ++
 23 files changed, 1086 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
 create mode 100644 drivers/watchdog/lpc18xx_wdt.c
 create mode 100644 drivers/watchdog/sama5d4_wdt.c
 create mode 100644 include/linux/platform_data/itco_wdt.h
