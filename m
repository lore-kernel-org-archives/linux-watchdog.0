Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:1245 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbcERD0L (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 May 2016 23:26:11 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: qipeng.zha@intel.com, jonathan.yong@intel.com
Subject: [PATCH 1/2] watchdog: iTCO-wdt handle 5th variation for Apollo Lake
Date: Wed, 18 May 2016 03:26:11 +0000
Message-Id: <1463541972-19758-2-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Apollo Lake Watchdog has the no_reboot flag in the 4th bit.

Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
---
 drivers/watchdog/iTCO_wdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 0acc6c5..eccba32 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -150,6 +150,9 @@ static inline u32 no_reboot_bit(void)
 	u32 enable_bit;
 
 	switch (iTCO_wdt_private.iTCO_version) {
+	case 5:
+		enable_bit = 0x00000008;
+		break;
 	case 3:
 		enable_bit = 0x00000010;
 		break;
@@ -512,6 +515,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 
 	/* Clear out the (probably old) status */
 	switch (iTCO_wdt_private.iTCO_version) {
+	case 5:
 	case 4:
 		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
 		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
-- 
2.7.3

