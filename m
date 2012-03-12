Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:56295 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877Ab2CLEYB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:24:01 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 15/22] watchdog/mpcore_wdt: Add support for WDIOC_GETBOOTSTATUS IOCTL
Date: Mon, 12 Mar 2012 09:52:10 +0530
Message-ID: <11fa6e13f63feffb2242683225531edcf8e43402.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

mpcore watchdog can give last boot status, whether we got a watchdog reset or
not, via bit 0 of TWD_WDOG_RESETSTAT register. This patch adds support to return
correct status if WDIOC_GETBOOTSTATUS cmd is called with ioctl.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/include/asm/smp_twd.h |    2 ++
 drivers/watchdog/mpcore_wdt.c  |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index ef9ffba9..a13b536 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -18,6 +18,8 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
+#define TWD_WDOG_RESETSTAT_MASK		0x1
+
 struct clock_event_device;
 
 extern void __iomem *twd_base;
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 0d2ea32..73d50c3 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -148,6 +148,7 @@ static int mpcore_wdt_set_heartbeat(struct watchdog_device *wdd, unsigned int t)
 static const struct watchdog_info mpcore_wdt_info = {
 	.options		= WDIOF_SETTIMEOUT |
 				  WDIOF_KEEPALIVEPING |
+				  WDIOF_CARDRESET |
 				  WDIOF_MAGICCLOSE,
 	.identity		= "MPcore Watchdog",
 };
@@ -213,6 +214,9 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
+	wdt->wdd.bootstatus = (readl_relaxed(wdt->base + TWD_WDOG_RESETSTAT) &
+			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
+
 	mpcore_wdt_stop(&wdt->wdd);
 
 	ret = watchdog_register_device(&wdt->wdd);
-- 
1.7.8.110.g4cb5d

