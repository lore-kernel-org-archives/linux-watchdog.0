Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D431BC11F70
	for <linux-watchdog@archiver.kernel.org>; Sat, 10 Jul 2021 23:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CB8613D2
	for <linux-watchdog@archiver.kernel.org>; Sat, 10 Jul 2021 23:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhGJXx6 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhGJXx1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 10 Jul 2021 19:53:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDF3B613BE;
        Sat, 10 Jul 2021 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961040;
        bh=szqNDRpSbTtzUOoilzlCi13S2opHe+4em96fXDSRtdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7NDHpsTPd5xH4M+F2b9PVNt/8sekD9hG4buHq4tnYVYU9gM44uLqmzjDXkTL43ju
         PFRSbv6jpOWCX8TrsK/wEvnO/3Y0cXRsc4rs6xxIazJyJLXB85Yq5M9jQw4ndZAjzi
         fsZMxdA48vTo1YDqUNjQLdpYAEaVsQadQ5SUhzrDtctCkXqm/PZaozNNRZwHC8UQTW
         ++hC5+4XWZsOOoTaf8YhzRYA4bf8rMXZimhBX7MuFcgYZUsiuBFf41vRZXDg/rRCQr
         HHlB9dkzw6ZejdY45qK/UNe8+QDXJtVAKuwlgr0a+MYw7Ins0d0dVKUTZDrHW6ZUn3
         sF1C0W6Jscq4Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Eichenberger <eichest@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 17/37] watchdog: imx_sc_wdt: fix pretimeout
Date:   Sat, 10 Jul 2021 19:49:55 -0400
Message-Id: <20210710235016.3221124-17-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235016.3221124-1-sashal@kernel.org>
References: <20210710235016.3221124-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Stefan Eichenberger <eichest@gmail.com>

[ Upstream commit 854478a381078ee86ae2a7908a934b1ded399130 ]

If the WDIOF_PRETIMEOUT flag is not set when registering the device the
driver will not show the sysfs entries or register the default governor.
By moving the registering after the decision whether pretimeout is
supported this gets fixed.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Link: https://lore.kernel.org/r/20210519080311.142928-1-eichest@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/imx_sc_wdt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
index e9ee22a7cb45..8ac021748d16 100644
--- a/drivers/watchdog/imx_sc_wdt.c
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -183,16 +183,12 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
 	watchdog_stop_on_reboot(wdog);
 	watchdog_stop_on_unregister(wdog);
 
-	ret = devm_watchdog_register_device(dev, wdog);
-	if (ret)
-		return ret;
-
 	ret = imx_scu_irq_group_enable(SC_IRQ_GROUP_WDOG,
 				       SC_IRQ_WDOG,
 				       true);
 	if (ret) {
 		dev_warn(dev, "Enable irq failed, pretimeout NOT supported\n");
-		return 0;
+		goto register_device;
 	}
 
 	imx_sc_wdd->wdt_notifier.notifier_call = imx_sc_wdt_notify;
@@ -203,7 +199,7 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
 					 false);
 		dev_warn(dev,
 			 "Register irq notifier failed, pretimeout NOT supported\n");
-		return 0;
+		goto register_device;
 	}
 
 	ret = devm_add_action_or_reset(dev, imx_sc_wdt_action,
@@ -213,7 +209,8 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
 	else
 		dev_warn(dev, "Add action failed, pretimeout NOT supported\n");
 
-	return 0;
+register_device:
+	return devm_watchdog_register_device(dev, wdog);
 }
 
 static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
-- 
2.30.2

