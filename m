Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32813 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbcB1VM1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 16:12:27 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v8 01/10] watchdog: Make set_timeout function optional
Date: Sun, 28 Feb 2016 13:12:14 -0800
Message-Id: <1456693943-6876-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
References: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

For some watchdogs, the watchdog driver handles timeout changes without
explicitly setting any registers. In this situation, the watchdog driver
might only set the 'timeout' variable but do nothing else.
This can as well be handled by the infrastructure, so make the set_timeout
callback optional. If WDIOF_SETTIMEOUT is configured but the .set_timeout
callback is not available, update the timeout variable in the
infrastructure code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v8: Moved to be first patch of series
    Rebased to v4.5-rc5
v7: Rebased to v4.5-rc1
v6: Rebased to v4.4-rc2
v5: Rebased to v4.4-rc1
v4: No changes
v3: No changes
v2: No changes
---
 Documentation/watchdog/watchdog-kernel-api.txt |  5 +++++
 drivers/watchdog/watchdog_dev.c                | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 55120a055a14..dd8f912c0576 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -156,6 +156,11 @@ they are supported. These optional routines/operations are:
   because the watchdog does not necessarily has a 1 second resolution).
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
+  If the watchdog driver does not have to perform any action but setting the
+  watchdog_device.timeout, this callback can be omitted.
+  If set_timeout is not provided but, WDIOF_SETTIMEOUT is set, the watchdog
+  infrastructure updates the timeout value of the watchdog_device internally
+  to the requested value.
 * get_timeleft: this routines returns the time that's left before a reset.
 * restart: this routine restarts the machine. It returns 0 on success or a
   negative errno code for failure.
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ba2ecce4aae6..b5e700186ae0 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -183,13 +183,20 @@ static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
-	if (!wdd->ops->set_timeout || !(wdd->info->options & WDIOF_SETTIMEOUT))
+	int err = 0;
+
+	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
 	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
-	return wdd->ops->set_timeout(wdd, timeout);
+	if (wdd->ops->set_timeout)
+		err = wdd->ops->set_timeout(wdd, timeout);
+	else
+		wdd->timeout = timeout;
+
+	return err;
 }
 
 /*
-- 
2.5.0

