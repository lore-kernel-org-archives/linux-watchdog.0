Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53336 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbcCWWGH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Mar 2016 18:06:07 -0400
From: Matthew McClintock <mmcclint@codeaurora.org>
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
Cc: qca-upstream.external@qca.qualcomm.com,
	Matthew McClintock <mmcclint@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/17] watchdog: qcom: configure BARK time in addition to BITE time
Date: Wed, 23 Mar 2016 17:05:03 -0500
Message-Id: <1458770712-10880-9-git-send-email-mmcclint@codeaurora.org>
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

For certain parts and some versions of TZ, TZ will reset the chip
when a BARK is triggered even though it was not configured here. So
by default let's configure this BARK time as well.

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 drivers/watchdog/qcom-wdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index e46f18d..53f57c3 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -22,18 +22,21 @@
 enum wdt_reg {
 	WDT_RST,
 	WDT_EN,
+	WDT_BARK_TIME,
 	WDT_BITE_TIME,
 };
 
 static const u32 reg_offset_data_apcs_tmr[] = {
 	[WDT_RST] = 0x38,
 	[WDT_EN] = 0x40,
+	[WDT_BARK_TIME] = 0x4C,
 	[WDT_BITE_TIME] = 0x5C,
 };
 
 static const u32 reg_offset_data_kpss[] = {
 	[WDT_RST] = 0x4,
 	[WDT_EN] = 0x8,
+	[WDT_BARK_TIME] = 0x10,
 	[WDT_BITE_TIME] = 0x14,
 };
 
@@ -62,6 +65,7 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
 
 	writel(0, wdt_addr(wdt, WDT_EN));
 	writel(1, wdt_addr(wdt, WDT_RST));
+	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
 	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
 	writel(1, wdt_addr(wdt, WDT_EN));
 	return 0;
@@ -104,6 +108,7 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
 
 	writel(0, wdt_addr(wdt, WDT_EN));
 	writel(1, wdt_addr(wdt, WDT_RST));
+	writel(timeout, wdt_addr(wdt, WDT_BARK_TIME));
 	writel(timeout, wdt_addr(wdt, WDT_BITE_TIME));
 	writel(1, wdt_addr(wdt, WDT_EN));
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

