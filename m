Return-Path: <arvind.yadav.cs@gmail.com>
Return-path: <arvind.yadav.cs@gmail.com>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: pcwd_usb: constify usb_device_id
Date: Sat, 12 Aug 2017 14:09:45 +0530
Message-Id: <137fce0c4bacbbd395cb56ee9360ae677e74e401.1502526524.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <22fa8ca67a6d4a59997f463bf241ed56596fbcfa.1502526524.git.arvind.yadav.cs@gmail.com>
References: <22fa8ca67a6d4a59997f463bf241ed56596fbcfa.1502526524.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/pcwd_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 5615f40..b9e376c 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -74,7 +74,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 #define USB_PCWD_PRODUCT_ID	0x1140
 
 /* table of devices that work with this driver */
-static struct usb_device_id usb_pcwd_table[] = {
+static const struct usb_device_id usb_pcwd_table[] = {
 	{ USB_DEVICE(USB_PCWD_VENDOR_ID, USB_PCWD_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
-- 
2.7.4
