Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:36460 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3BMMWi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 07:22:38 -0500
Received: by mail-ea0-f174.google.com with SMTP id 1so486589eaa.19
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 04:22:37 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v8 1/7] watchdog: core: add and use watchdog_is_valid_timeout function
Date: Wed, 13 Feb 2013 13:22:24 +0100
Message-Id: <1360758150-23004-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/watchdog/watchdog_core.c | 14 ++++++++++++++
 drivers/watchdog/watchdog_dev.c  |  3 +--
 include/linux/watchdog.h         |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 3796434..f10fa31 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,6 +43,20 @@ static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
 /**
+ * watchdog_is_valid_timeout() - check if the timeout is within a valid range
+ * @timeout: value to check
+ */
+bool watchdog_is_valid_timeout(struct watchdog_device *wdd, uint timeout)
+{
+	if (wdd->min_timeout < wdd->max_timeout)
+		return (wdd->min_timeout <= timeout) &&
+			(timeout <= wdd->max_timeout);
+	else
+		return (timeout > 0);
+}
+EXPORT_SYMBOL_GPL(watchdog_is_valid_timeout);
+
+/**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
  *
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ef8edec..49976f8 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -200,8 +200,7 @@ static int watchdog_set_timeout(struct watchdog_device *wddev,
 	    !(wddev->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
-	if ((wddev->max_timeout != 0) &&
-	    (timeout < wddev->min_timeout || timeout > wddev->max_timeout))
+	if (!watchdog_is_valid_timeout(wddev, timeout))
 		return -EINVAL;
 
 	mutex_lock(&wddev->lock);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 3a9df2f..9ae945e 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -130,6 +130,8 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 }
 
 /* drivers/watchdog/watchdog_core.c */
+extern bool watchdog_is_valid_timeout(struct watchdog_device *wdd,
+				      uint timeout);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-- 
1.8.1.1

