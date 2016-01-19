Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:21115 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932755AbcASJQm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jan 2016 04:16:42 -0500
From: Sandeep Tripathy <tripathy@broadcom.com>
To: <wim@iguana.be>
CC: <viresh.kumar@linaro.org>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Sandeep Tripathy <tripathy@broadcom.com>
Subject: [PATCH v2 1/1] watchdog: sp805: ping fails to abort wdt reset
Date: Tue, 19 Jan 2016 14:44:49 +0530
Message-ID: <1453194889-27860-1-git-send-email-tripathy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

sp805 wdt asserts interrupt for the first expiry and
reloads the counter. If wdt interrupt is set and count
reaches zero then wdt reset event is generated. To get
wdt reset at 't' timeout the driver loads wdt counter
with 't/2'. A ping before time 't'  *should* prevent
wdt reset. Currently if ping is done after 't/2' then
wdt interrupt condition gets set. On the next countdown
of loadval wdt reset event occurs eventhough wdt was
reloaded before the set timeout 't'.

This patch clears the interrupt condition on ping.

Signed-off-by: Sandeep Tripathy <tripathy@broadcom.com>
---
 drivers/watchdog/sp805_wdt.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 01d8162..e7a715e 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -139,12 +139,11 @@ static int wdt_config(struct watchdog_device *wdd, bool ping)
 
 	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
 	writel_relaxed(wdt->load_val, wdt->base + WDTLOAD);
+	writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
 
-	if (!ping) {
-		writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
+	if (!ping)
 		writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base +
 				WDTCONTROL);
-	}
 
 	writel_relaxed(LOCK, wdt->base + WDTLOCK);
 
-- 
1.7.9.5

