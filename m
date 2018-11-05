Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:36067 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbeKEUOG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 5 Nov 2018 15:14:06 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] watchdog: renesas_wdt: Fix typos
Date: Mon,  5 Nov 2018 10:53:47 +0000
Message-Id: <1541415227-4991-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Do not use "," but ";" to separate instructions.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

---
v1->v2:
* Added changelog as suggested by Guenter Roeck

 drivers/watchdog/renesas_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 0d74c3e..b570962 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -220,8 +220,8 @@ static int rwdt_probe(struct platform_device *pdev)
 		goto out_pm_disable;
 	}
 
-	priv->wdev.info = &rwdt_ident,
-	priv->wdev.ops = &rwdt_ops,
+	priv->wdev.info = &rwdt_ident;
+	priv->wdev.ops = &rwdt_ops;
 	priv->wdev.parent = &pdev->dev;
 	priv->wdev.min_timeout = 1;
 	priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
-- 
2.7.4
