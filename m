Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:15763 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753090AbaCYKUH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Mar 2014 06:20:07 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <w.sang@pengutronix.de>,
	<linux-watchdog@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/2] Add big endian support
Date: Tue, 25 Mar 2014 17:35:30 +0800
Message-ID: <1395740132-21396-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patches are preparing for Vybird, LS1 and LS2. And on LS1 the IP will
in BE mode.

And this has been test on Vybird.


Xiubo Li (2):
  watchdog: imx2_wdt: Sort the header files alphabetically
  watchdog: imx2_wdt: Add big-endian support

 drivers/watchdog/imx2_wdt.c | 52 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 15 deletions(-)

-- 
1.8.4


