Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39673 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab2JEKQU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Oct 2012 06:16:20 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1148438eek.19
        for <linux-watchdog@vger.kernel.org>; Fri, 05 Oct 2012 03:16:20 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [RFC PATCH v3 4/4] watchdog: WatchDog Timer Driver Core: fix comment
Date: Fri,  5 Oct 2012 12:16:09 +0200
Message-Id: <1349432169-13006-5-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 include/linux/watchdog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index d09dda7..9e6a8f2 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -175,7 +175,7 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 	return wdd->driver_data;
 }
 
-/* drivers/watchdog/core/watchdog_core.c */
+/* drivers/watchdog/watchdog_core.c */
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 extern void watchdog_init_timeout(struct watchdog_device *wdd,
-- 
1.7.11.3

