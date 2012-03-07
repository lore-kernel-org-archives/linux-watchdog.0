Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:35647 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751754Ab2CGK3L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:11 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 04/15] watchdog/mpcore_wdt: remove multiple 'ret = 0' statements from ioctl ops
Date: Wed, 7 Mar 2012 15:57:45 +0530
Message-ID: <4803ddeb7dfe42ff1d46634bbd9724f8e1eedb67.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

mpcore_wdt_ioctl() has many lines where we do
	ret = 0;

Rewrite this routine to optimize these writes.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index daa6658..89e8fae 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -217,7 +217,7 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
 	struct mpcore_wdt *wdt = file->private_data;
-	int ret;
+	int ret = 0;
 	union {
 		struct watchdog_info ident;
 		int i;
@@ -235,30 +235,24 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
 		uarg.ident = ident;
-		ret = 0;
 		break;
 
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
 		uarg.i = 0;
-		ret = 0;
 		break;
 
 	case WDIOC_SETOPTIONS:
-		ret = -EINVAL;
-		if (uarg.i & WDIOS_DISABLECARD) {
+		if (uarg.i & WDIOS_DISABLECARD)
 			mpcore_wdt_stop(wdt);
-			ret = 0;
-		}
-		if (uarg.i & WDIOS_ENABLECARD) {
+		else if (uarg.i & WDIOS_ENABLECARD)
 			mpcore_wdt_start(wdt);
-			ret = 0;
-		}
+		else
+			ret = -EINVAL;
 		break;
 
 	case WDIOC_KEEPALIVE:
 		mpcore_wdt_keepalive(wdt);
-		ret = 0;
 		break;
 
 	case WDIOC_SETTIMEOUT:
@@ -270,7 +264,6 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		uarg.i = mpcore_margin;
-		ret = 0;
 		break;
 
 	default:
-- 
1.7.8.110.g4cb5d

