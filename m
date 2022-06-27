Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7C4C43334
	for <linux-watchdog@archiver.kernel.org>; Mon, 27 Jun 2022 11:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiF0Ly3 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiF0LxS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 27 Jun 2022 07:53:18 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FF7DF89
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jun 2022 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Quut41CTcbNvV/XVr89FPyZwaPs+FJ3dqPKYOI7YXYM=; b=I4lr/e0kIZ8RHWVPr40M0bRWfn
        vof29I7JqNiLz1dyginpnsMefJDk+0A9ux6k/5d9RZz5xQ6gKvy5wN12QZjKb+oUZwkI0Lx+4oXS/
        9Kisg3zcC3Gfga2QsIMPrlroDFAjnaxkz0n+yWPSLsjSDnw4Jtzs75W2C9WPv5+xCT5dvXwKLdz0J
        0fWyuELJg1VvWnE2iGm7d4DPSWW5/czNVF570pSxqg+6qFLHrNznvinHuUEseIUY1J2s0ea8hThPh
        rU2pXBJ2LhZTXlv2nECaOakkWSmYzlyTpW3oe12IJYIHNWqRHp8zkqhKl76VB/cfBmGmcA+yocn1q
        yBM/VTIA==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o5mho-006C6l-3K; Mon, 27 Jun 2022 13:15:00 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 3/3] watchdog: pm8916_wdt: Handle watchdog enabled by bootloader
Date:   Mon, 27 Jun 2022 13:14:32 +0200
Message-Id: <20220627111432.2625168-4-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627111432.2625168-1-stephan.gerhold@kernkonzept.com>
References: <20220627111432.2625168-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The bootloader might already enable the watchdog to catch hangs
during the boot process. In that case the kernel needs to ping
the watchdog temporarily until userspace is fully started.

Add a check for this in the probe() function and set the WDOG_HW_RUNNING
flag to make the watchdog core handle this automatically.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/watchdog/pm8916_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
index 3fc03fdae466..4ebd1d0cab85 100644
--- a/drivers/watchdog/pm8916_wdt.c
+++ b/drivers/watchdog/pm8916_wdt.c
@@ -142,6 +142,7 @@ static int pm8916_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pm8916_wdt *wdt;
 	struct device *parent;
+	unsigned int val;
 	int err, irq;
 	u8 poff[2];
 
@@ -198,6 +199,11 @@ static int pm8916_wdt_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to read POFF reason: %d\n", err);
 	}
 
+	err = regmap_read(wdt->regmap, wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL2,
+			  &val);
+	if (err == 0 && val & S2_RESET_EN_BIT)
+		set_bit(WDOG_HW_RUNNING, &wdt->wdev.status);
+
 	/* Configure watchdog to hard-reset mode */
 	err = regmap_write(wdt->regmap,
 			   wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL,
-- 
2.30.2

