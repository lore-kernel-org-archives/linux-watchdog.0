Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48953 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685AbcHJXUJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Aug 2016 19:20:09 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] watchdog: core: Fix devres_alloc() allocation size
Date: Tue,  9 Aug 2016 22:34:31 -0700
Message-Id: <1470807271-8723-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Coverity reports:

Passing argument 152UL /* sizeof (*wdd) */ to function __devres_alloc_node
and then casting the return value to struct watchdog_device ** is
suspicious.

Allocation size needs to be sizeof(*rcwdd), not sizeof(*wdd).

Fixes: 83fbae5a148c ("watchdog: Add a device managed API for ...")
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 6abb83cd7681..74265b2f806c 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -349,7 +349,7 @@ int devm_watchdog_register_device(struct device *dev,
 	struct watchdog_device **rcwdd;
 	int ret;
 
-	rcwdd = devres_alloc(devm_watchdog_unregister_device, sizeof(*wdd),
+	rcwdd = devres_alloc(devm_watchdog_unregister_device, sizeof(*rcwdd),
 			     GFP_KERNEL);
 	if (!rcwdd)
 		return -ENOMEM;
-- 
2.5.0

