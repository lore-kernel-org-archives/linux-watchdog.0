Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43769 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751928AbdLXVE0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Dec 2017 16:04:26 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/12] watchdog: sp5100_tco: Use request_muxed_region where possible
Date: Sun, 24 Dec 2017 13:04:08 -0800
Message-Id: <1514149457-20273-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use request_muxed_region for multiplexed IO memory regions.
Also, SP5100_IO_PM_INDEX_REG/SP5100_IO_PM_DATA_REG are only
used during initialization; it is unnecessary to keep the
address range reserved.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 05f9d27a306a..11109ac959e2 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -379,8 +379,8 @@ static unsigned char sp5100_tco_setupdevice(void)
 	}
 
 	/* Request the IO ports used by this driver */
-	if (!request_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE,
-			    dev_name)) {
+	if (!request_muxed_region(SP5100_IO_PM_INDEX_REG,
+				  SP5100_PM_IOPORTS_SIZE, dev_name)) {
 		pr_err("I/O address 0x%04x already in use\n",
 		       SP5100_IO_PM_INDEX_REG);
 		goto exit;
@@ -468,6 +468,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 	 */
 	tco_timer_stop();
 
+	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
 	/* Done */
 	return 1;
 
@@ -521,7 +522,6 @@ static int sp5100_tco_init(struct platform_device *dev)
 exit:
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
 	return ret;
 }
 
@@ -535,7 +535,6 @@ static void sp5100_tco_cleanup(void)
 	misc_deregister(&sp5100_tco_miscdev);
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
 }
 
 static int sp5100_tco_remove(struct platform_device *dev)
-- 
2.7.4

