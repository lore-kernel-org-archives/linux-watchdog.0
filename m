Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D851C433EF
	for <linux-watchdog@archiver.kernel.org>; Fri, 22 Jul 2022 03:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGVDLH (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 21 Jul 2022 23:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGVDLG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 21 Jul 2022 23:11:06 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B47191BEBF;
        Thu, 21 Jul 2022 20:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6h2N+
        wVtwTpvgrUCLikpNV+DWbwPlk278dYKE8sSdoQ=; b=Jl2x+vZS+vFEXKCwf+fd7
        VPaMZJ5fNiPmCQawiebdcpPOMBwh2HZu2wQHc7oUotwMBJbXksFYFoGOIZBvVAW9
        L5XerxDxbqjWWD3IbzGi/yscR2ouIhyd7G6vPnCqtsqweisrpLjxONQnnr9DGNqQ
        n9kjBgz2aofgPmY1h1apV0=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp10 (Coremail) with SMTP id DsCowABXewT4FNpivduNOg--.631S2;
        Fri, 22 Jul 2022 11:09:47 +0800 (CST)
From:   williamsukatube@163.com
To:     kabel@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] watchdog: armada_37xx_wdt: check the return value of devm_ioremap() in armada_37xx_wdt_probe()
Date:   Fri, 22 Jul 2022 11:09:38 +0800
Message-Id: <20220722030938.2925156-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABXewT4FNpivduNOg--.631S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWrZF1xWF4ftrW5Zr4kCrg_yoWDGrgEkr
        W7A34xWrs2kr1jqw10qwsFv3409Fn0vF1DXw1rtFWfG3yxur47trWDZrn5W34UZaykGFy7
        Jrn8ZF4Y9r13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5_pnPUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBSRtGg1aEEOzvlQAAsD
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

The function devm_ioremap() in armada_37xx_wdt_probe() can fail, so
its return value should be checked.

Fixes: 54e3d9b518c8a ("watchdog: Add support for Armada 37xx CPU watchdog")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/watchdog/armada_37xx_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
index 1635f421ef2c..854b1cc723cb 100644
--- a/drivers/watchdog/armada_37xx_wdt.c
+++ b/drivers/watchdog/armada_37xx_wdt.c
@@ -274,6 +274,8 @@ static int armada_37xx_wdt_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 	dev->reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!dev->reg)
+		return -ENOMEM;
 
 	/* init clock */
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.25.1

