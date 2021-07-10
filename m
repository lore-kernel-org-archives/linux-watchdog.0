Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9F1C07E9B
	for <linux-watchdog@archiver.kernel.org>; Sat, 10 Jul 2021 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3464561356
	for <linux-watchdog@archiver.kernel.org>; Sat, 10 Jul 2021 23:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhGJX7B (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234114AbhGJX5t (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 10 Jul 2021 19:57:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3E6E61428;
        Sat, 10 Jul 2021 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961170;
        bh=zsX6P8+wsgbmqJgIM2hsJSHm4Qlrw2k1kf5DeSgcSvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvZa2XTTMcz72H7HcLbwBE3bw43LcRmeqMQXojKWP05Ru7uJz04OEcxJ1lbdqOQ+z
         sVWtEX9ZaTVFn9hsNGvAS2FFnivZ7oP7Fe6kNEl0EW2aL8w0d1nDwx4FJP1JvQju5i
         Jr8iyeQzdlnB7hRhdMDj0VZ4bzPCe6VoJRKHkEk0L/iNiSybh2XAn5RQ9ALCBkhX/o
         3HP8R8uDP3SbfPC9jmWkNQsE+nFu8tfgQuM1/LgRaxDgkVxoFFEXFrzTjiCD1wW9I2
         GCS5CYjo07srAKWH+CcWHINfF80FQ52RW/sbblBV7LWU/6W+fc8qnyW1m+GfqUjRc8
         p5Ifxpkdh+sRg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 07/16] watchdog: Fix possible use-after-free by calling del_timer_sync()
Date:   Sat, 10 Jul 2021 19:52:31 -0400
Message-Id: <20210710235240.3222618-7-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235240.3222618-1-sashal@kernel.org>
References: <20210710235240.3222618-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

[ Upstream commit d0212f095ab56672f6f36aabc605bda205e1e0bf ]

This driver's remove path calls del_timer(). However, that function
does not wait until the timer handler finishes. This means that the
timer handler may still be running after the driver's remove function
has finished, which would result in a use-after-free.

Fix by calling del_timer_sync(), which makes sure the timer handler
has finished, and unable to re-schedule itself.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Link: https://lore.kernel.org/r/1620802676-19701-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/lpc18xx_wdt.c | 2 +-
 drivers/watchdog/w83877f_wdt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index fd171e6caa16..1b63d1d85aa0 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -300,7 +300,7 @@ static int lpc18xx_wdt_remove(struct platform_device *pdev)
 	struct lpc18xx_wdt_dev *lpc18xx_wdt = platform_get_drvdata(pdev);
 
 	dev_warn(&pdev->dev, "I quit now, hardware will probably reboot!\n");
-	del_timer(&lpc18xx_wdt->timer);
+	del_timer_sync(&lpc18xx_wdt->timer);
 
 	watchdog_unregister_device(&lpc18xx_wdt->wdt_dev);
 	clk_disable_unprepare(lpc18xx_wdt->wdt_clk);
diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
index f0483c75ed32..4b52cf321747 100644
--- a/drivers/watchdog/w83877f_wdt.c
+++ b/drivers/watchdog/w83877f_wdt.c
@@ -170,7 +170,7 @@ static void wdt_startup(void)
 static void wdt_turnoff(void)
 {
 	/* Stop the timer */
-	del_timer(&timer);
+	del_timer_sync(&timer);
 
 	wdt_change(WDT_DISABLE);
 
-- 
2.30.2

