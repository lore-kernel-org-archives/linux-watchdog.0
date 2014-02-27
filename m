Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26638 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaB0Fov (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 00:44:51 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N007BR3YQSN20@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 27 Feb 2014 14:44:50 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Stanislav Kholmanskikh' <stanislav.kholmanskikh@oracle.com>
References: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
In-reply-to: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
Subject: [PATCH 3/6] watchdog: w83697hf: split module author names
Date: Thu, 27 Feb 2014 14:44:49 +0900
Message-id: <004701cf337f$0793bea0$16bb3be0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Split module author names and remove unnecessary braces, in order
to fix the following checkpatch issue.

  WARNING: quoted string split across lines

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/w83697hf_wdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/w83697hf_wdt.c b/drivers/watchdog/w83697hf_wdt.c
index 68b45fc..e9ea856 100644
--- a/drivers/watchdog/w83697hf_wdt.c
+++ b/drivers/watchdog/w83697hf_wdt.c
@@ -455,6 +455,6 @@ module_init(wdt_init);
 module_exit(wdt_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Marcus Junker <junker@anduras.de>, "
-		"Samuel Tardieu <sam@rfc1149.net>");
+MODULE_AUTHOR("Marcus Junker <junker@anduras.de>");
+MODULE_AUTHOR("Samuel Tardieu <sam@rfc1149.net>");
 MODULE_DESCRIPTION("w83697hf/hg WDT driver");
-- 
1.7.10.4


