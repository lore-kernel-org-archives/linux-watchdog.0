Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57173 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbbHREsY (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:24 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id A586991590
	for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2015 04:48:24 +0000 (UTC)
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>
Subject: [PATCH 00/37] watchdog: Fix parent of watchdog devices
Date: Tue, 18 Aug 2015 10:17:33 +0530
Message-Id: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I posted a query here (https://lkml.org/lkml/2015/8/10/19), but did not get any
feedback. So, thought to post patches and to seek response.

I need some way to identify the driver/module for a given watchdog node say
/dev/watchdog0.

Documentation/watchdog/watchdog-api.txt says:
identity                a string identifying the watchdog driver

However, all the watchdog driver does not define identity as DRV_NAME.

Otherway could be to look for /sys/class/watchdog/watchdog0/device/modalias.

However, many wdt devices does not set its parent and so, we do not see an entry
for /sys/class/watchdog/watchdog0/device/ in sysfs.

This patch set fixes parent for wdt drivers written in watchdog-core framework.

Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- They do not
have any parent. Not sure, how we can identify driver for these devices.

~Pratyush

Pratyush Anand (37):
  mei: wd: Fix parent of watchdog_device
  watchdog: wm8350: Fix parent of watchdog_device
  watchdog: wm831x: Fix parent of watchdog_device
  watchdog: via: Fix parent of watchdog_device
  watchdog: ux500: Fix parent of watchdog_device
  watchdog: txx9wdt: Fix parent of watchdog_device
  watchdog: twl4030: Fix parent of watchdog_device
  watchdog: tegra: Fix parent of watchdog_device
  watchdog: stmp3xxx_rtc: Fix parent of watchdog_device
  watchdog: st_lpc: Fix parent of watchdog_device
  watchdog: sp805: Fix parent of watchdog_device
  watchdog: sirfsoc: Fix parent of watchdog_device
  watchdog: sh: Fix parent of watchdog_device
  watchdog: s3c2410: Fix parent of watchdog_device
  watchdog: rt2880: Fix parent of watchdog_device
  watchdog: retu: Fix parent of watchdog_device
  watchdog: qcom: Fix parent of watchdog_device
  watchdog: pnx4008: Fix parent of watchdog_device
  watchdog: orion: Fix parent of watchdog_device
  watchdog: omap: Fix parent of watchdog_device
  watchdog: menf21bmc: Fix parent of watchdog_device
  watchdog: mena21: Fix parent of watchdog_device
  watchdog: jz4740: Fix parent of watchdog_device
  watchdog: intel-mid: Fix parent of watchdog_device
  watchdog: ie6xx: Fix parent of watchdog_device
  watchdog: gpio: Fix parent of watchdog_device
  watchdog: ep93xx: Fix parent of watchdog_device
  watchdog: digicolor: Fix parent of watchdog_device
  watchdog: davinci: Fix parent of watchdog_device
  watchdog: da9063: Fix parent of watchdog_device
  watchdog: da9062: Fix parent of watchdog_device
  watchdog: da9055: Fix parent of watchdog_device
  watchdog: da9052: Fix parent of watchdog_device
  watchdog: coh901327: Fix parent of watchdog_device
  watchdog: bcm_kona: Fix parent of watchdog_device
  watchdog: bcm47xx: Fix parent of watchdog_device
  watchdog: bcm2835: Fix parent of watchdog_device

 drivers/misc/mei/wd.c               | 1 +
 drivers/watchdog/bcm2835_wdt.c      | 1 +
 drivers/watchdog/bcm47xx_wdt.c      | 1 +
 drivers/watchdog/bcm_kona_wdt.c     | 1 +
 drivers/watchdog/coh901327_wdt.c    | 1 +
 drivers/watchdog/da9052_wdt.c       | 1 +
 drivers/watchdog/da9055_wdt.c       | 1 +
 drivers/watchdog/da9062_wdt.c       | 1 +
 drivers/watchdog/da9063_wdt.c       | 1 +
 drivers/watchdog/davinci_wdt.c      | 1 +
 drivers/watchdog/digicolor_wdt.c    | 1 +
 drivers/watchdog/ep93xx_wdt.c       | 1 +
 drivers/watchdog/gpio_wdt.c         | 1 +
 drivers/watchdog/ie6xx_wdt.c        | 1 +
 drivers/watchdog/intel-mid_wdt.c    | 1 +
 drivers/watchdog/jz4740_wdt.c       | 1 +
 drivers/watchdog/mena21_wdt.c       | 1 +
 drivers/watchdog/menf21bmc_wdt.c    | 1 +
 drivers/watchdog/omap_wdt.c         | 1 +
 drivers/watchdog/orion_wdt.c        | 1 +
 drivers/watchdog/pnx4008_wdt.c      | 1 +
 drivers/watchdog/qcom-wdt.c         | 1 +
 drivers/watchdog/retu_wdt.c         | 1 +
 drivers/watchdog/rt2880_wdt.c       | 1 +
 drivers/watchdog/s3c2410_wdt.c      | 1 +
 drivers/watchdog/shwdt.c            | 1 +
 drivers/watchdog/sirfsoc_wdt.c      | 1 +
 drivers/watchdog/sp805_wdt.c        | 1 +
 drivers/watchdog/st_lpc_wdt.c       | 1 +
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 1 +
 drivers/watchdog/tegra_wdt.c        | 1 +
 drivers/watchdog/twl4030_wdt.c      | 1 +
 drivers/watchdog/txx9wdt.c          | 1 +
 drivers/watchdog/ux500_wdt.c        | 1 +
 drivers/watchdog/via_wdt.c          | 1 +
 drivers/watchdog/wm831x_wdt.c       | 1 +
 drivers/watchdog/wm8350_wdt.c       | 1 +
 37 files changed, 37 insertions(+)

-- 
2.4.3

