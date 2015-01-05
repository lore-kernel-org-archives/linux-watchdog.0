Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32361 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbbAEJJZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Jan 2015 04:09:25 -0500
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] watchdog: imx2: Constify struct regmap_config and watchdog_ops
Date: Mon, 05 Jan 2015 10:09:17 +0100
Message-id: <1420448957-10106-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const. Make struct
watchdog_ops const as well.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/watchdog/imx2_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index d6add516a7a7..bdb4dc1a2ee2 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -203,7 +203,7 @@ static inline void imx2_wdt_ping_if_active(struct watchdog_device *wdog)
 	}
 }
 
-static struct watchdog_ops imx2_wdt_ops = {
+static const struct watchdog_ops imx2_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = imx2_wdt_start,
 	.stop = imx2_wdt_stop,
@@ -211,7 +211,7 @@ static struct watchdog_ops imx2_wdt_ops = {
 	.set_timeout = imx2_wdt_set_timeout,
 };
 
-static struct regmap_config imx2_wdt_regmap_config = {
+static const struct regmap_config imx2_wdt_regmap_config = {
 	.reg_bits = 16,
 	.reg_stride = 2,
 	.val_bits = 16,
-- 
1.9.1

