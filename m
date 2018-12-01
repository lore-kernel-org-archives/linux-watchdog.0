Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33106 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCEj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Dec 2018 21:04:39 -0500
From: Yangtao Li <tiny.windzz@gmail.com>
To: wim@linux-watchdog.org, linux@roeck-us.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat,  1 Dec 2018 09:51:40 -0500
Message-Id: <20181201145140.8088-3-tiny.windzz@gmail.com>
In-Reply-To: <20181201145140.8088-1-tiny.windzz@gmail.com>
References: <20181201145140.8088-1-tiny.windzz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/watchdog/ie6xx_wdt.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 78c2541f5d52..8de9fb1ed371 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -193,7 +193,7 @@ static struct watchdog_device ie6xx_wdt_dev = {
 
 #ifdef CONFIG_DEBUG_FS
 
-static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
+static int ie6xx_wdt_show(struct seq_file *s, void *unused)
 {
 	seq_printf(s, "PV1   = 0x%08x\n",
 		inl(ie6xx_wdt_data.sch_wdtba + PV1));
@@ -212,23 +212,13 @@ static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int ie6xx_wdt_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ie6xx_wdt_dbg_show, NULL);
-}
-
-static const struct file_operations ie6xx_wdt_dbg_operations = {
-	.open		= ie6xx_wdt_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ie6xx_wdt);
 
 static void ie6xx_wdt_debugfs_init(void)
 {
 	/* /sys/kernel/debug/ie6xx_wdt */
 	ie6xx_wdt_data.debugfs = debugfs_create_file("ie6xx_wdt",
-		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_dbg_operations);
+		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_fops);
 }
 
 static void ie6xx_wdt_debugfs_exit(void)
-- 
2.17.0
