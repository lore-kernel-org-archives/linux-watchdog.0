Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 3/9] watchdog: Make set_timeout function optional
Date: Sun, 29 Nov 2015 11:28:45 -0800
Message-Id: <1448825331-28840-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
References: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

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
index 44787ddd59de..f2ee8226d320 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -184,6 +184,11 @@ they are supported. These optional routines/operations are:
   (if it is larger than hw_max_timeout_ms), or to the achieved timeout value.
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
+  If the watchdog driver does not have to perform any action but setting the
+  watchdog_device.timeout, this callback can be omitted.
+  If set_timeout is not provided but, WDIOF_SETTIMEOUT is set, the watchdog
+  infrastructure updates the timeout value of the watchdog_device internally
+  to the requested value.
 * get_timeleft: this routines returns the time that's left before a reset.
 * ref: the operation that calls kref_get on the kref of a dynamically
   allocated watchdog_device struct.
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 2c99c3bb2fcf..5dd7319c0169 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -284,9 +284,9 @@ out_status:
 static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
-	int err;
+	int err = 0;
 
-	if (!wdd->ops->set_timeout || !(wdd->info->options & WDIOF_SETTIMEOUT))
+	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
 	if (watchdog_timeout_invalid(wdd, timeout))
@@ -299,7 +299,10 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 		goto out_timeout;
 	}
 
-	err = wdd->ops->set_timeout(wdd, timeout);
+	if (wdd->ops->set_timeout)
+		err = wdd->ops->set_timeout(wdd, timeout);
+	else
+		wdd->timeout = timeout;
 
 	watchdog_update_worker(wdd, true);
 
-- 
2.1.4
