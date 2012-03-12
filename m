Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:46827 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763Ab2CLEXO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:14 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 01/22] watchdog: Add is_wdt_active() routine
Date: Mon, 12 Mar 2012 09:51:56 +0530
Message-ID: <a80728acba22a17994a2ae795a10a8796d4b6d72.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some watchdog may need to check if watchdog is ACTIVE or not, for example in
their suspend/resume hooks.

This patch adds this routine and changes the core drivers to use it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/via_wdt.c      |    2 +-
 drivers/watchdog/watchdog_dev.c |    6 +++---
 include/linux/watchdog.h        |    5 +++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index 8f07dd4..62fed64 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -88,7 +88,7 @@ static inline void wdt_reset(void)
 static void wdt_timer_tick(unsigned long data)
 {
 	if (time_before(jiffies, next_heartbeat) ||
-	   (!test_bit(WDOG_ACTIVE, &wdt_dev.status))) {
+	   (!is_wdd_active(&wdt_dev))) {
 		wdt_reset();
 		mod_timer(&timer, jiffies + WDT_HEARTBEAT);
 	} else
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 1199da0f..9668253 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -59,7 +59,7 @@ static struct watchdog_device *wdd;
 
 static int watchdog_ping(struct watchdog_device *wddev)
 {
-	if (test_bit(WDOG_ACTIVE, &wddev->status)) {
+	if (is_wdd_active(wddev)) {
 		if (wddev->ops->ping)
 			return wddev->ops->ping(wddev);  /* ping the watchdog */
 		else
@@ -81,7 +81,7 @@ static int watchdog_start(struct watchdog_device *wddev)
 {
 	int err;
 
-	if (!test_bit(WDOG_ACTIVE, &wddev->status)) {
+	if (!is_wdd_active(wddev)) {
 		err = wddev->ops->start(wddev);
 		if (err < 0)
 			return err;
@@ -111,7 +111,7 @@ static int watchdog_stop(struct watchdog_device *wddev)
 		return err;
 	}
 
-	if (test_bit(WDOG_ACTIVE, &wddev->status)) {
+	if (is_wdd_active(wddev)) {
 		err = wddev->ops->stop(wddev);
 		if (err < 0)
 			return err;
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 43ba5b3..4fc57b2 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -118,6 +118,11 @@ struct watchdog_device {
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 };
 
+static inline bool is_wdd_active(struct watchdog_device *wdd)
+{
+	return test_bit(WDOG_ACTIVE, &wdd->status);
+}
+
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 #define WATCHDOG_NOWAYOUT		1
 #define WATCHDOG_NOWAYOUT_INIT_STATUS	(1 << WDOG_NO_WAY_OUT)
-- 
1.7.8.110.g4cb5d

