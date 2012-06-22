Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:42186 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546Ab2FVPkS convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-watchdog@vger.kernel.org:4:1>);
	Fri, 22 Jun 2012 11:40:18 -0400
Message-Id: <4FE4AE2C020000780008B78A@nat28.tlf.novell.com>
Date: Fri, 22 Jun 2012 16:41:00 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: <wim@iguana.be>
Cc: <sameo@linux.intel.com>, <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, <asierra@xes-inc.com>
Subject: [PATCH] iTCO_wdt: add platform driver module alias
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

The recent conversion of iTCO_wdt resulted in the driver no longer
getting loaded automatically, since it no longer has a
MODULE_DEVICE_TABLE() included. As the lpc_ich driver now creates a
platform device, auto-loading can easily be done by having a respective
module alias in place.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Aaron Sierra <asierra@xes-inc.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>

---
 drivers/watchdog/iTCO_wdt.c |    1 +
 1 file changed, 1 insertion(+)

--- 3.5-rc3/drivers/watchdog/iTCO_wdt.c
+++ 3.5-rc3-iTCO_wdt-autoload/drivers/watchdog/iTCO_wdt.c
@@ -699,3 +699,4 @@ MODULE_DESCRIPTION("Intel TCO WatchDog T
 MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+MODULE_ALIAS("platform:" DRV_NAME);



--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
