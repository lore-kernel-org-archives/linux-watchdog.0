Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:13821
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933675AbaDCBrx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Apr 2014 21:47:53 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <linux@roeck-us.net>, <shawn.guo@linaro.org>,
	<linux-watchdog@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 0/2] imx2-wdt: Add regmap-mmio support
Date: Thu, 3 Apr 2014 09:04:17 +0800
Message-ID: <1396487059-15298-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patches are preparing for Vybird, LS1 and LS2. And on LS1 the IP will
in BE mode.

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

 drivers/watchdog/imx2_wdt.c | 62 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

-- 
1.8.4


