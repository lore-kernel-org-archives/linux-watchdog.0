Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCEg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Dec 2018 21:04:36 -0500
From: Yangtao Li <tiny.windzz@gmail.com>
To: wim@linux-watchdog.org, linux@roeck-us.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] watchdog: bcm281xx: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat,  1 Dec 2018 09:51:39 -0500
Message-Id: <20181201145140.8088-2-tiny.windzz@gmail.com>
In-Reply-To: <20181201145140.8088-1-tiny.windzz@gmail.com>
References: <20181201145140.8088-1-tiny.windzz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 1462be9e6fc5..4249b47902bd 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -90,7 +90,7 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
 
 #ifdef CONFIG_BCM_KONA_WDT_DEBUG
 
-static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
+static int bcm_kona_show(struct seq_file *s, void *data)
 {
 	int ctl_val, cur_val;
 	unsigned long flags;
@@ -130,17 +130,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bcm_kona_wdt_dbg_show, inode->i_private);
-}
-
-static const struct file_operations bcm_kona_dbg_operations = {
-	.open		= bcm_kona_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(bcm_kona);
 
 static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
 {
@@ -157,7 +147,7 @@ static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
 		return;
 
 	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
-				&bcm_kona_dbg_operations))
+				&bcm_kona_fops))
 		wdt->debugfs = dir;
 	else
 		debugfs_remove_recursive(dir);
-- 
2.17.0
