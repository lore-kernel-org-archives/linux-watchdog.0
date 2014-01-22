Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:41844 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbaAVMoh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 07:44:37 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so335817pbc.24
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jan 2014 04:44:36 -0800 (PST)
From: naresh.bhat@linaro.org
To: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: wim@iguana.be, linaro-kernel@lists.linaro.org,
	linaro-acpi@lists.linaro.org, patches@linaro.org,
	Naresh Bhat <naresh.bhat@linaro.org>
Subject: [PATCH] watchdog: Add sp805_wdt depends on ARM64
Date: Wed, 22 Jan 2014 18:14:03 +0530
Message-Id: <1390394643-25443-1-git-send-email-naresh.bhat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Naresh Bhat <naresh.bhat@linaro.org>

Add sp805_wdt depends on ARM64.

Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5be6e91..2385124 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -109,7 +109,7 @@ config WM8350_WATCHDOG
 
 config ARM_SP805_WATCHDOG
 	tristate "ARM SP805 Watchdog"
-	depends on ARM && ARM_AMBA
+	depends on (ARM || ARM64) && ARM_AMBA
 	select WATCHDOG_CORE
 	help
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
-- 
1.7.9.5

