Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from pequod.mess.org ([188.220.58.213]:38296 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab1HWVjY (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 23 Aug 2011 17:39:24 -0400
Date: Tue, 23 Aug 2011 22:30:09 +0100
From: Sean Young <sean@mess.org>
To: Wim van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] Remove unnecessary cast.
Message-ID: <20110823213009.GA23418@pequod.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/watchdog/sc520_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
index 52b63f2..b284040 100644
--- a/drivers/watchdog/sc520_wdt.c
+++ b/drivers/watchdog/sc520_wdt.c
@@ -398,7 +398,7 @@ static int __init sc520_wdt_init(void)
 							WATCHDOG_TIMEOUT);
 	}
 
-	wdtmrctl = ioremap((unsigned long)(MMCR_BASE + OFFS_WDTMRCTL), 2);
+	wdtmrctl = ioremap(MMCR_BASE + OFFS_WDTMRCTL, 2);
 	if (!wdtmrctl) {
 		printk(KERN_ERR PFX "Unable to remap memory\n");
 		rc = -ENOMEM;
-- 
1.7.6

