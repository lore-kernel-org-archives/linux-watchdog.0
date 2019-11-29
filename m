Return-Path: <SRS0=mqQh=ZV=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41800C432C0
	for <linux-watchdog@archiver.kernel.org>; Fri, 29 Nov 2019 14:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44B8215A5
	for <linux-watchdog@archiver.kernel.org>; Fri, 29 Nov 2019 14:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QxLKCeWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfK2Ovm (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:51:42 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44320 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfK2Ovm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 29 Nov 2019 09:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SJ9+mVcb0FVCH3tflyvA1BCDDhSJAg3+doDeYiOE7oc=; b=QxLKCeWPrCo0vdBPG+oXPdic3U
        nb2zQxU8Kdw/1qQqxVVkwExjto3L2a2ZXnM9mVZD4AI7TyZ/XIFgt6RpIxwTZnhFkT7+ew6yZMaVD
        LR/MqUNusHFqUvImaV+ALGkHruTaMxblSRufRCMPGvdEtKMQUYL65x0bPWFacQ3YsmQTOl3ztgPF6
        SGJLCANCAmMx+iRcXZ37U1pO1nuVl20GFlGeMWmVtYDqExfrZxJjJm9GuwMcTD9x6W9XrulJ54NGl
        zsyHNDG3Uc0HWlQVbTJ85CfYv5R4kbSxe5haU3BfVjhGWm+MW4IPZgHezmsji0OijHV8B9cRcw4jZ
        0kVTcDgg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:33428 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1iahcP-0007eY-Bc; Fri, 29 Nov 2019 14:51:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1iahcN-0000AT-Co; Fri, 29 Nov 2019 14:51:35 +0000
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: orion: fix platform_get_irq() complaints
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1iahcN-0000AT-Co@rmk-PC.armlinux.org.uk>
Date:   Fri, 29 Nov 2019 14:51:35 +0000
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Fix:

orion_wdt f1020300.watchdog: IRQ index 1 not found

which is caused by platform_get_irq() now complaining when optional
IRQs are not found.  Neither interrupt for orion is required, so
make them both optional.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/watchdog/orion_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 1cccf8eb1c5d..8e6dfe76f9c9 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -602,7 +602,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
 
 	/* Request the IRQ only after the watchdog is disabled */
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
 		/*
 		 * Not all supported platforms specify an interrupt for the
@@ -617,7 +617,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	}
 
 	/* Optional 2nd interrupt for pretimeout */
-	irq = platform_get_irq(pdev, 1);
+	irq = platform_get_irq_optional(pdev, 1);
 	if (irq > 0) {
 		orion_wdt_info.options |= WDIOF_PRETIMEOUT;
 		ret = devm_request_irq(&pdev->dev, irq, orion_wdt_pre_irq,
-- 
2.20.1

