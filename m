Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:59838 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeERJzn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 May 2018 05:55:43 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] watchdog: renesas-wdt: Remove R-Car M2-W ES2.x from blacklist
Date: Fri, 18 May 2018 11:55:40 +0200
Message-Id: <1526637340-26590-1-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

System restart triggered by watchdog time-out works fine on a Koelsch
board with R-Car M2-W ES2.0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
Thanks to Magnus and Shimoda-san for providing board access!

v2:
  - Add Acked-by, Reviewed-by.
---
 drivers/watchdog/renesas_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 514db5cc15951125..88d81feba4e60087 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -146,7 +146,7 @@ static const struct soc_device_attribute rwdt_quirks_match[] = {
 		.data = (void *)1,	/* needs single CPU */
 	}, {
 		.soc_id = "r8a7791",
-		.revision = "ES[12].*",
+		.revision = "ES1.*",
 		.data = (void *)1,	/* needs single CPU */
 	}, {
 		.soc_id = "r8a7792",
-- 
2.7.4

