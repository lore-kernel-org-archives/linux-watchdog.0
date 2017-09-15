Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:62402 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdIOTUZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 15 Sep 2017 15:20:25 -0400
From: Mathieu Malaterre <malat@debian.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] watchdog: jz4740: Add support for the watchdog in jz4780 SoC
Date: Fri, 15 Sep 2017 21:20:19 +0200
Message-Id: <20170915192020.27717-1-malat@debian.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog unit present in the JZ4780 works the same as the one in the
JZ4740.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
Changes in v2:
* do not re-use the compatible string for different SoC (Paul Cercueil)

 drivers/watchdog/jz4740_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 20627f22baf6..aafbeb96561b 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -146,6 +146,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_wdt_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-watchdog", },
+	{ .compatible = "ingenic,jz4780-watchdog", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
-- 
2.11.0

