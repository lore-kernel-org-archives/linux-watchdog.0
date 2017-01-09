Return-path: <prvs=1756365f6=Rasmus.Villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>
CC: Sylvain Lemieux <slemieux.tyco@gmail.com>, Rasmus Villemoes
	<rasmus.villemoes@prevas.dk>, <linux-watchdog@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Date: Mon, 9 Jan 2017 16:02:33 +0100
Message-ID: <1483974153-466-4-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1483974153-466-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1483974153-466-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

This allows setting a default value for the watchdog.open_timeout
commandline parameter via Kconfig.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 Documentation/watchdog/watchdog-parameters.txt | 9 +++++----
 drivers/watchdog/Kconfig                       | 9 +++++++++
 drivers/watchdog/watchdog_dev.c                | 2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 2ae0fdf..a688028 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -12,10 +12,11 @@ The watchdog core currently understands one parameter,
 watchdog.open_timeout. This is the maximum time, in milliseconds, for
 which the watchdog framework will take care of pinging a hardware
 watchdog until userspace opens the corresponding /dev/watchdogN
-device. A value of 0 (the default) means an infinite timeout. Setting
-this to a non-zero value can be useful to ensure that either userspace
-comes up properly, or the board gets reset and allows fallback logic
-in the bootloader to try something else.
+device. The defalt value is CONFIG_WATCHDOG_OPEN_TIMEOUT. A value of 0
+means an infinite timeout. Setting this to a non-zero value can be
+useful to ensure that either userspace comes up properly, or the board
+gets reset and allows fallback logic in the bootloader to try
+something else.
 
 
 -------------------------------------------------
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index acb00b5..8a847f7 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -52,6 +52,15 @@ config WATCHDOG_SYSFS
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
index 8bc9f24..cc26c4d 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -81,7 +81,7 @@ static struct watchdog_core_data *old_wd_data;
 
 static struct workqueue_struct *watchdog_wq;
 
-static unsigned open_timeout;
+static unsigned open_timeout = CONFIG_WATCHDOG_OPEN_TIMEOUT;
 module_param(open_timeout, uint, 0644);
 
 static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
-- 
2.7.4
