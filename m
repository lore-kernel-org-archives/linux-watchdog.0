Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:51624 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751443Ab1JCIxW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Oct 2011 04:53:22 -0400
From: Linus Walleij <linus.walleij@stericsson.com>
To: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] [WATCHDOG] move coh901327 state holders
Date: Mon, 3 Oct 2011 10:52:58 +0200
Message-ID: <1317631978-22818-1-git-send-email-linus.walleij@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

The state holders used in the PM path of the drivers report as
unused variables when compiling without CONFIG_PM so let's
move them inside CONFIG_PM.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/watchdog/coh901327_wdt.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 9291506..20b2fb9 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -76,8 +76,6 @@ static int irq;
 static void __iomem *virtbase;
 static unsigned long coh901327_users;
 static unsigned long boot_status;
-static u16 wdogenablestore;
-static u16 irqmaskstore;
 static struct device *parent;
 
 /*
@@ -461,6 +459,10 @@ out:
 }
 
 #ifdef CONFIG_PM
+
+static u16 wdogenablestore;
+static u16 irqmaskstore;
+
 static int coh901327_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	irqmaskstore = readw(virtbase + U300_WDOG_IMR) & 0x0001U;
-- 
1.7.3.2

