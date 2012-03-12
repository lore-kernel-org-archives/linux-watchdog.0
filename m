Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:44645 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763Ab2CLEZ0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:25:26 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 22/22] watchdog/sp805: Add clk_{un}prepare support
Date: Mon, 12 Mar 2012 09:52:17 +0530
Message-ID: <aadd8e1398e5a85fff68b3b501e32e1fe5c4c580.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

clk_{un}prepare() routines are required for required on some platforms to run
part of clk enable/disable() routines from contexts that can schedule.

This patch adds support for these routines in sp805 driver.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/sp805_wdt.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 5c34eda..938b8ab 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -130,9 +130,16 @@ static int wdt_config(struct watchdog_device *wdd, bool ping)
 	int ret;
 
 	if (!ping) {
+		ret = clk_prepare(wdt->clk);
+		if (ret) {
+			dev_err(&wdt->adev->dev, "clock prepare fail");
+			return ret;
+		}
+
 		ret = clk_enable(wdt->clk);
 		if (ret) {
 			dev_err(&wdt->adev->dev, "clock enable fail");
+			clk_unprepare(wdt->clk);
 			return ret;
 		}
 	}
@@ -184,6 +191,7 @@ static int wdt_disable(struct watchdog_device *wdd)
 	spin_unlock(&wdt->lock);
 
 	clk_disable(wdt->clk);
+	clk_unprepare(wdt->clk);
 
 	return 0;
 }
-- 
1.7.8.110.g4cb5d

