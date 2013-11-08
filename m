Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47841 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab3KHJyx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Nov 2013 04:54:53 -0500
MIME-Version: 1.0
Message-ID: <20131108092419.GA22389@elgon.mountain>
Date: Fri, 8 Nov 2013 01:24:19 -0800 (PST)
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [patch v2] watchdog: pcwd_usb: overflow in usb_pcwd_send_command()
In-Reply-To: <527BA351.10705@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We changed "buf" from being an array of 6 chars to being a pointer this
sizeof(buf) needs to be updated as well.

Fixes: 2ddb8089a7e5 ('watchdog: pcwd_usb: Use allocated buffer for usb_control_msg')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Fix the bug that Guenter Roeck pointed out in v1.

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 53598e8..b731b5d 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -258,8 +258,8 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 
 	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
 			HID_REQ_SET_REPORT, HID_DT_REPORT,
-			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
-			USB_COMMAND_TIMEOUT) != sizeof(buf)) {
+			0x0200, usb_pcwd->interface_number, buf, 6,
+			USB_COMMAND_TIMEOUT) != 6) {
 		dbg("usb_pcwd_send_command: error in usb_control_msg for "
 				"cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);
 	}
