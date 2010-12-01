Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47807 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab0LAXK6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Dec 2010 18:10:58 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>,
	Martyn Welch <martyn.welch@ge.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: gef_wdt: include fs.h
Date: Thu,  2 Dec 2010 00:11:16 +0100
Message-Id: <1291245076-23790-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Do like all the others do. Spotted because another watchdog driver in arch/
missed it, too, and caused build failures with randconfigs.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Martyn Welch <martyn.welch@ge.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/gef_wdt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index 9c21d19..f6bd6f1 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
+#include <linux/fs.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/io.h>
-- 
1.7.2.3

