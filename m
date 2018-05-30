Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp5.mail.ru ([94.100.176.132]:49480 "EHLO fallback.mail.ru"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751913AbeE3FVd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 30 May 2018 01:21:33 -0400
Received: from [10.161.45.20] (port=56342 helo=smtp20.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1fNtCe-0007rt-UQ
        for linux-watchdog@vger.kernel.org; Wed, 30 May 2018 07:59:17 +0300
Received: by smtp20.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1fNtCc-0007bK-V3
        for linux-watchdog@vger.kernel.org; Wed, 30 May 2018 07:59:15 +0300
To: linux-watchdog@vger.kernel.org
From: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH] watchdog: orion_wdt: add wdt status init for
 handle_boot_enabled
Message-ID: <0334679d-12c5-00ba-e896-abbf5b6eaa01@inbox.ru>
Date: Wed, 30 May 2018 07:59:12 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch add init of wdt.status for CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
--- a/drivers/watchdog/orion_wdt.c.orig	2018-04-19 09:54:12.000000000 +0300
+++ b/drivers/watchdog/orion_wdt.c	2018-05-29 15:00:29.560000000 +0300
@@ -581,6 +581,8 @@ static int orion_wdt_probe(struct platfo
  	 */
  	if (!orion_wdt_enabled(&dev->wdt))
  		orion_wdt_stop(&dev->wdt);
+	else
+		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);

  	/* Request the IRQ only after the watchdog is disabled */
  	irq = platform_get_irq(pdev, 0);
