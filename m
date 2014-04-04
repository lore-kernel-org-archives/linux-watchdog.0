Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from [216.32.180.14] ([216.32.180.14]:4924 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752440AbaDDCSu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Apr 2014 22:18:50 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv5 0/2] imx2-wdt: Add regmap-mmio support
Date: Fri, 4 Apr 2014 09:33:23 +0800
Message-ID: <1396575205-24394-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patches are preparing for Vybird, LS1 and LS2. And on LS1 the IP will
in BE mode.

Changes in V5:
- Select the REGMAP_MMIO default for IMX2 Watchdog.

Changes in V4:
- Add the explanation why uing the regmap APIs.

Changes in V3:
- convert to use regmap-mmio API.

Changes in V2:
- Add the detail information in the commit comment.
- 'big-endians' --> 'big-endian'.





Xiubo Li (2):
  watchdog: imx2_wdt: Sort the header files alphabetically
  watchdog: imx2_wdt: convert to use regmap API.

 drivers/watchdog/Kconfig    |  1 +
 drivers/watchdog/imx2_wdt.c | 62 +++++++++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 24 deletions(-)

-- 
1.8.4


