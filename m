Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41792 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab1LAXnQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Dec 2011 18:43:16 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/2] watchdog: documentation: describe nowayout in coversion-guide
Date: Fri,  2 Dec 2011 00:43:11 +0100
Message-Id: <1322782992-18706-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

nowayout is also handled by the watchdog core. Describe how this needs
to be addressed in the conversion guide.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 .../watchdog/convert_drivers_to_kernel_api.txt     |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.txt b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
index ae1e900..be8119b 100644
--- a/Documentation/watchdog/convert_drivers_to_kernel_api.txt
+++ b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
@@ -163,6 +163,25 @@ Here is a simple example for a watchdog device:
 +};
 
 
+Handle the 'nowayout' feature
+-----------------------------
+
+A few drivers use nowayout statically, i.e. there is no module parameter for it
+and only CONFIG_WATCHDOG_NOWAYOUT determines if the feature is going to be
+used. This needs to be converted by initializing the status variable of the
+watchdog_device like this:
+
+        .status = WATCHDOG_NOWAYOUT_INIT_STATUS,
+
+Most drivers, however, also allow runtime configuration of nowayout, usually
+by adding a module parameter. The conversion for this would be something like:
+
+	watchdog_set_nowayout(&s3c2410_wdd, nowayout);
+
+The module parameter itself needs to stay, everything else related to nowayout
+can go, though. This will likely be some code in open(), close() or write().
+
+
 Register the watchdog device
 ----------------------------
 
-- 
1.7.7.3

