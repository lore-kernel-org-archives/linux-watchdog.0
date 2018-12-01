Return-Path: <tiny.windzz@gmail.com>
Return-path: <tiny.windzz@gmail.com>
From: Yangtao Li <tiny.windzz@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	f.fainelli@gmail.com,
	rjui@broadcom.com,
	sbranden@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat,  1 Dec 2018 05:14:17 -0500
Message-Id: <20181201101417.6368-1-tiny.windzz@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
 drivers/watchdog/ie6xx_wdt.c    | 16 +++-------------
 2 files changed, 6 insertions(+), 26 deletions(-)

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
