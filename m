Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45866 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbbHDCNw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Aug 2015 22:13:52 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/8] watchdog: Make set_timeout function optional
Date: Mon,  3 Aug 2015 19:13:30 -0700
Message-Id: <1438654414-29259-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

For some watchdogs, the hardware timeout is fixed, and the
watchdog driver depends on the watchdog core to handle the
actual timeout. In this situation, the watchdog driver might
only set the 'timeout' variable but do nothing else.
This can as well be handled by the infrastructure, so make
the set_timeout callback optional. If WDIOF_SETTIMEOUT is
configured but the .set_timeout callback is not available,
update the timeout variable in the infrastructure code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 4 ++++
 drivers/watchdog/watchdog_dev.c                | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 7fda3c86cf46..2f1a4ad7e565 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -178,6 +178,10 @@ they are supported. These optional routines/operations are:
   because the watchdog does not necessarily has a 1 second resolution).
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
+  If the watchdog driver does not have to perform any action but setting the
+  timeout value of the watchdog_device, this callback can be omitted.
+  If set_timeout is not provided but WDIOF_SETTIMEOUT is set, the watchdog
+  infrastructure updates the timeout value of the watchdog_device internally.
 * get_timeleft: this routines returns the time that's left before a reset.
 * ref: the operation that calls kref_get on the kref of a dynamically
   allocated watchdog_device struct.
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e0fbc4ac9bb7..73bae196a081 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -260,9 +260,9 @@ out_status:
 static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
-	int err;
+	int err = 0;
 
-	if (!wdd->ops->set_timeout || !(wdd->info->options & WDIOF_SETTIMEOUT))
+	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
 	if (watchdog_timeout_invalid(wdd, timeout))
@@ -275,7 +275,10 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 		goto out_timeout;
 	}
 
-	err = wdd->ops->set_timeout(wdd, timeout);
+	if (wdd->ops->set_timeout)
+		err = wdd->ops->set_timeout(wdd, timeout);
+	else
+		wdd->timeout = timeout;
 
 	watchdog_update_worker(wdd, true, false);
 
-- 
2.1.4

