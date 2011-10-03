Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36943 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab1JCRut (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Oct 2011 13:50:49 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH v2 2/5] watchdog: add define to setup nowayout feature in the status-variable
Date: Mon,  3 Oct 2011 18:49:59 +0100
Message-Id: <1317664202-4085-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1317664202-4085-1-git-send-email-w.sang@pengutronix.de>
References: <1317664202-4085-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The nowayout-feature should ideally be per-device, but historically it is used
globally or per-module. Add a define which makes emulating this behaviour easy
when using the watchdog framework. For global usage, you can add

	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,

to the watchdog device. If you have a module parameter, you can add

	if (nowayout)
		wdd.status |= WATCHDOG_NOWAYOUT_INIT_STATUS;

to the code.

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
1.7.2.5

