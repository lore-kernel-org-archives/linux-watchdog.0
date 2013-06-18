Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40968 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab3FRPVI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:21:08 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so4109847pab.31
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:21:08 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 03/14] watchdog/mpcore_wdt: Fix multiline comments
Date: Tue, 18 Jun 2013 20:50:27 +0530
Message-Id: <f366710bc04365c0d1083662eed9624f18776514.1371535242.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In case of few multiline comment a 'tab' is present instead of 'space' after the
'*' in the second column. Replace tab with space here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index bdbe3d8..6e7afe0 100644
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
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -67,8 +65,8 @@ MODULE_PARM_DESC(mpcore_noboot, "MPcore watchdog action, "
 					__MODULE_STRING(ONLY_TESTING) ")");
 
 /*
- *	This is the interrupt handler.  Note that we only use this
- *	in testing mode, so don't actually do a reboot here.
+ * This is the interrupt handler.  Note that we only use this
+ * in testing mode, so don't actually do a reboot here.
  */
 static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 {
@@ -85,11 +83,11 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
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
@@ -165,8 +163,8 @@ static const struct watchdog_ops mpcore_wdt_ops = {
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
1.7.12.rc2.18.g61b472e

