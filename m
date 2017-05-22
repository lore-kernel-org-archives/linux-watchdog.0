Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:53000 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934630AbdEVORi (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 May 2017 10:17:38 -0400
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
CC: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        <esben.haabendal@gmail.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        <linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
Date: Mon, 22 May 2017 16:06:39 +0200
Message-ID: <1495462000-28979-4-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This allows setting a default value for the watchdog.open_timeout
commandline parameter via Kconfig.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 Documentation/watchdog/watchdog-parameters.txt | 9 +++++----
 drivers/watchdog/Kconfig                       | 9 +++++++++
 drivers/watchdog/watchdog_dev.c                | 2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 4801ec6..6a55a3d 100644
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
index 8b9049d..11946fb 100644
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
index c807067..098b9cb 100644
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

