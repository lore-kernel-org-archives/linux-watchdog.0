Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43900 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934232Ab2KBSRW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 Nov 2012 14:17:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2618072pbb.19
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Nov 2012 11:17:22 -0700 (PDT)
From: Devendra Naga <devendra.aaru@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH RFT V2] watchdog: gef_wdt.c: add missing remove callback
Date: Fri,  2 Nov 2012 14:17:16 -0400
Message-Id: <1351880236-31708-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

this module missed a remove callback in the platform ops.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 V2: add missing __devexit_p
 Hi,

 I didn't compile it even, i didn't have any crosstoolchain

 drivers/watchdog/gef_wdt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index 17f4cae..3e360ed 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -310,6 +310,7 @@ static struct platform_driver gef_wdt_driver = {
 		.of_match_table = gef_wdt_ids,
 	},
 	.probe		= gef_wdt_probe,
+	.remove		= __devexit_p(gef_wdt_remove),
 };
 
 static int __init gef_wdt_init(void)
-- 
1.7.10.4

