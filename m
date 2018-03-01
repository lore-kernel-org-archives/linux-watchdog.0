Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:32135 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033321AbeCASRw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 13:17:52 -0500
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
Subject: [PATCH v7 2/3] watchdog: renesas_wdt: Add R-Car Gen2 support
Date: Thu,  1 Mar 2018 18:17:22 +0000
Message-Id: <1519928243-28596-3-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Due to commits:
* "ARM: shmobile: Add watchdog support",
* "ARM: shmobile: rcar-gen2: Add watchdog support", and
* "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
we now have everything we needed for the watchdog to work on Gen2 and
RZ/G1.

This commit adds "renesas,rcar-gen2-wdt" as compatible string for R-Car
Gen2 and RZ/G1.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v6->v7:
* no change

 drivers/watchdog/renesas_wdt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 024d54e..9fc4c78 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -228,12 +228,8 @@ static int __maybe_unused rwdt_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(rwdt_pm_ops, rwdt_suspend, rwdt_resume);
 
-/*
- * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
- * to work there, one also needs a RESET (RST) driver which does not exist yet
- * due to HW issues. This needs to be solved before adding compatibles here.
- */
 static const struct of_device_id rwdt_ids[] = {
+	{ .compatible = "renesas,rcar-gen2-wdt", },
 	{ .compatible = "renesas,rcar-gen3-wdt", },
 	{ /* sentinel */ }
 };
-- 
2.7.4

