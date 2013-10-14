Return-Path: <groeck7@gmail.com>
Return-Path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: pcwd_usb: Use allocated buffer for usb_control_msg
Date: Mon, 14 Oct 2013 09:29:34 -0700
Message-Id: <1381768174-15395-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

usb_control_msg() must use a dma-capable buffer.

This fixes the following error reported by smatch:

drivers/watchdog/pcwd_usb.c:257 usb_pcwd_send_command() error: doing dma on the
stack (buf)

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/pcwd_usb.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 7b14d18..115a0eb 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -235,13 +235,17 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 		unsigned char cmd, unsigned char *msb, unsigned char *lsb)
 {
 	int got_response, count;
-	unsigned char buf[6];
+	unsigned char *buf;
 
 	/* We will not send any commands if the USB PCWD device does
 	 * not exist */
 	if ((!usb_pcwd) || (!usb_pcwd->exists))
 		return -1;
 
+	buf = kmalloc(6, GFP_KERNEL);
+	if (buf == NULL)
+		return 0;
+
 	/* The USB PC Watchdog uses a 6 byte report format.
 	 * The board currently uses only 3 of the six bytes of the report. */
 	buf[0] = cmd;			/* Byte 0 = CMD */
@@ -277,6 +281,8 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 		*lsb = usb_pcwd->cmd_data_lsb;
 	}
 
+	kfree(buf);
+
 	return got_response;
 }
 
-- 
1.7.9.7
