Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13686 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757800Ab2EKKAi (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 06:00:38 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alan Cox <alan@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/9] watchdog: use dev_ functions
Date: Fri, 11 May 2012 12:00:22 +0200
Message-Id: <1336730427-1664-5-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
References: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

While they are registered all our watchdogs now have a valid device object
so we can in turn use that to report problems nicely.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/watchdog/watchdog_dev.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index db5daef..48018ba 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -110,8 +110,7 @@ static int watchdog_stop(struct watchdog_device *wddev)
 	int err = -EBUSY;
 
 	if (test_bit(WDOG_NO_WAY_OUT, &wddev->status)) {
-		pr_info("%s: nowayout prevents watchdog to be stopped!\n",
-							wddev->info->identity);
+		dev_info(wddev->dev, "nowayout prevents watchdog being stopped!\n");
 		return err;
 	}
 
@@ -325,7 +324,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
-		pr_crit("%s: watchdog did not stop!\n", wdd->info->identity);
+		dev_crit(wdd->dev, "watchdog did not stop!\n");
 		watchdog_ping(wdd);
 	}
 
-- 
1.7.10

