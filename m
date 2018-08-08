Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:44266 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbeHHVm6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 8 Aug 2018 17:42:58 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 3/5] watchdog: hpwdt: Display module parameters.
Date: Wed,  8 Aug 2018 13:13:25 -0600
Message-Id: <1533755607-71418-4-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Print module parameters when the driver is loaded.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index bb41714..69a88b1 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -320,9 +320,12 @@ static int hpwdt_init_one(struct pci_dev *dev,
 		goto error_wd_register;
 	}
 
-	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
-			", timer margin: %d seconds (nowayout=%d).\n",
-			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
+	dev_info(&dev->dev, "HPE Watchdog Timer Driver: Version: %s\n",
+				HPWDT_VERSION);
+	dev_info(&dev->dev, "timeout: %d seconds (nowayout=%d)\n",
+				hpwdt_dev.timeout, nowayout);
+	dev_info(&dev->dev, "pretimeout: %s.\n",
+				pretimeout ? "on" : "off");
 
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
 		ilo5 = true;
-- 
1.8.3.1

