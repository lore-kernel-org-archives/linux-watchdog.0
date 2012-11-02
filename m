Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37003 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934257Ab2KBSPr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 Nov 2012 14:15:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2617196pbb.19
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Nov 2012 11:15:46 -0700 (PDT)
From: Devendra Naga <devendra.aaru@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH RFT] watchdog: gef_wdt.c: add missing remove callback
Date: Fri,  2 Nov 2012 14:15:39 -0400
Message-Id: <1351880139-31624-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

this module missed a remove callback in the platform ops.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
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
+	.remove		= gef_wdt_remove,
 };
 
 static int __init gef_wdt_init(void)
-- 
1.7.10.4

