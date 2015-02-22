Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:53566 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751827AbbBVDEC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Feb 2015 22:04:02 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 9DF5128E318
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Feb 2015 02:55:33 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/27] watchdog: bcm281xx: Remove use of seq_printf return value
Date: Sat, 21 Feb 2015 18:53:48 -0800
Message-Id: <e370a587d7aa9f2bf7b409129a2283a10a134885.1424573328.git.joe@perches.com>
In-Reply-To: <cover.1424573328.git.joe@perches.com>
References: <cover.1424573328.git.joe@perches.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The seq_printf return value, because it's frequently misused,
will eventually be converted to void.

See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
     seq_has_overflowed() and make public")

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/watchdog/bcm_kona_wdt.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 4e37db3..22d8ae6 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -99,12 +99,14 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
 
 static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 {
-	int ctl_val, cur_val, ret;
+	int ctl_val, cur_val;
 	unsigned long flags;
 	struct bcm_kona_wdt *wdt = s->private;
 
-	if (!wdt)
-		return seq_puts(s, "No device pointer\n");
+	if (!wdt) {
+		seq_puts(s, "No device pointer\n");
+		return 0;
+	}
 
 	spin_lock_irqsave(&wdt->lock, flags);
 	ctl_val = secure_register_read(wdt, SECWDOG_CTRL_REG);
@@ -112,7 +114,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 	spin_unlock_irqrestore(&wdt->lock, flags);
 
 	if (ctl_val < 0 || cur_val < 0) {
-		ret = seq_puts(s, "Error accessing hardware\n");
+		seq_puts(s, "Error accessing hardware\n");
 	} else {
 		int ctl, cur, ctl_sec, cur_sec, res;
 
@@ -121,15 +123,18 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 		cur = cur_val & SECWDOG_COUNT_MASK;
 		ctl_sec = TICKS_TO_SECS(ctl, wdt);
 		cur_sec = TICKS_TO_SECS(cur, wdt);
-		ret = seq_printf(s, "Resolution: %d / %d\n"
-				"Control: %d s / %d (%#x) ticks\n"
-				"Current: %d s / %d (%#x) ticks\n"
-				"Busy count: %lu\n", res,
-				wdt->resolution, ctl_sec, ctl, ctl, cur_sec,
-				cur, cur, wdt->busy_count);
+		seq_printf(s,
+			   "Resolution: %d / %d\n"
+			   "Control: %d s / %d (%#x) ticks\n"
+			   "Current: %d s / %d (%#x) ticks\n"
+			   "Busy count: %lu\n",
+			   res, wdt->resolution,
+			   ctl_sec, ctl, ctl,
+			   cur_sec, cur, cur,
+			   wdt->busy_count);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
-- 
2.1.2

