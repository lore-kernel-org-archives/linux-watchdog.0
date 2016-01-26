Return-path: <linux@roeck-us.net>
From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v7 3/9] watchdog: Make set_timeout function optional
Date: Mon, 25 Jan 2016 18:53:10 -0800
Message-Id: <1453776796-3885-4-git-send-email-patchwork@patchwork.roeck-us.net>
In-Reply-To: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Guenter Roeck <linux@roeck-us.net>

For some watchdogs, the hardware timeout is fixed, and the
watchdog driver depends on the watchdog core to handle the
actual timeout. In this situation, the watchdog driver might
only set the 'timeout' variable but do nothing else.
This can as well be handled by the infrastructure, so make
the set_timeout callback optional. If WDIOF_SETTIMEOUT is
configured but the .set_timeout callback is not available,
update the timeout variable in the infrastructure code.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v7: Rebased to v4.5-rc1
v6: Rebased to v4.4-rc2
v5: Rebased to v4.4-rc1
v4: No changes
v3: No changes
v2: No changes
---
 Documentation/watchdog/watchdog-kernel-api.txt | 5 +++++
 drivers/watchdog/watchdog_dev.c                | 9 ++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 738bd6809328..62d49d6a7ff5 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -175,6 +175,11 @@ they are supported. These optional routines/operations are:
   (if it is larger than max_hw_timeout_ms), or to the achieved timeout value.
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
index 469b13b8363b..1a8f3861fe92 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -288,15 +288,18 @@ static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
-	int err;
+	int err = 0;
 
-	if (!wdd->ops->set_timeout || !(wdd->info->options & WDIOF_SETTIMEOUT))
+	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
 	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
-	err = wdd->ops->set_timeout(wdd, timeout);
+	if (wdd->ops->set_timeout)
+		err = wdd->ops->set_timeout(wdd, timeout);
+	else
+		wdd->timeout = timeout;
 
 	watchdog_update_worker(wdd, true);
 
-- 
2.1.4
