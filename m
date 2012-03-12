Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:33298 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750867Ab2CLEXP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:15 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 00/22] watchdog: ARM watchdogs: sp805 & mpcore updates & fixes
Date: Mon, 12 Mar 2012 09:51:55 +0530
Message-ID: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

This patchset contains fixes and updates for ARM watchdog drivers sp805 and
mpcore.

Changes since V1:
- Included patches for sp805 driver.
- Removed: wdt->clk = NULL from mpcore driver, and use IS_ERR() to check if
  clock is supported or not.
- Adapted to watchdog core for both the drivers.
- two patches for watchdog core added
- add patch to use __raw_readl{writel} instead of readl{writel}
- taken care of few more review comments.

Changes are mentioned in following patch list:

watchdog/mpcore: updates & fixes
Viresh Kumar (22):
  watchdog: Add is_wdt_active() routine
  watchdog: Add support for WDIOC_GETTIMELEFT IOCTL in watchdog core
  watchdog/mpcore_wdt: Rename dev to pdev for pointing to struct
    platform_device
  watchdog/mpcore_wdt: Use devm routines
  watchdog/mpcore_wdt: Allow platform_get_irq() to fail
  watchdog/mpcore_wdt: convert to watchdog core
  watchdog/mpcore_wdt: Fix multiline comments
  watchdog/mpcore_wdt: Arrange #includes in alphabetical order
  watchdog/mpcore_wdt: Set default heartbeat in probe instead of init
  watchdog/mpcore_wdt: Use dev_(crit, err, info) instead of dev_printk
  watchdog/mpcore_wdt: convert to use module_platform_driver()
  watchdog/mpcore_wdt: Add support for dev_pm_ops interface
  watchdog/mpcore_wdt: disable wdt in suspend only if it is busy
  watchdog/mpcore_wdt: replace (__raw_)readl/writel with lighter
    *_relaxed variants
  watchdog/mpcore_wdt: Add support for WDIOC_GETBOOTSTATUS IOCTL
  watchdog/mpcore_wdt: Add clock framework support
  watchdog/mpcore_wdt: use correct clk_rate to program timeout
  watchdog/sp805: Fix documentation style comment
  watchdog/sp805: replace readl/writel with lighter _relaxed variants
  watchdog/sp805: Use devm routines
  watchdog/sp805: convert to watchdog core
  watchdog/sp805: Add clk_{un}prepare support

 .../watchdog/convert_drivers_to_kernel_api.txt     |    4 +
 Documentation/watchdog/watchdog-kernel-api.txt     |    2 +
 arch/arm/include/asm/smp_twd.h                     |   12 +
 drivers/watchdog/Kconfig                           |    2 +
 drivers/watchdog/mpcore_wdt.c                      |  573 +++++++++-----------
 drivers/watchdog/sp805_wdt.c                       |  309 ++++-------
 drivers/watchdog/via_wdt.c                         |    2 +-
 drivers/watchdog/watchdog_dev.c                    |   11 +-
 include/linux/watchdog.h                           |    7 +
 9 files changed, 408 insertions(+), 514 deletions(-)

-- 
1.7.8.110.g4cb5d

