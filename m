Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39096 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbeH1OMv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 10:12:51 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] watchdog: renesas_wdt: stop when unregistering
Date: Tue, 28 Aug 2018 12:13:48 +0200
Message-Id: <20180828101348.12443-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
References: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We want to go into a sane state when unregistering. Currently, it
happens that the watchdog stops when unbinding because of RuntimePM
stopping the core clock. When rebinding, the core clock gets reactivated
and the watchdog fires even though it hasn't been opened by userspace
yet. Strange scenario, yes, but sane state is much preferred anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 88d81feba4e6..f45cb183fa75 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -234,6 +234,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&priv->wdev, priv);
 	watchdog_set_nowayout(&priv->wdev, nowayout);
 	watchdog_set_restart_priority(&priv->wdev, 0);
+	watchdog_stop_on_unregister(&priv->wdev);
 
 	/* This overrides the default timeout only if DT configuration was found */
 	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
-- 
2.11.0
