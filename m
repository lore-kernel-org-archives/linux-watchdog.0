Return-Path: <SRS0=NT8S=EB=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB2DC56201
	for <linux-watchdog@archiver.kernel.org>; Mon, 26 Oct 2020 23:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F802242B
	for <linux-watchdog@archiver.kernel.org>; Mon, 26 Oct 2020 23:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603756293;
	bh=03IWLhNICanjpu44Xap0cbktcyiY4USCLLvEEvUWjh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUo3o6yqTDpH3zFMb0CF24Ofi2Se2b3E4moqea2HgNHBhnjbUnqZVbpb6R6ORtEu4
	 piYNGbZADrRWGcLiF2BROOJbr9pa6XBPQMUH7CIZ042vnkb6MsvznWldaCEHHhIsxn
	 6uPXxa5UTpupz+6717gHXCohqORdOoPwBKRlsajM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409439AbgJZXva (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409425AbgJZXv3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Oct 2020 19:51:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBA9520882;
        Mon, 26 Oct 2020 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756288;
        bh=03IWLhNICanjpu44Xap0cbktcyiY4USCLLvEEvUWjh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nu//U8yoMEUofFZEYJi3llKg0aUaX39/dMrsr8E8d6ytFu5VCvFFESuEAdBauW0ex
         hVeGAA55u+rXtbam1NW0fex36lN9aY9kpxyqvy/PH6AEuKNdtgxyEwUvYEgmdwaN7e
         7/P8Vm/BImeo+6icU7s9yuEQeCMxxCuGhvgMUt9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 117/147] drivers: watchdog: rdc321x_wdt: Fix race condition bugs
Date:   Mon, 26 Oct 2020 19:48:35 -0400
Message-Id: <20201026234905.1022767-117-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026234905.1022767-1-sashal@kernel.org>
References: <20201026234905.1022767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 4b2e7f99cdd314263c9d172bc17193b8b6bba463 ]

In rdc321x_wdt_probe(), rdc321x_wdt_device.queue is initialized
after misc_register(), hence if ioctl is called before its
initialization which can call rdc321x_wdt_start() function,
it will see an uninitialized value of rdc321x_wdt_device.queue,
hence initialize it before misc_register().
Also, rdc321x_wdt_device.default_ticks is accessed in reset()
function called from write callback, thus initialize it before
misc_register().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20200807112902.28764-1-madhuparnabhowmik10@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rdc321x_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index 57187efeb86f1..f0c94ea51c3e4 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -231,6 +231,8 @@ static int rdc321x_wdt_probe(struct platform_device *pdev)
 
 	rdc321x_wdt_device.sb_pdev = pdata->sb_pdev;
 	rdc321x_wdt_device.base_reg = r->start;
+	rdc321x_wdt_device.queue = 0;
+	rdc321x_wdt_device.default_ticks = ticks;
 
 	err = misc_register(&rdc321x_wdt_misc);
 	if (err < 0) {
@@ -245,14 +247,11 @@ static int rdc321x_wdt_probe(struct platform_device *pdev)
 				rdc321x_wdt_device.base_reg, RDC_WDT_RST);
 
 	init_completion(&rdc321x_wdt_device.stop);
-	rdc321x_wdt_device.queue = 0;
 
 	clear_bit(0, &rdc321x_wdt_device.inuse);
 
 	timer_setup(&rdc321x_wdt_device.timer, rdc321x_wdt_trigger, 0);
 
-	rdc321x_wdt_device.default_ticks = ticks;
-
 	dev_info(&pdev->dev, "watchdog init success\n");
 
 	return 0;
-- 
2.25.1

