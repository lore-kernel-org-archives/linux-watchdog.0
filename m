Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33169 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756936AbcJTPDk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Oct 2016 11:03:40 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
Date: Thu, 20 Oct 2016 18:03:36 +0300
Message-Id: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It turns out we need to ping the watchdog hardware on resume when we
re-program it. Otherwise this results inadvertent reset to trigger right
after the resume is completed.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/watchdog/wdat_wdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index e473e3b23720..6d1fbda0f461 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -499,6 +499,10 @@ static int wdat_wdt_resume_noirq(struct device *dev)
 		ret = wdat_wdt_enable_reboot(wdat);
 		if (ret)
 			return ret;
+
+		ret = wdat_wdt_ping(&wdat->wdd);
+		if (ret)
+			return ret;
 	}
 
 	return wdat_wdt_start(&wdat->wdd);
-- 
2.9.3

