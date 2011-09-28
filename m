Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40170 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab1I1MaY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Sep 2011 08:30:24 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/4] watchdog: add define to setup nowayout feature in the status-variable
Date: Wed, 28 Sep 2011 14:29:55 +0200
Message-Id: <1317212997-26668-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
References: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some drivers do not support 'nowayout' as a module parameter but simply
adhere to the global setting (which has pros and cons). Provide
additional defines, so this behaviour can easily be migrated to the
watchdog framework by adding

	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,

to the watchdog_device struct.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 include/linux/watchdog.h |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 111843f..4659bf8 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -53,12 +53,6 @@ struct watchdog_info {
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-#define WATCHDOG_NOWAYOUT	1
-#else
-#define WATCHDOG_NOWAYOUT	0
-#endif
-
 struct watchdog_ops;
 struct watchdog_device;
 
@@ -137,6 +131,14 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+#define WATCHDOG_NOWAYOUT		1
+#define WATCHDOG_NOWAYOUT_INIT_STATUS	(1 << WDOG_NO_WAY_OUT)
+#else
+#define WATCHDOG_NOWAYOUT		0
+#define WATCHDOG_NOWAYOUT_INIT_STATUS	0
+#endif
+
 #endif	/* __KERNEL__ */
 
 #endif  /* ifndef _LINUX_WATCHDOG_H */
-- 
1.7.6.3

