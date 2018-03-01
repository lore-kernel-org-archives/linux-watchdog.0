Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:61969 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031911AbeCAPpC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 10:45:02 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 3/3] watchdog: renesas_wdt: Add restart handler
Date: Thu,  1 Mar 2018 15:44:08 +0000
Message-Id: <1519919048-21884-4-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On iWave's boards iwg20d and iwg22d the only way to reboot the system is
by means of the watchdog.
This patch adds a restart handler to rwdt_ops, and also makes sure we
keep its priority to a medium level, in order to not override other more
effective handlers.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
v5->v6:
* no change

 drivers/watchdog/renesas_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 609056f..ce36efc 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -112,6 +112,16 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
 	return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
 }
 
+static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
+			void *data)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	rwdt_start(wdev);
+	rwdt_write(priv, 0xffff, RWTCNT);
+	return 0;
+}
+
 static const struct watchdog_info rwdt_ident = {
 	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
 	.identity = "Renesas WDT Watchdog",
@@ -123,6 +133,7 @@ static const struct watchdog_ops rwdt_ops = {
 	.stop = rwdt_stop,
 	.ping = rwdt_init_timeout,
 	.get_timeleft = rwdt_get_timeleft,
+	.restart = rwdt_restart,
 };
 
 static int rwdt_probe(struct platform_device *pdev)
@@ -181,6 +192,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	watchdog_set_drvdata(&priv->wdev, priv);
 	watchdog_set_nowayout(&priv->wdev, nowayout);
+	watchdog_set_restart_priority(&priv->wdev, 0);
 
 	/* This overrides the default timeout only if DT configuration was found */
 	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
-- 
2.7.4

