Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:39986 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877Ab2CLEX6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:58 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 13/22] watchdog/mpcore_wdt: disable wdt in suspend only if it is busy
Date: Mon, 12 Mar 2012 09:52:08 +0530
Message-ID: <6e7bfa62de432452eb6b814e92a9045ea9e6d0c9.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We don't need to call mpcore_wdt_stop() in suspend, if wdt is not BUSY. So, call
mpcore_wdt_stop() conditionally in suspend.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 3f47b7e..7ded2a0 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -260,7 +260,9 @@ static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
 static int mpcore_wdt_suspend(struct device *dev)
 {
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
-	mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
+
+	if (is_wdd_active(&wdt->wdd))
+		mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
 
 	return 0;
 }
-- 
1.7.8.110.g4cb5d

