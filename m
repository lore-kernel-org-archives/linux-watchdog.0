Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:21473 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933126AbdK1Kp6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Nov 2017 05:45:58 -0500
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
CC: Esben Haabendal <esben@haabendal.dk>, <mnhu@prevas.dk>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        <linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Date: Tue, 28 Nov 2017 11:35:50 +0100
Message-ID: <1511865350-20665-3-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1511865350-20665-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1511865350-20665-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This allows setting a default value for the watchdog.open_timeout
commandline parameter via Kconfig.

Some BSPs allow remote updating of the kernel image and root file
system, but updating the bootloader requires physical access. Hence, if
one has a firmware update that requires relaxing the
watchdog.open_timeout a little, the value used must be baked into the
kernel image itself and cannot come from the u-boot environment via the
kernel command line.

Being able to set the initial value in .config doesn't change the fact
that the value on the command line, if present, takes precedence, and is
of course immensely useful for development purposes while one has
console acccess, as well as usable in the cases where one can make a
permanent update of the kernel command line.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 Documentation/watchdog/watchdog-parameters.txt | 3 ++-
 drivers/watchdog/Kconfig                       | 9 +++++++++
 drivers/watchdog/watchdog_dev.c                | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 5363bf3..60dd2be 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -11,7 +11,8 @@ modules.
 The watchdog core parameter watchdog.open_timeout is the maximum time,
 in milliseconds, for which the watchdog framework will take care of
 pinging a hardware watchdog until userspace opens the corresponding
-/dev/watchdogN device. A value of 0 (the default) means an infinite
+/dev/watchdogN device. The defalt value is
+CONFIG_WATCHDOG_OPEN_TIMEOUT. A value of 0 means an infinite
 timeout. Setting this to a non-zero value can be useful to ensure that
 either userspace comes up properly, or the board gets reset and allows
 fallback logic in the bootloader to try something else.
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ca200d1..a142e1e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -63,6 +63,15 @@ config WATCHDOG_SYSFS
 	  Say Y here if you want to enable watchdog device status read through
 	  sysfs attributes.
 
+config WATCHDOG_OPEN_TIMEOUT
+	int "Timeout value for opening watchdog device"
+	default 0
+	help
+	  The maximum time, in milliseconds, for which the watchdog
+	  framework takes care of pinging a hardware watchdog. A value
+	  of 0 means infinite. The value set here can be overridden by
+	  the commandline parameter "watchdog.open_timeout".
+
 #
 # General Watchdog drivers
 #
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index b4985db..9f18952 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -84,7 +84,7 @@ static struct workqueue_struct *watchdog_wq;
 
 static bool handle_boot_enabled =
 	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
-static unsigned open_timeout;
+static unsigned open_timeout = CONFIG_WATCHDOG_OPEN_TIMEOUT;
 
 static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
 {
-- 
2.7.4

