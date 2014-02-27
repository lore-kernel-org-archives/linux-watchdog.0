Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26237 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaB0Fnj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 00:43:39 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N0037B3WQT860@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 27 Feb 2014 14:43:38 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Jonathan McDowell' <noodles@earth.li>
References: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
In-reply-to: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
Subject: [PATCH 2/6] watchdog: pc87413: split module author names
Date: Thu, 27 Feb 2014 14:43:38 +0900
Message-id: <004601cf337e$dcd7f4b0$9687de10$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Split module author names and remove unnecessary braces, in order
to fix the following checkpatch issues.

  WARNING: quoted string split across lines
  WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/pc87413_wdt.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 5211d56..9f15dd9 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -512,9 +512,8 @@ static int __init pc87413_init(void)
 		return -EBUSY;
 
 	ret = register_reboot_notifier(&pc87413_notifier);
-	if (ret != 0) {
+	if (ret != 0)
 		pr_err("cannot register reboot notifier (err=%d)\n", ret);
-	}
 
 	ret = misc_register(&pc87413_miscdev);
 	if (ret != 0) {
@@ -575,8 +574,8 @@ static void __exit pc87413_exit(void)
 module_init(pc87413_init);
 module_exit(pc87413_exit);
 
-MODULE_AUTHOR("Sven Anders <anders@anduras.de>, "
-		"Marcus Junker <junker@anduras.de>,");
+MODULE_AUTHOR("Sven Anders <anders@anduras.de>");
+MODULE_AUTHOR("Marcus Junker <junker@anduras.de>");
 MODULE_DESCRIPTION("PC87413 WDT driver");
 MODULE_LICENSE("GPL");
 
-- 
1.7.10.4


