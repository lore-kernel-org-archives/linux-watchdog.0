Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933834AbdKQOV7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Nov 2017 09:21:59 -0500
Date: Fri, 17 Nov 2017 15:22:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pcwd_usb: remove unneeded DRIVER_LICENSE #define
Message-ID: <20171117142203.GG17880@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There is no need to #define the license of the driver, just put it in
the MODULE_LICENSE() line directly as a text string.

This allows tools that check that the module license matches the source
code license to work properly, as there is no need to unwind the
unneeded dereference, especially when it is defined just a few lines
above from where it is used.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/pcwd_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index b9e376c8e2e3..07a97708cb3a 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -49,12 +49,11 @@
 #define DRIVER_VERSION "1.02"
 #define DRIVER_AUTHOR "Wim Van Sebroeck <wim@iguana.be>"
 #define DRIVER_DESC "Berkshire USB-PC Watchdog driver"
-#define DRIVER_LICENSE "GPL"
 #define DRIVER_NAME "pcwd_usb"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
 
 #define WATCHDOG_HEARTBEAT 0	/* default heartbeat =
 						delay-time from dip-switches */
-- 
2.15.0

