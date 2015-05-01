Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33795 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbbEAPhc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 11:37:32 -0400
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH] watchdog: max63xx_wdt: Constify platform_device_id
Date: Sat,  2 May 2015 00:36:52 +0900
Message-Id: <1430494612-30624-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/watchdog/max63xx_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 08da3114accb..b3a1130b8eeb 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -214,7 +214,7 @@ static int max63xx_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id max63xx_id_table[] = {
+static const struct platform_device_id max63xx_id_table[] = {
 	{ "max6369_wdt", (kernel_ulong_t)max6369_table, },
 	{ "max6370_wdt", (kernel_ulong_t)max6369_table, },
 	{ "max6371_wdt", (kernel_ulong_t)max6371_table, },
-- 
2.1.4

