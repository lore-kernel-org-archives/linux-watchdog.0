Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbbHREtA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:00 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	David Paris <david.paris@st.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/37] watchdog: st_lpc: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:43 +0530
Message-Id: <4d95204cc2d56673a9dcddf96ee6d6701fe92ecd.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: David Paris <david.paris@st.com>
cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/st_lpc_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 6785afdc0fca..14e9badf2bfa 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -241,6 +241,7 @@ static int st_wdog_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	st_wdog_dev.max_timeout = 0xFFFFFFFF / st_wdog->clkrate;
+	st_wdog_dev.parent = &pdev->dev;
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-- 
2.4.3

