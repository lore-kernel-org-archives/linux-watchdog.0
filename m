Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52126 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757083Ab2BBRwK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Feb 2012 12:52:10 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Roland Stigge <stigge@antcom.de>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 3/4] watchdog: dev: don't enforce set_timeout()
Date: Thu,  2 Feb 2012 18:48:10 +0100
Message-Id: <1328204891-32551-4-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
References: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some watchdogs rewrite the timer on every ping, so they don't need a specific
set_timeout callback. Allow the callback to be empty for such devices.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 .../watchdog/convert_drivers_to_kernel_api.txt     |   10 ++++++----
 Documentation/watchdog/watchdog-kernel-api.txt     |    4 +++-
 drivers/watchdog/watchdog_dev.c                    |   11 ++++++-----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.txt b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
index be8119b..25647a3 100644
--- a/Documentation/watchdog/convert_drivers_to_kernel_api.txt
+++ b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
@@ -51,10 +51,12 @@ Here is a overview of the functions and probably needed actions:
 		set
 
 	WDIOC_SETTIMEOUT:
-		Options in watchdog_info need to have WDIOF_SETTIMEOUT set
-		and a set_timeout-callback has to be defined. The core will also
-		do limit-checking, if min_timeout and max_timeout in the watchdog
-		device are set. All is optional.
+		Options in watchdog_info need to have WDIOF_SETTIMEOUT set. The core
+		will also do limit-checking, if min_timeout and max_timeout in the
+		watchdog device are set. By default, the timeout variable of the
+		watchdog device will simply get updated. Additionally, a
+		set_timeout-callback can be defined if further actions are needed
+		(e.g. hardware setup, more advanced checks). All is optional.
 
 	WDIOC_GETTIMEOUT:
 		No preparations needed
diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 4b93c28..dcf1cfe 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -121,7 +121,9 @@ they are supported. These optional routines/operations are:
   value of the watchdog_device will be changed to the value that was just used
   to re-program the watchdog timer device.
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
-  watchdog's info structure).
+  watchdog's info structure. If it is set, and no set_timeout function is
+  provided, only the update of the timeout value will happen. This is enough
+  if the ping of the watchdog will rewrite the timer anyway.)
 * ioctl: if this routine is present then it will be called first before we do
   our own internal ioctl call handling. This routine should return -ENOIOCTLCMD
   if a command is not supported. The parameters that are passed to the ioctl
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 1199da0..ec224b4 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -215,17 +215,18 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		watchdog_ping(wdd);
 		return 0;
 	case WDIOC_SETTIMEOUT:
-		if ((wdd->ops->set_timeout == NULL) ||
-		    !(wdd->info->options & WDIOF_SETTIMEOUT))
+		if (!(wdd->info->options & WDIOF_SETTIMEOUT))
 			return -EOPNOTSUPP;
 		if (get_user(val, p))
 			return -EFAULT;
 		if ((wdd->max_timeout != 0) &&
 		    (val < wdd->min_timeout || val > wdd->max_timeout))
 				return -EINVAL;
-		err = wdd->ops->set_timeout(wdd, val);
-		if (err < 0)
-			return err;
+		if (wdd->ops->set_timeout) {
+			err = wdd->ops->set_timeout(wdd, val);
+			if (err < 0)
+				return err;
+		}
 		wdd->timeout = val;
 		/* If the watchdog is active then we send a keepalive ping
 		 * to make sure that the watchdog keep's running (and if
-- 
1.7.8.3

