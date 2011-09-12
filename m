Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44797 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab1ILJ6F (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Sep 2011 05:58:05 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/5] watchdog_dev: Let the driver update the timeout field on set_timeout success
Date: Mon, 12 Sep 2011 11:56:59 +0200
Message-Id: <1315821420-16205-5-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
References: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When a set_timeout operation succeeds this does not necessarily mean that
the exact timeout requested has been achieved, because the watchdog does not
necessarily have a 1 second resolution. So rather then have the core set
the timeout member of the watchdog_device struct to the exact requested
value, instead the driver should set it to the actually achieved timeout value.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |    7 ++++---
 drivers/watchdog/watchdog_dev.c                |    2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 1d3f020..5b8cff4 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -136,9 +136,10 @@ they are supported. These optional routines/operations are:
   status of the device is reported with watchdog WDIOF_* status flags/bits.
 * set_timeout: this routine checks and changes the timeout of the watchdog
   timer device. It returns 0 on success, -EINVAL for "parameter out of range"
-  and -EIO for "could not write value to the watchdog". On success the timeout
-  value of the watchdog_device will be changed to the value that was just used
-  to re-program the watchdog timer device.
+  and -EIO for "could not write value to the watchdog". On success this
+  routine should set the timeout value of the watchdog_device to the
+  achieved timeout value (which may be different from the requested one
+  because the watchdog does not necessarily has a 1 second resolution).
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
 * ioctl: if this routine is present then it will be called first before we do
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 15dc3df..c8a594e 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -265,8 +265,6 @@ static int watchdog_set_timeout(struct watchdog_device *wddev,
 	}
 
 	ret = wddev->ops->set_timeout(wddev, timeout);
-	if (ret == 0)
-		wddev->timeout = timeout;
 leave:
 	mutex_unlock(&wddev->lock);
 	return ret;
-- 
1.7.6.2

