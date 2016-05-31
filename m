Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbcEaGJA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 May 2016 02:09:00 -0400
From: fu.wei@linaro.org
To: wim@iguana.be, linux@roeck-us.net, panand@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	timur@codeaurora.org, dyoung@redhat.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, Suravee.Suthikulpanit@amd.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH 3/3] sbsa_gwdt: Set WDOG_HW_RUNNING, when watchdog is already running.
Date: Tue, 31 May 2016 14:08:10 +0800
Message-Id: <1464674890-10512-4-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Pratyush Anand <panand@redhat.com>

This patch uses the new flag WDOG_HW_RUNNING in driver.
According to the definition of this flag, it should be set,
if watchdog is running after booting, before it's opened.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/watchdog/sbsa_gwdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 6af71e0..cc885f1 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -283,6 +283,8 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 		dev_warn(dev, "System reset by WDT.\n");
 		wdd->bootstatus |= WDIOF_CARDRESET;
 	}
+	if (status & SBSA_GWDT_WCS_EN)
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
 
 	if (action) {
 		irq = platform_get_irq(pdev, 0);
-- 
2.5.5

