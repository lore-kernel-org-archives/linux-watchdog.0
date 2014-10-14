Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33485 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754705AbaJNT0b (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Oct 2014 15:26:31 -0400
Date: Tue, 14 Oct 2014 12:25:19 -0700
From: Tony Lindgren <tony@atomide.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org,
	Thomas Dziedzic <gostrc@gmail.com>
Subject: [PATCH] watchdog: Fix omap watchdogs to enable the magic close bit
Message-ID: <20141014192518.GH4972@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This allows testing the watchdog easily with distros just by
doing pkill -9 watchdog.

Reported-by: Thomas Dziedzic <gostrc@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -189,7 +189,7 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 }
 
 static const struct watchdog_info omap_wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity = "OMAP Watchdog",
 };
 
--- a/drivers/watchdog/retu_wdt.c
+++ b/drivers/watchdog/retu_wdt.c
@@ -94,7 +94,7 @@ static int retu_wdt_set_timeout(struct watchdog_device *wdog,
 }
 
 static const struct watchdog_info retu_wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity = "Retu watchdog",
 };
 
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -57,7 +57,7 @@ static int twl4030_wdt_set_timeout(struct watchdog_device *wdt,
 }
 
 static const struct watchdog_info twl4030_wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity = "TWL4030 Watchdog",
 };
 
