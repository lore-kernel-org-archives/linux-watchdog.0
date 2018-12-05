Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:10197 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLECWh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Dec 2018 21:22:37 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 1/1] watchdog/hpwdt: Do not claim unsupported hardware
Date: Tue,  4 Dec 2018 19:22:18 -0700
Message-Id: <1543976538-75532-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Do not claim when SSID 0x0289 as the watchdog features
are not enabled/validated by the firmware.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9356230..b99ef0a4 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -281,6 +281,17 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	    dev->subsystem_device == 0x1979)
 		return -ENODEV;
 
+	/*
+	 * Ignore unsupported hardware
+	 */
+	if (dev->vendor == PCI_VENDOR_ID_HP &&
+	    dev->device == 0x3306 &&
+	    dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR &&
+	    dev->subsystem_device == 0x0289) {
+		dev_info(&dev->dev, "Not supported on this platform\n");
+		return -ENODEV;
+	}
+
 	if (pci_enable_device(dev)) {
 		dev_warn(&dev->dev,
 			"Not possible to enable PCI Device: 0x%x:0x%x.\n",
-- 
1.8.3.1
