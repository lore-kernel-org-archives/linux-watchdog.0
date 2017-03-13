Return-path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable <stable@vger.kernel.org>
Subject: [PATCH] watchdog: pcwd_usb: fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:49:45 +0100
Message-Id: <20170313124945.28923-1-johan@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer should a malicious device lack endpoints.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/watchdog/pcwd_usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 99ebf6ea3de6..5615f4013924 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -630,6 +630,9 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 		return -ENODEV;
 	}
 
+	if (iface_desc->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	/* check out the endpoint: it has to be Interrupt & IN */
 	endpoint = &iface_desc->endpoint[0].desc;
 
-- 
2.12.0
