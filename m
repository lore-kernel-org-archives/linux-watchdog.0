Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Wenyou Yang <wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, JM.Lin@atmel.com,
        wenyou.yang@atmel.com, wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 4/9] watchdog/at91sam9_wdt: Adjust the options of watchdog_info
Date: Sat,  5 Jan 2013 10:38:44 +0800
Message-Id: <1357353529-20901-5-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
References: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Since the Watchdog Timer Mode Register can be only written only once,
so the watchdog_info shall not support WDIOF_SETTIMEOUT
and WDIOF_MAGICCLOSE options, remove them.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/watchdog/at91sam9_wdt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index febd028..a3d1a09 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -151,8 +151,7 @@ static int at91wdt_enable(struct watchdog_device *wddev, unsigned int timeout)
 
 static const struct watchdog_info at91_wdt_info = {
 	.identity	= DRV_NAME,
-	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
-						WDIOF_MAGICCLOSE,
+	.options	= WDIOF_KEEPALIVEPING,
 };
 
 static int at91wdt_start(struct watchdog_device *wddev)
-- 
1.7.9.5
