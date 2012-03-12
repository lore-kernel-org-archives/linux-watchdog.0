Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:56825 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556Ab2CLEXd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:33 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 07/22] watchdog/mpcore_wdt: Fix multiline comments
Date: Mon, 12 Mar 2012 09:52:02 +0530
Message-ID: <c6c6a42167a5938b869c43045fadcdfe0b069555.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In case of few multiline comment a 'tab' is present instead of 'space' after the
'*' in the second column. Replace tab with space here.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   42 +++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 953044a..7c9f78c 100644
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
@@ -64,8 +62,8 @@ MODULE_PARM_DESC(mpcore_noboot, "MPcore watchdog action, "
 					__MODULE_STRING(ONLY_TESTING) ")");
 
 /*
- *	This is the interrupt handler.  Note that we only use this
- *	in testing mode, so don't actually do a reboot here.
+ * This is the interrupt handler.  Note that we only use this
+ * in testing mode, so don't actually do a reboot here.
  */
 static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 {
@@ -83,11 +81,11 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 }
 
 /*
- *	mpcore_wdt_ping - reload the timer
+ * mpcore_wdt_ping - reload the timer
  *
- *	Note that the spec says a DIFFERENT value must be written to the reload
- *	register each time.  The "perturb" variable deals with this by adding 1
- *	to the count every other time the function is called.
+ * Note that the spec says a DIFFERENT value must be written to the reload
+ * register each time.  The "perturb" variable deals with this by adding 1 to
+ * the count every other time the function is called.
  */
 static int mpcore_wdt_ping(struct watchdog_device *wdd)
 {
@@ -163,8 +161,8 @@ static const struct watchdog_ops mpcore_wdt_ops = {
 };
 
 /*
- *	System shutdown handler.  Turn off the watchdog if we're
- *	restarting or halting the system.
+ * System shutdown handler.  Turn off the watchdog if we're restarting or
+ * halting the system.
  */
 static void mpcore_wdt_shutdown(struct platform_device *pdev)
 {
-- 
1.7.8.110.g4cb5d

