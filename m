Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:45132 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751032Ab2CVOtz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Mar 2012 10:49:55 -0400
Date: Thu, 22 Mar 2012 15:49:50 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>,
	Linus Walleij <linus.walleij@stericsson.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] watchdog/coh901327: convert to use watchdog core
Message-ID: <20120322144950.GU10698@spo001.leaseweb.com>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com> <20120307164240.GA1130@pengutronix.de> <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com> <20120315212705.GH10698@spo001.leaseweb.com> <CACRpkdZ9tD8XQ3tOwTHMa3jOhivkwW7YZO0WZgG7r5BYDNktCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ9tD8XQ3tOwTHMa3jOhivkwW7YZO0WZgG7r5BYDNktCQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

> OK I rebased on top of Viresh's patch and sent them both out since
> I don't know the status of his patch.

I added it. Only issue left is that you don't set the timeout value properly.
This will result in faulty values for the WDIOC_GETTIMEOUT iotcl.
Furthermore margin should be unsigned int. And there is also no check to see
if margin is a valid parameter after it is loaded as a module.

Could you test attached patch?

Kind regards,
Wim.
---------------------------------------------------------------------
diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 7f0cbeb..3175767 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -67,7 +67,7 @@
 #define U300_WDOG_IFR_WILL_BARK_IRQ_FORCE_ENABLE			0x0001U
 
 /* Default timeout in seconds = 1 minute */
-static int margin = 60;
+static unsigned int margin = 60;
 static resource_size_t phybase;
 static resource_size_t physize;
 static int irq;
@@ -153,7 +153,7 @@ static void coh901327_disable(void)
 
 static int coh901327_start(struct watchdog_device *wdt_dev)
 {
-	coh901327_enable(margin * 100);
+	coh901327_enable(wdt_dev->timeout * 100);
 	return 0;
 }
 
@@ -176,10 +176,10 @@ static int coh901327_ping(struct watchdog_device *wdd)
 static int coh901327_settimeout(struct watchdog_device *wdt_dev,
 				unsigned int time)
 {
-	margin = time;
+	wdt_dev->timeout = time;
 	clk_enable(clk);
 	/* Set new timeout value */
-	writew(margin * 100, virtbase + U300_WDOG_TR);
+	writew(time * 100, virtbase + U300_WDOG_TR);
 	/* Feed the dog */
 	writew(U300_WDOG_FR_FEED_RESTART_TIMER,
 	       virtbase + U300_WDOG_FR);
@@ -250,7 +250,7 @@ static struct watchdog_device coh901327_wdt = {
 	.info = &coh901327_ident,
 	.ops = &coh901327_ops,
 	/*
-	 * Max margin is 327 since the 10ms
+	 * Max timout is 327 since the 10ms
 	 * timeout register is max
 	 * 0x7FFF = 327670ms ~= 327s.
 	 */
@@ -353,6 +353,10 @@ static int __init coh901327_probe(struct platform_device *pdev)
 
 	clk_disable(clk);
 
+	if (margin < 1 || margin > 327)
+		margin = 60;
+	coh901327_wdt.timout = margin;
+
 	ret = watchdog_register_device(&coh901327_wdt);
 	if (ret == 0)
 		dev_info(&pdev->dev,
@@ -461,7 +465,7 @@ module_exit(coh901327_exit);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@stericsson.com>");
 MODULE_DESCRIPTION("COH 901 327 Watchdog");
 
-module_param(margin, int, 0);
+module_param(margin, uint, 0);
 MODULE_PARM_DESC(margin, "Watchdog margin in seconds (default 60s)");
 
 MODULE_LICENSE("GPL");
