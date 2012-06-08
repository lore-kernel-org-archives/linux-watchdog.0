Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:55477 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab2FHNJ7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jun 2012 09:09:59 -0400
From: Tony Zelenoff <antonz@parallels.com>
To: <linux-watchdog@vger.kernel.org>
CC: <wim@iguana.be>, <antonz@parallels.com>
Subject: [RFC 1/3] watchdog: check CAP_SYS_BOOT at watchdog open
Date: Fri, 8 Jun 2012 17:09:55 +0400
Message-ID: <1339160997-160581-2-git-send-email-antonz@parallels.com>
In-Reply-To: <1339160997-160581-1-git-send-email-antonz@parallels.com>
References: <1339160997-160581-1-git-send-email-antonz@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog can cause reboots, so there is good
reason to check capability for it.

Signed-off-by: Tony Zelenoff <antonz@parallels.com>
---
 drivers/watchdog/watchdog_dev.c |   19 +++++++++++++++++++
 include/linux/watchdog.h        |    3 +++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 672d169..e89b9d3 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -400,6 +400,22 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 }
 
 /*
+ *	watchdog_may_open: check ability to open /dev/watchdog* devices
+ *
+ *	When user asks to open /dev/watchdog* device, the additional
+ *	checks must be performed: as the watchdog able to cause machine
+ *	reboots, the watchdog device must check CAP_SYS_BOOT at open
+ */
+int watchdog_may_open(void)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return 0;
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(watchdog_may_open);
+
+/*
  *	watchdog_open: open the /dev/watchdog* devices.
  *	@inode: inode of device
  *	@file: file handle to device
@@ -414,6 +430,9 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	int err = -EBUSY;
 	struct watchdog_device *wdd;
 
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* Get the corresponding watchdog device */
 	if (imajor(inode) == MISC_MAJOR)
 		wdd = old_wdd;
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index da70f0f..2f180db 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -178,6 +178,9 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
+/* Used to check ability to open watchdog in code not using watchdog ops */
+extern int watchdog_may_open(void);
+
 #endif	/* __KERNEL__ */
 
 #endif  /* ifndef _LINUX_WATCHDOG_H */
-- 
1.7.1

