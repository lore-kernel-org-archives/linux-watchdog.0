Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62958 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758026Ab2DMJQ7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Apr 2012 05:16:59 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3D9Gxnc029056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Apr 2012 05:16:59 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/5] watchdog/s3c2410_wdt: Set timeout to actually achieved timeout
Date: Fri, 13 Apr 2012 11:19:10 +0200
Message-Id: <1334308750-2859-5-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1334308750-2859-1-git-send-email-hdegoede@redhat.com>
References: <1334308750-2859-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

While rebasing my "watchdog_dev: Let the driver update the timeout field on
set_timeout success" patch (before I noticed it was already picked up by Wim),
I noticed that the s3c2410_wdt driver may not always have a 1 second
resolution, this patch changes s3c2410wdt_set_heartbeat to update the
timeout to the actually achieved timeout.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/watchdog/s3c2410_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 04e5a6d..eb6dfc1 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -201,7 +201,7 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd, unsigned timeou
 	writel(count, wdt_base + S3C2410_WTDAT);
 	writel(wtcon, wdt_base + S3C2410_WTCON);
 
-	wdd->timeout = timeout;
+	wdd->timeout = (count * divisor) / freq;
 
 	return 0;
 }
-- 
1.7.9.3

