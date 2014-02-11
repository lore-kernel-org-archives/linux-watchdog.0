Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9073 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaBKGws (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:52:48 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T00GD1KFZ9M20@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 15:52:47 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: [PATCH 5/8] watchdog: pcwd_usb: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:52:46 +0900
Message-id: <000601cf26f5$dee7cd10$9cb76730$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/pcwd_usb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index e562e04..1a11aed 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -645,10 +645,8 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 
 	/* allocate memory for our device and initialize it */
 	usb_pcwd = kzalloc(sizeof(struct usb_pcwd_private), GFP_KERNEL);
-	if (usb_pcwd == NULL) {
-		pr_err("Out of memory\n");
+	if (usb_pcwd == NULL)
 		goto error;
-	}
 
 	usb_pcwd_device = usb_pcwd;
 
-- 
1.7.10.4


