Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4988 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab1ILJ6D (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Sep 2011 05:58:03 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/5] watchdog_dev: Use wddev function parameter instead of wdd global
Date: Mon, 12 Sep 2011 11:56:56 +0200
Message-Id: <1315821420-16205-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
References: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Various functions in watchdog_dev take the dev to operate on as
a parameter, yet they do some operations on the global wdd pointer, this
patch fixes this.

This is a preperation patch for adding support for multiple watchdogs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/watchdog/watchdog_dev.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index d33520d..1199da0 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -59,7 +59,7 @@ static struct watchdog_device *wdd;
 
 static int watchdog_ping(struct watchdog_device *wddev)
 {
-	if (test_bit(WDOG_ACTIVE, &wdd->status)) {
+	if (test_bit(WDOG_ACTIVE, &wddev->status)) {
 		if (wddev->ops->ping)
 			return wddev->ops->ping(wddev);  /* ping the watchdog */
 		else
@@ -81,12 +81,12 @@ static int watchdog_start(struct watchdog_device *wddev)
 {
 	int err;
 
-	if (!test_bit(WDOG_ACTIVE, &wdd->status)) {
+	if (!test_bit(WDOG_ACTIVE, &wddev->status)) {
 		err = wddev->ops->start(wddev);
 		if (err < 0)
 			return err;
 
-		set_bit(WDOG_ACTIVE, &wdd->status);
+		set_bit(WDOG_ACTIVE, &wddev->status);
 	}
 	return 0;
 }
@@ -105,18 +105,18 @@ static int watchdog_stop(struct watchdog_device *wddev)
 {
 	int err = -EBUSY;
 
-	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
+	if (test_bit(WDOG_NO_WAY_OUT, &wddev->status)) {
 		pr_info("%s: nowayout prevents watchdog to be stopped!\n",
-							wdd->info->identity);
+							wddev->info->identity);
 		return err;
 	}
 
-	if (test_bit(WDOG_ACTIVE, &wdd->status)) {
+	if (test_bit(WDOG_ACTIVE, &wddev->status)) {
 		err = wddev->ops->stop(wddev);
 		if (err < 0)
 			return err;
 
-		clear_bit(WDOG_ACTIVE, &wdd->status);
+		clear_bit(WDOG_ACTIVE, &wddev->status);
 	}
 	return 0;
 }
-- 
1.7.6.2

