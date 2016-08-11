Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:59427 "EHLO mail.zeus03.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367AbcHKVaX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Aug 2016 17:30:23 -0400
From: Wolfram Sang <wsa-dev@sang-engineering.com>
To: linux-usb@vger.kernel.org
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pcwd_usb: don't print error when allocating urb fails
Date: Thu, 11 Aug 2016 23:23:40 +0200
Message-Id: <1470950620-26397-2-git-send-email-wsa-dev@sang-engineering.com>
In-Reply-To: <1470950620-26397-1-git-send-email-wsa-dev@sang-engineering.com>
References: <1470950620-26397-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

kmalloc will print enough information in case of failure.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/watchdog/pcwd_usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 68952d9ccf8394..99ebf6ea3de648 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -666,10 +666,8 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 
 	/* allocate the urb's */
 	usb_pcwd->intr_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!usb_pcwd->intr_urb) {
-		pr_err("Out of memory\n");
+	if (!usb_pcwd->intr_urb)
 		goto error;
-	}
 
 	/* initialise the intr urb's */
 	usb_fill_int_urb(usb_pcwd->intr_urb, udev, pipe,
-- 
2.8.1

