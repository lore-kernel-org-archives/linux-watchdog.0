Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47455 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757406Ab2KVUDe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Nov 2012 15:03:34 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3609489bkw.19
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Nov 2012 12:03:32 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v6 7/7] watchdog: WatchDog Timer Driver Core - fix comment
Date: Thu, 22 Nov 2012 13:51:56 +0100
Message-Id: <1353588716-28917-8-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1353588716-28917-1-git-send-email-fabio.porcedda@gmail.com>
References: <1353588716-28917-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 include/linux/watchdog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 5cff9d6..04ef8bd 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -129,7 +129,7 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 	return wdd->driver_data;
 }
 
-/* drivers/watchdog/core/watchdog_core.c */
+/* drivers/watchdog/watchdog_core.c */
 extern void watchdog_init_timeout(struct watchdog_device *wdd,
 				  unsigned int parm_timeout,
 				  struct device_node *node);
-- 
1.8.0

