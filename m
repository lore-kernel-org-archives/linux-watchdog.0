Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:48911 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbbJ1Azl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 20:55:41 -0400
From: Vladimir Zapolskiy <vz@mleia.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pnx4008: make global wdt_clk static
Date: Wed, 28 Oct 2015 02:55:35 +0200
Message-Id: <1445993735-7817-1-git-send-email-vz@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Silences sparse warning:

  drivers/watchdog/pnx4008_wdt.c:83:25:
    warning: symbol 'wdt_clk' was not declared. Should it be static?

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/watchdog/pnx4008_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 4224b3e..a8ade06 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -80,7 +80,7 @@ static unsigned int heartbeat = DEFAULT_HEARTBEAT;
 
 static DEFINE_SPINLOCK(io_lock);
 static void __iomem	*wdt_base;
-struct clk		*wdt_clk;
+static struct clk	*wdt_clk;
 
 static int pnx4008_wdt_start(struct watchdog_device *wdd)
 {
-- 
2.1.4

