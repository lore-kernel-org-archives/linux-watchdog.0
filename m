Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35656 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab3KGHkk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Nov 2013 02:40:40 -0500
Date: Thu, 7 Nov 2013 10:40:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] watchdog: pcwd_usb: overflow in usb_pcwd_send_command()
Message-ID: <20131107074028.GA21844@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We changed "buf" from being an array of 6 chars to being a pointer this
sizeof(buf) needs to be updated as well.

Fixes: 2ddb8089a7e5 ('watchdog: pcwd_usb: Use allocated buffer for usb_control_msg')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 53598e8..7031b9b 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -258,7 +258,7 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 
 	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
 			HID_REQ_SET_REPORT, HID_DT_REPORT,
-			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
+			0x0200, usb_pcwd->interface_number, buf, 6,
 			USB_COMMAND_TIMEOUT) != sizeof(buf)) {
 		dbg("usb_pcwd_send_command: error in usb_control_msg for "
 				"cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);
