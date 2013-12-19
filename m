Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46749 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab3LSXoH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Dec 2013 18:44:07 -0500
Date: Thu, 19 Dec 2013 15:44:10 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] Watchdog: pcwd_usb: remove CONFIG_USB_DEBUG usage
Message-ID: <20131219234410.GD4884@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

CONFIG_USB_DEBUG is going away, and all of the other USB drivers no
longer rely on "debug" module parameters for debugging lines, so move
the pcwd_usb driver to use the dynamic debug infrastructure to be more
in line with the rest of the kernel.


Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wim Van Sebroeck <wim@iguana.be>

---
 drivers/watchdog/pcwd_usb.c |   40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -44,23 +44,6 @@
 #include <linux/hid.h>		/* For HID_REQ_SET_REPORT & HID_DT_REPORT */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
 
-#ifdef CONFIG_USB_DEBUG
-static int debug = 1;
-#else
-static int debug;
-#endif
-
-/* Use our own dbg macro */
-
-#undef dbg
-#ifndef DEBUG
-#define DEBUG
-#endif
-#define dbg(format, ...)				\
-do {							\
-	if (debug)					\
-		pr_debug(format "\n", ##__VA_ARGS__);	\
-} while (0)
 
 /* Module and Version Information */
 #define DRIVER_VERSION "1.02"
@@ -73,10 +56,6 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE(DRIVER_LICENSE);
 
-/* Module Parameters */
-module_param(debug, int, 0);
-MODULE_PARM_DESC(debug, "Debug enabled or not");
-
 #define WATCHDOG_HEARTBEAT 0	/* default heartbeat =
 						delay-time from dip-switches */
 static int heartbeat = WATCHDOG_HEARTBEAT;
@@ -193,6 +172,7 @@ static void usb_pcwd_intr_done(struct ur
 	struct usb_pcwd_private *usb_pcwd =
 				(struct usb_pcwd_private *)urb->context;
 	unsigned char *data = usb_pcwd->intr_buffer;
+	struct device *dev = &usb_pcwd->interface->dev;
 	int retval;
 
 	switch (urb->status) {
@@ -202,17 +182,17 @@ static void usb_pcwd_intr_done(struct ur
 	case -ENOENT:
 	case -ESHUTDOWN:
 		/* this urb is terminated, clean up */
-		dbg("%s - urb shutting down with status: %d", __func__,
-								urb->status);
+		dev_dbg(dev, "%s - urb shutting down with status: %d",
+			__func__, urb->status);
 		return;
 	/* -EPIPE:  should clear the halt */
 	default:		/* error */
-		dbg("%s - nonzero urb status received: %d", __func__,
-								urb->status);
+		dev_dbg(dev, "%s - nonzero urb status received: %d",
+			__func__, urb->status);
 		goto resubmit;
 	}
 
-	dbg("received following data cmd=0x%02x msb=0x%02x lsb=0x%02x",
+	dev_dbg(dev, "received following data cmd=0x%02x msb=0x%02x lsb=0x%02x",
 		data[0], data[1], data[2]);
 
 	usb_pcwd->cmd_command  = data[0];
@@ -251,7 +231,8 @@ static int usb_pcwd_send_command(struct
 	buf[2] = *lsb;			/* Byte 2 = Data LSB */
 	buf[3] = buf[4] = buf[5] = 0;	/* All other bytes not used */
 
-	dbg("sending following data cmd=0x%02x msb=0x%02x lsb=0x%02x",
+	dev_dbg(&usb_pcwd->interface->dev,
+		"sending following data cmd=0x%02x msb=0x%02x lsb=0x%02x",
 		buf[0], buf[1], buf[2]);
 
 	atomic_set(&usb_pcwd->cmd_received, 0);
@@ -260,8 +241,9 @@ static int usb_pcwd_send_command(struct
 			HID_REQ_SET_REPORT, HID_DT_REPORT,
 			0x0200, usb_pcwd->interface_number, buf, 6,
 			USB_COMMAND_TIMEOUT) != 6) {
-		dbg("usb_pcwd_send_command: error in usb_control_msg for "
-				"cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);
+		dev_dbg(&usb_pcwd->interface->dev,
+			"usb_pcwd_send_command: error in usb_control_msg for cmd 0x%x 0x%x 0x%x\n",
+			cmd, *msb, *lsb);
 	}
 	/* wait till the usb card processed the command,
 	 * with a max. timeout of USB_COMMAND_TIMEOUT */
