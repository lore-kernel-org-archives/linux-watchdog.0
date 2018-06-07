Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp52.i.mail.ru ([94.100.177.112]:39474 "EHLO smtp52.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbeFGNyl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 7 Jun 2018 09:54:41 -0400
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1fQvN9-00084Y-8z
        for linux-watchdog@vger.kernel.org; Thu, 07 Jun 2018 16:54:39 +0300
To: linux-watchdog@vger.kernel.org
From: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH] watchdog: orion_wdt: add wdt status init for
 handle_boot_enabled
Message-ID: <8846ecc5-f431-623a-d918-96ffbd5ec2fa@inbox.ru>
Date: Thu, 7 Jun 2018 16:54:37 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch add init of wdt.status for CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
--- linux-4.17/drivers/watchdog/orion_wdt.c.orig    2018-06-04 
07:54:05.176000000 +0300
+++ linux-4.17/drivers/watchdog/orion_wdt.c    2018-06-04 
08:00:13.156000000 +0300
@@ -581,6 +581,8 @@ static int orion_wdt_probe(struct platfo
       */
      if (!orion_wdt_enabled(&dev->wdt))
          orion_wdt_stop(&dev->wdt);
+    else
+        set_bit(WDOG_HW_RUNNING, &dev->wdt.status);

      /* Request the IRQ only after the watchdog is disabled */
      irq = platform_get_irq(pdev, 0);
