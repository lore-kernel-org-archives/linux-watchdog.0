Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40184 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbbHREsx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:53 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>, linux-tegra@vger.kernel.org
Subject: [PATCH 08/37] watchdog: tegra: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:41 +0530
Message-Id: <19025137fe5de0f76ff991038866aeeb84035532.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: linux-tegra@vger.kernel.org
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/tegra_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 30451ea46902..7f97cdd53f29 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -218,6 +218,7 @@ static int tegra_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &tegra_wdt_ops;
 	wdd->min_timeout = MIN_WDT_TIMEOUT;
 	wdd->max_timeout = MAX_WDT_TIMEOUT;
+	wdd->parent = &pdev->dev;
 
 	watchdog_set_drvdata(wdd, wdt);
 
-- 
2.4.3

