Return-path: <jdelvare@suse.de>
Date: Sun, 21 Jun 2015 09:32:33 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, "Mingarelli, Thomas"
 <Thomas.Mingarelli@hp.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] watchdog: hpwdt: Add support for WDIOC_SETOPTIONS
Message-ID: <20150621093233.2f97739c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

WDIOC_SETOPTIONS makes it possible to disable and re-enable the
watchdog timer while the hpwdt driver is loaded.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
Untested. It would be great if someone at HP (or anyone with the
hardware, I guess) could test and review this patch. Thanks.

Changes since v1:
 * Drop useless "ret = 0" statements as suggested by Guenter.

 drivers/watchdog/hpwdt.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- linux-4.1-rc8.orig/drivers/watchdog/hpwdt.c	2015-06-20 12:56:17.933391230 +0200
+++ linux-4.1-rc8/drivers/watchdog/hpwdt.c	2015-06-21 08:31:21.671106961 +0200
@@ -588,7 +588,7 @@ static long hpwdt_ioctl(struct file *fil
 {
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
-	int new_margin;
+	int new_margin, options;
 	int ret = -ENOTTY;
 
 	switch (cmd) {
@@ -608,6 +608,20 @@ static long hpwdt_ioctl(struct file *fil
 		ret = 0;
 		break;
 
+	case WDIOC_SETOPTIONS:
+		ret = get_user(options, p);
+		if (ret)
+			break;
+
+		if (options & WDIOS_DISABLECARD)
+			hpwdt_stop();
+
+		if (options & WDIOS_ENABLECARD) {
+			hpwdt_start();
+			hpwdt_ping();
+		}
+		break;
+
 	case WDIOC_SETTIMEOUT:
 		ret = get_user(new_margin, p);
 		if (ret)


-- 
Jean Delvare
SUSE L3 Support
