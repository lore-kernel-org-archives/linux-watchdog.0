Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47827 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbcEaGI4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 May 2016 02:08:56 -0400
From: fu.wei@linaro.org
To: wim@iguana.be, linux@roeck-us.net, panand@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	timur@codeaurora.org, dyoung@redhat.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, Suravee.Suthikulpanit@amd.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH 2/3] sbsa_gwdt: Use max_hw_heartbeat_ms instead of max_timeout
Date: Tue, 31 May 2016 14:08:09 +0800
Message-Id: <1464674890-10512-3-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Pratyush Anand <panand@redhat.com>

Using max_hw_heartbeat_ms instead of max_timeout gives the flexibility to
achieve higher user "timeout". Therefore, use this new infrastructure.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/watchdog/sbsa_gwdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index ad383f6..6af71e0 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -273,7 +273,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	wdd->info = &sbsa_gwdt_info;
 	wdd->ops = &sbsa_gwdt_ops;
 	wdd->min_timeout = 1;
-	wdd->max_timeout = U32_MAX / gwdt->clk;
+	wdd->max_hw_heartbeat_ms = U32_MAX / gwdt->clk * 1000;
 	wdd->timeout = DEFAULT_TIMEOUT;
 	watchdog_set_drvdata(wdd, gwdt);
 	watchdog_set_nowayout(wdd, nowayout);
@@ -310,7 +310,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	 * the timeout is (WOR * 2), so the maximum timeout should be doubled.
 	 */
 	if (!action)
-		wdd->max_timeout *= 2;
+		wdd->max_hw_heartbeat_ms *= 2;
 
 	watchdog_init_timeout(wdd, timeout, dev);
 	/*
-- 
2.5.5

