Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:45504 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab2CLEXo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:44 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 09/22] watchdog/mpcore_wdt: Set default heartbeat in probe instead of init
Date: Mon, 12 Mar 2012 09:52:04 +0530
Message-ID: <34c24fee0a69d3dd7fa82badb8af1dd66230d0f2.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently mpcore_margin is handled in mpcore_wdt_init routine, which will be
called even if we haven't added any device for watchdog.

This patch moves this code into probe routine, so that it only gets hit once we
add device for this driver.

This also uses dev_info() style print statements instead of printk()

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 1c37109..19aaad7 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -222,6 +222,21 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		goto err_register;
 	}
 
+	/*
+	 * Check that the mpcore_margin value is within it's range; if not reset
+	 * to the default
+	 */
+	if (mpcore_margin < MIN_TIME || mpcore_margin > MAX_TIME) {
+		mpcore_margin = TIMER_MARGIN;
+		dev_info(wdt->dev, "mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
+			TIMER_MARGIN);
+	}
+
+	mpcore_wdt_set_heartbeat(NULL, mpcore_margin);
+	dev_info(wdt->dev, "MPcore Watchdog Timer: 0.1. mpcore_noboot=%d "
+			"mpcore_margin=%d sec (nowayout= %d)\n", mpcore_noboot,
+			mpcore_margin, nowayout);
+
 	return 0;
 
 err_register:
@@ -279,24 +294,8 @@ static struct platform_driver mpcore_wdt_driver = {
 	},
 };
 
-static char banner[] __initdata = KERN_INFO "MPcore Watchdog Timer: 0.1. "
-		"mpcore_noboot=%d mpcore_margin=%d sec (nowayout= %d)\n";
-
 static int __init mpcore_wdt_init(void)
 {
-	/*
-	 * Check that the mpcore_margin value is within it's range;
-	 * if not reset to the default
-	 */
-	if (mpcore_margin < MIN_TIME || mpcore_margin > MAX_TIME) {
-		mpcore_margin = TIMER_MARGIN;
-		printk(KERN_INFO "mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
-				TIMER_MARGIN);
-	}
-
-	mpcore_wdt_set_heartbeat(NULL, mpcore_margin);
-	printk(banner, mpcore_noboot, mpcore_margin, nowayout);
-
 	return platform_driver_register(&mpcore_wdt_driver);
 }
 
-- 
1.7.8.110.g4cb5d

