Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:44979 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753205Ab2CGK3Z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:25 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 09/15] watchdog/mpcore_wdt: convert to use module_platform_driver()
Date: Wed, 7 Mar 2012 15:57:50 +0530
Message-ID: <f286cb3454c3447f5551e6c24e27c9e478833e23.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch converts the mpcore_wdt driver to use the module_platform_driver()
macro which makes the code smaller and a bit simpler.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 9c58c63..e02c02b 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -421,18 +421,7 @@ static struct platform_driver mpcore_wdt_driver = {
 	},
 };
 
-static int __init mpcore_wdt_init(void)
-{
-	return platform_driver_register(&mpcore_wdt_driver);
-}
-
-static void __exit mpcore_wdt_exit(void)
-{
-	platform_driver_unregister(&mpcore_wdt_driver);
-}
-
-module_init(mpcore_wdt_init);
-module_exit(mpcore_wdt_exit);
+module_platform_driver(mpcore_wdt_driver);
 
 MODULE_AUTHOR("ARM Limited");
 MODULE_DESCRIPTION("MPcore Watchdog Device Driver");
-- 
1.7.8.110.g4cb5d

