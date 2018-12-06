Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:33197 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFAmc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Dec 2018 19:42:32 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 2/3] watchdog/hpwdt: Do not claim unsupported hardware
Date: Wed,  5 Dec 2018 17:42:22 -0700
Message-Id: <1544056943-79958-3-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Do not claim when SSID 0x0289 as the watchdog features
are not enabled/validated by the firmware.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index eecd014..c8e8055 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -52,6 +52,7 @@
 
 static const struct pci_device_id hpwdt_blacklist[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP, 0x1979) }, /* auxilary iLO */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP_3PAR, 0x0289) },  /* CL */
 	{0},			/* terminate list */
 };
 
-- 
1.8.3.1
