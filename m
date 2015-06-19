Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56057 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbbFSPB2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Jun 2015 11:01:28 -0400
Date: Fri, 19 Jun 2015 17:01:25 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"Mingarelli, Thomas" <Thomas.Mingarelli@hp.com>
Subject: [PATCH] watchdog: hpwdt: Add support for WDIOC_SETOPTIONS
Message-ID: <20150619170125.7634f6e2@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

WDIOC_SETOPTIONS makes it possible to disable and re-enable the
watchdog timer while the hpwdt driver is loaded.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
Untested. It would be great if someone at HP (or anyone with the
hardware, I guess) could test and review this patch. Thanks.

 drivers/watchdog/hpwdt.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- linux-4.1-rc8.orig/drivers/watchdog/hpwdt.c	2015-06-19 11:40:15.885626732 +0200
+++ linux-4.1-rc8/drivers/watchdog/hpwdt.c	2015-06-19 11:52:14.375776480 +0200
@@ -588,7 +588,7 @@ static long hpwdt_ioctl(struct file *fil
 {
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
-	int new_margin;
+	int new_margin, options;
 	int ret = -ENOTTY;
 
 	switch (cmd) {
@@ -608,6 +608,23 @@ static long hpwdt_ioctl(struct file *fil
 		ret = 0;
 		break;
 
+	case WDIOC_SETOPTIONS:
+		ret = get_user(options, p);
+		if (ret)
+			break;
+
+		if (options & WDIOS_DISABLECARD) {
+			hpwdt_stop();
+			ret = 0;
+		}
+
+		if (options & WDIOS_ENABLECARD) {
+			hpwdt_start();
+			hpwdt_ping();
+			ret = 0;
+		}
+		break;
+
 	case WDIOC_SETTIMEOUT:
 		ret = get_user(new_margin, p);
 		if (ret)


-- 
Jean Delvare
SUSE L3 Support
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
