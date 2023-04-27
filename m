Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C9C77B61
	for <linux-watchdog@archiver.kernel.org>; Thu, 27 Apr 2023 07:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbjD0HoN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 27 Apr 2023 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjD0HoM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Apr 2023 03:44:12 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41F81FCE;
        Thu, 27 Apr 2023 00:44:08 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 26F5724E29D;
        Thu, 27 Apr 2023 15:44:01 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 27 Apr
 2023 15:44:01 +0800
Received: from localhost.localdomain (183.27.98.45) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 27 Apr
 2023 15:44:00 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] watchdog: starfive: Fix the warning of starfive_wdt_match
Date:   Thu, 27 Apr 2023 15:44:00 +0800
Message-ID: <20230427074400.55380-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.45]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Drop the function of of_match_ptr() to fix the warning of unused variable
'starfive_wdt_match'.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---

Hi, Guenter and Wim,

This patch fixes the compiler warning of StarFive watchdog driver and 
rebases on the master branch of linux-next.

Thanks.

---
 drivers/watchdog/starfive-wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 1995cceca51e..64d1ad4d267a 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -595,7 +595,7 @@ static struct platform_driver starfive_wdt_driver = {
 	.driver = {
 		.name = "starfive-wdt",
 		.pm = &starfive_wdt_pm_ops,
-		.of_match_table = of_match_ptr(starfive_wdt_match),
+		.of_match_table = starfive_wdt_match,
 	},
 };
 module_platform_driver(starfive_wdt_driver);
-- 
2.25.1

