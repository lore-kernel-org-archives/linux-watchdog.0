Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3160C2D0E4
	for <linux-watchdog@archiver.kernel.org>; Tue, 17 Nov 2020 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A89921D7E
	for <linux-watchdog@archiver.kernel.org>; Tue, 17 Nov 2020 15:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgKQPW3 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:22:29 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35279 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgKQPW3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 17 Nov 2020 10:22:29 -0500
Received: from orion.localdomain ([95.118.38.12]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwwuJ-1kKDoC0xC7-00yOCQ; Tue, 17 Nov 2020 16:22:15 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 1/3] watchdog: iTCO_wdt: use module_platform_device() macro
Date:   Tue, 17 Nov 2020 16:22:12 +0100
Message-Id: <20201117152214.32244-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:YDt3UYgs0gevj5QPBMD0MFefGjsM1hX2gDTlqeZDv30Ba3Spfh/
 LYF6cJSuhyDjlgYUV5+F2ELVKgYTrAS7yWQF7ZaIi5heiYXMz0g8BEi1pkJK8lSBF+sWMPP
 7kq9ox1k/VcTJGRNQssbTmP8iZH8ATk+u10M9s86wyHU3UAvJ3vILcZ2dtBqv/W9BZ67epI
 1FNcoqtdiwWqEQq78B6FA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uzlam8SNgd0=:hWx/UI/nGfTejdapvDEhfz
 yo6No6x5TFRzgD8CCRMyE2o29GSV1VT8b/C1KzLYgg7gE7nIf/zsqedvvdoSzjfD5uiHPItot
 Wt9rzwnHMzzsYpW/OrqgMCBU5fMMxSy4Jx5gKNpluIYNheyxtx/eVybcAL80OrqBxWyQdQi49
 TIyOlQ3kX7pjlwFPARFJ7SmMLA7vAfgPdr8N/xf3BEkg01mrIaLhTkmAF/K/x/4/NEP1G8zED
 X/PG3jKqNbFHKPPA19F49bu1zwkMa9rAtSgxDjB20c06/PgWsEwerNznuOAEbFjMYw9ZylLIu
 HLtYP9k/yc8jvjCpDrXsj67IuPPN9at0Wyc+RZlWRj6uZeB6jRwcGhnX5XH2r8IFHT2TIHS/s
 HoK7eA9YHPJQtZ+ITIPT9abRVmGFLHDd/3b+1q3e0FNNtnammBsf9znPjAtxq
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Reducing init boilerplate by using the module_platform_device macro.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/watchdog/iTCO_wdt.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index a370a185a41c..f2ddc8fc71cd 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -651,21 +651,7 @@ static struct platform_driver iTCO_wdt_driver = {
 	},
 };
 
-static int __init iTCO_wdt_init_module(void)
-{
-	pr_info("Intel TCO WatchDog Timer Driver v%s\n", DRV_VERSION);
-
-	return platform_driver_register(&iTCO_wdt_driver);
-}
-
-static void __exit iTCO_wdt_cleanup_module(void)
-{
-	platform_driver_unregister(&iTCO_wdt_driver);
-	pr_info("Watchdog Module Unloaded\n");
-}
-
-module_init(iTCO_wdt_init_module);
-module_exit(iTCO_wdt_cleanup_module);
+module_platform_driver(iTCO_wdt_driver);
 
 MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>");
 MODULE_DESCRIPTION("Intel TCO WatchDog Timer Driver");
-- 
2.11.0

