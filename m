Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:55474 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab2FHNJ7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jun 2012 09:09:59 -0400
From: Tony Zelenoff <antonz@parallels.com>
To: <linux-watchdog@vger.kernel.org>
CC: <wim@iguana.be>, <antonz@parallels.com>
Subject: [RFC 0/3] watchdog: do not allow reboot without CAP_SYS_BOOT set
Date: Fri, 8 Jun 2012 17:09:54 +0400
Message-ID: <1339160997-160581-1-git-send-email-antonz@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The CAP_SYS_BOOT capability required to reboot hardware node. But watchdog
writers are not checked for this capability. So, the process may reboot
hardware node even if it has no any capabilities to do it.

I suggest this patchset to fix this issue. Opinions are welcome.

Tony Zelenoff (3):
  watchdog: check CAP_SYS_BOOT at watchdog open
  watchdog: move err initialization to place it used
  watchdog: connect watchdog_may_open to legacy code

 drivers/watchdog/acquirewdt.c         |    3 +++
 drivers/watchdog/advantechwdt.c       |    3 +++
 drivers/watchdog/alim1535_wdt.c       |    3 +++
 drivers/watchdog/alim7101_wdt.c       |    3 +++
 drivers/watchdog/ar7_wdt.c            |    3 +++
 drivers/watchdog/at32ap700x_wdt.c     |    3 +++
 drivers/watchdog/at91rm9200_wdt.c     |    3 +++
 drivers/watchdog/at91sam9_wdt.c       |    3 +++
 drivers/watchdog/ath79_wdt.c          |    3 +++
 drivers/watchdog/bcm47xx_wdt.c        |    3 +++
 drivers/watchdog/bcm63xx_wdt.c        |    3 +++
 drivers/watchdog/bfin_wdt.c           |    3 +++
 drivers/watchdog/booke_wdt.c          |    3 +++
 drivers/watchdog/cpu5wdt.c            |    3 +++
 drivers/watchdog/cpwd.c               |    7 ++++++-
 drivers/watchdog/davinci_wdt.c        |    3 +++
 drivers/watchdog/dw_wdt.c             |    3 +++
 drivers/watchdog/eurotechwdt.c        |    3 +++
 drivers/watchdog/f71808e_wdt.c        |    3 +++
 drivers/watchdog/gef_wdt.c            |    3 +++
 drivers/watchdog/geodewdt.c           |    3 +++
 drivers/watchdog/hpwdt.c              |    3 +++
 drivers/watchdog/i6300esb.c           |    3 +++
 drivers/watchdog/ib700wdt.c           |    3 +++
 drivers/watchdog/ibmasr.c             |    3 +++
 drivers/watchdog/imx2_wdt.c           |    3 +++
 drivers/watchdog/indydog.c            |    3 +++
 drivers/watchdog/intel_scu_watchdog.c |    2 ++
 drivers/watchdog/iop_wdt.c            |    3 +++
 drivers/watchdog/it8712f_wdt.c        |    4 ++++
 drivers/watchdog/it87_wdt.c           |    3 +++
 drivers/watchdog/ixp4xx_wdt.c         |    3 +++
 drivers/watchdog/ks8695_wdt.c         |    3 +++
 drivers/watchdog/lantiq_wdt.c         |    3 +++
 drivers/watchdog/m54xx_wdt.c          |    3 +++
 drivers/watchdog/machzwd.c            |    3 +++
 drivers/watchdog/mixcomwd.c           |    3 +++
 drivers/watchdog/mpc8xxx_wdt.c        |    4 ++++
 drivers/watchdog/mpcore_wdt.c         |    7 ++++++-
 drivers/watchdog/mtx-1_wdt.c          |    3 +++
 drivers/watchdog/mv64x60_wdt.c        |    3 +++
 drivers/watchdog/nuc900_wdt.c         |    2 ++
 drivers/watchdog/nv_tco.c             |    3 +++
 drivers/watchdog/octeon-wdt-main.c    |    3 +++
 drivers/watchdog/of_xilinx_wdt.c      |    3 +++
 drivers/watchdog/omap_wdt.c           |   10 ++++++++--
 drivers/watchdog/orion_wdt.c          |    3 +++
 drivers/watchdog/pc87413_wdt.c        |    3 +++
 drivers/watchdog/pcwd.c               |    3 +++
 drivers/watchdog/pcwd_pci.c           |    3 +++
 drivers/watchdog/pcwd_usb.c           |    3 +++
 drivers/watchdog/pika_wdt.c           |    3 +++
 drivers/watchdog/pnx833x_wdt.c        |    3 +++
 drivers/watchdog/rc32434_wdt.c        |    3 +++
 drivers/watchdog/rdc321x_wdt.c        |    3 +++
 drivers/watchdog/riowd.c              |    3 +++
 drivers/watchdog/sa1100_wdt.c         |    3 +++
 drivers/watchdog/sb_wdog.c            |    3 +++
 drivers/watchdog/sbc60xxwdt.c         |    3 +++
 drivers/watchdog/sbc7240_wdt.c        |    3 +++
 drivers/watchdog/sbc8360.c            |    3 +++
 drivers/watchdog/sbc_epx_c3.c         |    3 +++
 drivers/watchdog/sbc_fitpc2_wdt.c     |    3 +++
 drivers/watchdog/sc1200wdt.c          |    3 +++
 drivers/watchdog/sc520_wdt.c          |    3 +++
 drivers/watchdog/sch311x_wdt.c        |    3 +++
 drivers/watchdog/scx200_wdt.c         |    3 +++
 drivers/watchdog/smsc37b787_wdt.c     |    3 +++
 drivers/watchdog/sp5100_tco.c         |    3 +++
 drivers/watchdog/stmp3xxx_wdt.c       |    3 +++
 drivers/watchdog/ts72xx_wdt.c         |    7 ++++++-
 drivers/watchdog/twl4030_wdt.c        |    7 ++++++-
 drivers/watchdog/w83627hf_wdt.c       |    3 +++
 drivers/watchdog/w83697hf_wdt.c       |    3 +++
 drivers/watchdog/w83697ug_wdt.c       |    3 +++
 drivers/watchdog/w83877f_wdt.c        |    3 +++
 drivers/watchdog/w83977f_wdt.c        |    3 +++
 drivers/watchdog/wafer5823wdt.c       |    3 +++
 drivers/watchdog/watchdog_dev.c       |   25 +++++++++++++++++++++++--
 drivers/watchdog/wdrtas.c             |    3 +++
 drivers/watchdog/wdt.c                |    3 +++
 drivers/watchdog/wdt285.c             |    3 +++
 drivers/watchdog/wdt977.c             |    3 +++
 drivers/watchdog/wdt_pci.c            |    3 +++
 drivers/watchdog/xen_wdt.c            |    3 +++
 include/linux/watchdog.h              |    3 +++
 86 files changed, 295 insertions(+), 8 deletions(-)

