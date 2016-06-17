Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64482 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300AbcFQAde (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Jun 2016 20:33:34 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: qipeng.zha@intel.com, linux@roeck-us.net, dvhart@infradead.org,
	linux-kernel.vger.kernel.org@vger.kernel.org,
	jonathan.yong@intel.com
Subject: [PATCH v2 1/2] watchdog: iTCO-wdt handle 5th variation for Apollo Lake
Date: Fri, 17 Jun 2016 00:33:31 +0000
Message-Id: <1466123612-50633-2-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1466123612-50633-1-git-send-email-jonathan.yong@intel.com>
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
 <1466123612-50633-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Apollo Lake Watchdog has the no_reboot flag in the 4th bit.

Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
---
 drivers/watchdog/iTCO_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 0acc6c5..54cab18 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -150,6 +150,7 @@ static inline u32 no_reboot_bit(void)
 	u32 enable_bit;
 
 	switch (iTCO_wdt_private.iTCO_version) {
+	case 5:
 	case 3:
 		enable_bit = 0x00000010;
 		break;
@@ -512,6 +513,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 
 	/* Clear out the (probably old) status */
 	switch (iTCO_wdt_private.iTCO_version) {
+	case 5:
 	case 4:
 		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
 		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
-- 
2.7.3

