Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:62175
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753340AbdDJOkS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Apr 2017 10:40:18 -0400
From: Shile Zhang <shile.zhang@nokia.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shile Zhang" <shile.zhang@nokia.com>
Subject: [PATCH] watchdog: fix build error if define SOFTWARE_REBOOT
Date: Mon, 10 Apr 2017 22:39:33 +0800
Message-ID: <1491835173-34840-1-git-send-email-shile.zhang@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

To fix following build error when SOFTWARE_REBOOT is defined:

  CC [M]  driver/watchdog/wdt_pci.o
driver/watchdog/wdt_pci.c: In function 'wdtpci_interrupt':
driver/watchdog/wdt_pci.c:335:3: error: too many arguments to function 'emergency_restart'
   emergency_restart(NULL);
   ^
In file included from driver/watchdog/wdt_pci.c:51:0:
include/linux/reboot.h:80:13: note: declared here
 extern void emergency_restart(void);
             ^

Signed-off-by: Shile Zhang <shile.zhang@nokia.com>
---
 drivers/watchdog/wdt_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index 48b2c05..bc7addc 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -332,7 +332,7 @@ static irqreturn_t wdtpci_interrupt(int irq, void *dev_id)
 		pr_crit("Would Reboot\n");
 #else
 		pr_crit("Initiating system reboot\n");
-		emergency_restart(NULL);
+		emergency_restart();
 #endif
 #else
 		pr_crit("Reset in 5ms\n");
-- 
2.6.2

