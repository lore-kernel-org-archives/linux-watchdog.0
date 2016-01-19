Return-path: <tomas.winkler@intel.com>
From: Tomas Winkler <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [watchdog-next] watchdog: pcwd_usb: fix compilation warning
Date: Tue, 19 Jan 2016 15:51:04 +0200
Message-Id: <1453211464-25503-1-git-send-email-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

In function ‘usb_pcwd_probe’:
drivers/watchdog/pcwd_usb.c:611:12: warning: variable ‘maxp’ set but not
used [-Wunused-but-set-variable]
  int pipe, maxp;

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/watchdog/pcwd_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 1a11aedc4fe8..68952d9ccf83 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -608,7 +608,7 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_pcwd_private *usb_pcwd = NULL;
-	int pipe, maxp;
+	int pipe;
 	int retval = -ENOMEM;
 	int got_fw_rev;
 	unsigned char fw_rev_major, fw_rev_minor;
@@ -641,7 +641,6 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 
 	/* get a handle to the interrupt data pipe */
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
-	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
 
 	/* allocate memory for our device and initialize it */
 	usb_pcwd = kzalloc(sizeof(struct usb_pcwd_private), GFP_KERNEL);
-- 
2.4.3
