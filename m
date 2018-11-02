Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:60981 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725727AbeKCE3k (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 3 Nov 2018 00:29:40 -0400
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] watchdog: renesas_wdt: Fix typos
Date: Fri,  2 Nov 2018 19:21:11 +0000
Message-Id: <1541186471-2998-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
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
