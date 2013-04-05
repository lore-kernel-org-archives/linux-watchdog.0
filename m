Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.97]:52726 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1162004Ab3DEQRK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Apr 2013 12:17:10 -0400
Message-ID: <515EF748.6060504@digi.com>
Date: Fri, 5 Apr 2013 18:09:44 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: <linux-watchdog@vger.kernel.org>, <wim@iguana.be>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] watchdog: core: don't try to stop device if not running
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

A watchdog device may be stopped from userspace using WDIOC_SETOPTIONS
ioctl and flag WDIOS_DISABLECARD. If the device is closed after this
operation, watchdog_release() is called and status bits checked for
stopping it. Besides, if the device has not been unregistered a critical
message "watchdog did not stop!" is printed, although the ioctl may have
successfully stopped it already.

Without the patch a user application sample code like this will successfully
stop the watchdog, but the kernel will output the message
"watchdog did not stop!":

	wd_fd = open("/dev/watchdog", O_RDWR);

	flags = WDIOS_DISABLECARD;
	ioctl(wd_fd, WDIOC_SETOPTIONS, &flags);

	close(wd_fd);

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
  drivers/watchdog/watchdog_dev.c |   38 +++++++++++++++++++++-----------------
  1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ef8edec..adadbdd 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -463,24 +463,28 @@ out:
  static int watchdog_release(struct inode *inode, struct file *file)
  {
  	struct watchdog_device *wdd = file->private_data;
-	int err = -EBUSY;

-	/*
-	 * We only stop the watchdog if we received the magic character
-	 * or if WDIOF_MAGICCLOSE is not set. If nowayout was set then
-	 * watchdog_stop will fail.
-	 */
-	if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
-	    !(wdd->info->options & WDIOF_MAGICCLOSE))
-		err = watchdog_stop(wdd);
-
-	/* If the watchdog was not stopped, send a keepalive ping */
-	if (err < 0) {
-		mutex_lock(&wdd->lock);
-		if (!test_bit(WDOG_UNREGISTERED, &wdd->status))
-			dev_crit(wdd->dev, "watchdog did not stop!\n");
-		mutex_unlock(&wdd->lock);
-		watchdog_ping(wdd);
+	if (test_bit(WDOG_ACTIVE, &wdd->status)) {
+		int err = -EBUSY;
+
+		/*
+		 * We only stop the watchdog if we received the magic character
+		 * or if WDIOF_MAGICCLOSE is not set. If nowayout was set then
+		 * watchdog_stop will fail.
+		 */
+		if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
+		    !(wdd->info->options & WDIOF_MAGICCLOSE)) {
+			err = watchdog_stop(wdd);
+		}
+
+		/* If the watchdog was not stopped, send a keepalive ping */
+		if (err < 0) {
+			mutex_lock(&wdd->lock);
+			if (!test_bit(WDOG_UNREGISTERED, &wdd->status))
+				dev_crit(wdd->dev, "watchdog did not stop!\n");
+			mutex_unlock(&wdd->lock);
+			watchdog_ping(wdd);
+		}
  	}

  	/* Allow the owner module to be unloaded again */
-- 
1.7.9.5
