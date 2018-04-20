Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:58316 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754735AbeDTMUx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 20 Apr 2018 08:20:53 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] watchdog: renesas-wdt: Remove R-Car M2-W ES2.x from blacklist
Date: Fri, 20 Apr 2018 14:20:49 +0200
Message-Id: <1524226849-13301-1-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

System restart triggered by watchdog time-out works fine on a Koelsch
board with R-Car M2-W ES2.0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Thanks to Magnus and Shimoda-san for providing board access!
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

