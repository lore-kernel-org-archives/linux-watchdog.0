Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:33195 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbeLFAmc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Dec 2018 19:42:32 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 1/3] watchdog/hpwdt: Exclude via blacklist
Date: Wed,  5 Dec 2018 17:42:21 -0700
Message-Id: <1544056943-79958-2-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of having explicit if statments excluding devices,
use a pci_device_id table of devices to blacklist.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9356230..eecd014 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -50,6 +50,10 @@
 };
 MODULE_DEVICE_TABLE(pci, hpwdt_devices);
 
+static const struct pci_device_id hpwdt_blacklist[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP, 0x1979) }, /* auxilary iLO */
+	{0},			/* terminate list */
+};
 
 /*
  *	Watchdog operations
@@ -274,12 +278,10 @@ static int hpwdt_init_one(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	/*
-	 * Ignore all auxilary iLO devices with the following PCI ID
-	 */
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP &&
-	    dev->subsystem_device == 0x1979)
+	if (pci_match_id(hpwdt_blacklist, dev)) {
+		dev_dbg(&dev->dev, "Not supported on this device\n");
 		return -ENODEV;
+	}
 
 	if (pci_enable_device(dev)) {
 		dev_warn(&dev->dev,
-- 
1.8.3.1
