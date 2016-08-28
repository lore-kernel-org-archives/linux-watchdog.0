Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34960
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751041AbcH1UoT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 28 Aug 2016 16:44:19 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel-janitors@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: iTCO_wdt: constify iTCO_wdt_pm structure
Date: Sun, 28 Aug 2016 22:26:26 +0200
Message-Id: <1472415986-16035-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

iTCO_wdt_pm, of type struct dev_pm_ops, is never modified, so declare it as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/watchdog/iTCO_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 54cab18..06fcb6c 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -629,7 +629,7 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops iTCO_wdt_pm = {
+static const struct dev_pm_ops iTCO_wdt_pm = {
 	.suspend_noirq = iTCO_wdt_suspend_noirq,
 	.resume_noirq = iTCO_wdt_resume_noirq,
 };

