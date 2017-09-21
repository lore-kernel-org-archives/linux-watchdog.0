Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.redfish-solutions.com ([66.232.79.143]:41370 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751678AbdIUR6L (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 21 Sep 2017 13:58:11 -0400
Received: from macmini.redfish-solutions.com (macmini.redfish-solutions.com [192.168.1.38])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id v8LHwAes024334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-watchdog@vger.kernel.org>; Thu, 21 Sep 2017 11:58:11 -0600
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Using the Xeon iTCO_wdt for debugging software lockups
Message-Id: <15D6B497-434E-4455-905F-2F8116AFDB65@redfish-solutions.com>
Date: Thu, 21 Sep 2017 11:58:10 -0600
To: linux-watchdog@vger.kernel.org
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all.

I’m one of the LEDE developers, and on a particular platform (not reproducible on others) we see a particular box (a Lanner FW-8771, with a E3-1225 v3 processor) hang... can’t tell if it’s a hardware or software issue but the fact that it doesn’t happen on any other platforms (tried on Xeon D-1518 based Supermicro 5018D-FN8T and a Lanner FW-7568 with Atom D-525) makes me suspect it’s hardware... but I need to be sure.

I’ve been using iTCO_wdt watchdog to generate resets when the processor stops tickling the watchdog from user-space, and that reboots it within 60 seconds of it becoming non-responsive.

But what I can’t figure out how to do is to generate an NMI so that I can force a panic and see why all the processors seem to be looping or deadlocked.

I’m using 4.9.49 and therefore the 1.11 version of the driver.

Looking at it, iTCO_wdt_start() seems to call iTCO_wdt_unset_NO_REBOOT_bit() unconditionally, so you can’t choose between an SMI reset (via RSMRST# if I’ve understood the C226/PCH databook) and an NMI.

Is this intentional?

What would a patch look like to instead allow NMI’s when the watchdog expires?  Would I need to set NMI_EN=1 and GLB_SMI_EN=1 also or is this already set elsewhere?

And I would have thought that iTCO_wdt_unset/set_NO_REBOOT_bit() would diddle bit 9 (NMI2SMI_EN) of TCO1_CNT but it seems to be doing something else.

What’s a quick hack to get NMI’s enabled?

I thought maybe the following would do it but it’s lacking manipulating NMI_EN, GLB_SMI_EN, and NMI2SMI_EN:

--- ./drivers/watchdog/iTCO_wdt.c.orig	2017-09-13 15:13:54.000000000 -0600
+++ ./drivers/watchdog/iTCO_wdt.c	2017-09-21 11:45:28.320904534 -0600
@@ -126,6 +126,12 @@ module_param(turn_SMI_watchdog_clear_off
 MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
 	"Turn off SMI clearing watchdog (depends on TCO-version)(default=1)");
 
+static bool use_nmi = 0;
+module_param(use_nmi, bool, 0);
+MODULE_PARM_DESC(use_nmi,
+	"Use NMI when watchdog expires (default="
+				__MODULE_STRING(0) ")");
+
 /*
  * Some TCO specific functions
  */
@@ -218,7 +224,7 @@ static int iTCO_wdt_start(struct watchdo
 	iTCO_vendor_pre_start(iTCO_wdt_private.smi_res, wd_dev->timeout);
 
 	/* disable chipset's NO_REBOOT bit */
-	if (iTCO_wdt_unset_NO_REBOOT_bit()) {
+	if (!use_nmi && iTCO_wdt_unset_NO_REBOOT_bit()) {
 		spin_unlock(&iTCO_wdt_private.io_lock);
 		pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
 		return -EIO;



