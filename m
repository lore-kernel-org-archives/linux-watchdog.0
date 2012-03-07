Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:59047 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751711Ab2CGK3C (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:02 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 01/15] watchdog/mpcore_wdt: Fix multiline comments
Date: Wed, 7 Mar 2012 15:57:42 +0530
Message-ID: <5c73f2b1efa581d9faaf9ea2d25ba9e0fe9d98b3.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Following kind of multiline comments are fixed in this patch:
 - Add single line comment instead of multiline one, wherever possible
 - In case of few multiline comment a 'tab' is present instead of 'space' after
   the '*' in the second column. Replace tab with space here.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   61 +++++++++++++++++------------------------
 1 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 82ccd36..64041ac 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -1,23 +1,21 @@
 /*
- *	Watchdog driver for the mpcore watchdog timer
+ * Watchdog driver for the mpcore watchdog timer
  *
- *	(c) Copyright 2004 ARM Limited
+ * (c) Copyright 2004 ARM Limited
  *
- *	Based on the SoftDog driver:
- *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
- *						All Rights Reserved.
+ * Based on the SoftDog driver:
+ * (c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>, All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  *
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
- *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
+ * Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
+ * warranty for any of this software. This material is provided
+ * "AS-IS" and at no charge.
  *
+ * (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  */
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -68,8 +66,8 @@ MODULE_PARM_DESC(mpcore_noboot, "MPcore watchdog action, "
 					__MODULE_STRING(ONLY_TESTING) ")");
 
 /*
- *	This is the interrupt handler.  Note that we only use this
- *	in testing mode, so don't actually do a reboot here.
+ * This is the interrupt handler.  Note that we only use this
+ * in testing mode, so don't actually do a reboot here.
  */
 static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 {
@@ -87,11 +85,11 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 }
 
 /*
- *	mpcore_wdt_keepalive - reload the timer
+ * mpcore_wdt_keepalive - reload the timer
  *
- *	Note that the spec says a DIFFERENT value must be written to the reload
- *	register each time.  The "perturb" variable deals with this by adding 1
- *	to the count every other time the function is called.
+ * Note that the spec says a DIFFERENT value must be written to the reload
+ * register each time.  The "perturb" variable deals with this by adding 1 to
+ * the count every other time the function is called.
  */
 static void mpcore_wdt_keepalive(struct mpcore_wdt *wdt)
 {
@@ -143,9 +141,7 @@ static int mpcore_wdt_set_heartbeat(int t)
 	return 0;
 }
 
-/*
- *	/dev/watchdog handling
- */
+/* /dev/watchdog handling */
 static int mpcore_wdt_open(struct inode *inode, struct file *file)
 {
 	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_dev);
@@ -158,9 +154,7 @@ static int mpcore_wdt_open(struct inode *inode, struct file *file)
 
 	file->private_data = wdt;
 
-	/*
-	 *	Activate timer
-	 */
+	/* Activate timer */
 	mpcore_wdt_start(wdt);
 
 	return nonseekable_open(inode, file);
@@ -171,8 +165,7 @@ static int mpcore_wdt_release(struct inode *inode, struct file *file)
 	struct mpcore_wdt *wdt = file->private_data;
 
 	/*
-	 *	Shut off the timer.
-	 *	Lock it in if it's a module and we set nowayout
+	 * Shut off the timer. Lock it in if it's a module and we set nowayout
 	 */
 	if (wdt->expect_close == 42)
 		mpcore_wdt_stop(wdt);
@@ -191,9 +184,7 @@ static ssize_t mpcore_wdt_write(struct file *file, const char *data,
 {
 	struct mpcore_wdt *wdt = file->private_data;
 
-	/*
-	 *	Refresh the timer.
-	 */
+	/* Refresh the timer. */
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -295,8 +286,8 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
 }
 
 /*
- *	System shutdown handler.  Turn off the watchdog if we're
- *	restarting or halting the system.
+ * System shutdown handler.  Turn off the watchdog if we're restarting or
+ * halting the system.
  */
 static void mpcore_wdt_shutdown(struct platform_device *dev)
 {
@@ -306,9 +297,7 @@ static void mpcore_wdt_shutdown(struct platform_device *dev)
 		mpcore_wdt_stop(wdt);
 }
 
-/*
- *	Kernel Interfaces
- */
+/* Kernel Interfaces */
 static const struct file_operations mpcore_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-- 
1.7.8.110.g4cb5d

