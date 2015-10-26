Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41012 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590AbbJZMJf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Oct 2015 08:09:35 -0400
From: Tomas Winkler <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [watchdog-next] watchdog: core: propagate ping error code to the user space
Date: Mon, 26 Oct 2015 14:07:58 +0200
Message-Id: <1445861278-18213-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Watchdog ping return errors are ignored by watchdog core,
Whatchdog daemon should be informed about possible hardware error or
underlaying device driver get unregistered.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/watchdog/watchdog_dev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefbad303e..423a7e0dd919 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -295,6 +295,7 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 	struct watchdog_device *wdd = file->private_data;
 	size_t i;
 	char c;
+	int err;
 
 	if (len == 0)
 		return 0;
@@ -314,7 +315,9 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 	}
 
 	/* someone wrote to us, so we send the watchdog a keepalive ping */
-	watchdog_ping(wdd);
+	err = watchdog_ping(wdd);
+	if (err < 0)
+		return err;
 
 	return len;
 }
@@ -370,8 +373,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_KEEPALIVE:
 		if (!(wdd->info->options & WDIOF_KEEPALIVEPING))
 			return -EOPNOTSUPP;
-		watchdog_ping(wdd);
-		return 0;
+		return watchdog_ping(wdd);
 	case WDIOC_SETTIMEOUT:
 		if (get_user(val, p))
 			return -EFAULT;
@@ -381,7 +383,9 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		/* If the watchdog is active then we send a keepalive ping
 		 * to make sure that the watchdog keep's running (and if
 		 * possible that it takes the new timeout) */
-		watchdog_ping(wdd);
+		err = watchdog_ping(wdd);
+		if (err < 0)
+			return err;
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		/* timeout == 0 means that we don't know the timeout */
-- 
2.4.3

