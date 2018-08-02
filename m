Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:30771 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeHBXRP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Aug 2018 19:17:15 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 3/4] watchdog: hpwdt: Display module parameters.
Date: Thu,  2 Aug 2018 15:15:40 -0600
Message-Id: <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Print module parameters when the driver is loaded.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 8a85ddd..f098371 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -326,8 +326,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	}
 
 	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
-			", timer margin: %d seconds (nowayout=%d).\n",
-			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
+		", timeout : %d seconds (nowayout=%d) pretimeout=%s.\n",
+		HPWDT_VERSION, hpwdt_dev.timeout, nowayout,
+		pretimeout ? "on" : "off");
 
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
 		ilo5 = true;
-- 
1.8.3.1

