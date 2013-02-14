Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:33434 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab3BNIOi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Feb 2013 03:14:38 -0500
Received: by mail-ee0-f54.google.com with SMTP id c41so1178475eek.13
        for <linux-watchdog@vger.kernel.org>; Thu, 14 Feb 2013 00:14:37 -0800 (PST)
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
Subject: [PATCH v9 1/8] watchdog: core: add static to watchdog_check_min_max_timeout()
Date: Thu, 14 Feb 2013 09:14:23 +0100
Message-Id: <1360829670-10418-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Because is an internal function is better to use static to help
the compiler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index a74a3ef..94590f6 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,7 +43,7 @@
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
-void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
+static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 {
 	/*
 	 * Check that we have valid min and max timeout values, if
-- 
1.8.1.1

