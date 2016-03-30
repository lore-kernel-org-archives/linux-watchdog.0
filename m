Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43782 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbcC3P3J (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2016 11:29:09 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/4] watchdog: add driver for Renesas Gen3 WDT watchdogs
Date: Wed, 30 Mar 2016 17:28:41 +0200
Message-Id: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

So, after a few rounds of internal review, I think we can go "public" and
finally post this driver to the watchdog mailing-list, too. Of course, the dts
and defconfig changes should go via Simon's tree once the driver is accepted.

To use this driver, you need a recent firmware/uboot which initializes the
WDTRSTCR register which can only be changed in secure mode. 'md 0xe6160054 4'
should give you 0x8002 or something else with bit 15 set and bit 0 cleared.

Also, you need the clock enablement patches which just have been posted in
their newest version to the renesas-soc mailing list and are also in
close-to-be-applied state.

A complete branch to test can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/v8-wdt

Please review, test, comment...

Thanks,

   Wolfram

Wolfram Sang (4):
  watchdog: renesas-wdt: add driver
  arm64: dts: r8a7795: Add RWDT node
  arm64: dts: salvator-x: Enable watchdog timer
  arm64: defconfig: enable Renesas Watchdog Timer

 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  25 +++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   5 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   8 +
 arch/arm64/configs/defconfig                       |   2 +
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/renesas_wdt.c                     | 212 +++++++++++++++++++++
 7 files changed, 261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
 create mode 100644 drivers/watchdog/renesas_wdt.c

-- 
2.7.0

