Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27521 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaB0FsJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 00:48:09 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N006OS4454V40@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 27 Feb 2014 14:48:05 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Jan Beulich' <JBeulich@suse.com>,
	'Aaron Sierra' <asierra@xes-inc.com>
References: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
In-reply-to: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
Subject: [PATCH 5/6] watchdog: iTCO_wdt: remove unnecessary spaces
Date: Thu, 27 Feb 2014 14:48:04 +0900
Message-id: <004901cf337f$7be608d0$73b21a70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Remove unnecessary space in order to fix the following
checkpatch issues.

  WARNING: please, no space before tabs

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/iTCO_wdt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 04f8af6..6532e7a 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -347,15 +347,15 @@ static const struct watchdog_info ident = {
 static const struct watchdog_ops iTCO_wdt_ops = {
 	.owner =		THIS_MODULE,
 	.start =		iTCO_wdt_start,
-	.stop = 		iTCO_wdt_stop,
-	.ping = 		iTCO_wdt_ping,
+	.stop =			iTCO_wdt_stop,
+	.ping =			iTCO_wdt_ping,
 	.set_timeout =		iTCO_wdt_set_timeout,
 	.get_timeleft =		iTCO_wdt_get_timeleft,
 };
 
 static struct watchdog_device iTCO_wdt_watchdog_dev = {
 	.info =		&ident,
-	.ops = 		&iTCO_wdt_ops,
+	.ops =		&iTCO_wdt_ops,
 };
 
 /*
-- 
1.7.10.4


