Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42842 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbeC0IKF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Mar 2018 04:10:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id a22-v6so31960362lfg.9
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Mar 2018 01:10:05 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] watchdog: core: add option to make timeouts read-only
Date: Tue, 27 Mar 2018 10:09:41 +0200
Message-Id: <20180327080941.29235-2-marcus.folkesson@gmail.com>
In-Reply-To: <20180327080941.29235-1-marcus.folkesson@gmail.com>
References: <20180327080941.29235-1-marcus.folkesson@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some systems may not allow applications to configure the watchdog
timer at all. This restriction is not limited to stop the watchdog,
but also change timeouts as well.

This adds a kernel parameter to disable the ability to change the
watchdog timouts from userspace.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/Kconfig        |  9 +++++++++
 drivers/watchdog/watchdog_dev.c | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index aff773bcebdb..bcba48b5c88b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -46,6 +46,15 @@ config WATCHDOG_NOWAYOUT
 	  get killed. If you say Y here, the watchdog cannot be stopped once
 	  it has been started.
 
+config WATCHDOG_TIMEOUT_READONLY
+	bool "Make timeouts read-only from userspace"
+	help
+	  Say Y here if you want the watchdog timeout/pretimeout to be read-only
+	  from userspace. This requires that the timeout is configured before
+	  userspace takes over.
+
+	  Say N if you are unsure.
+
 config WATCHDOG_HANDLE_BOOT_ENABLED
 	bool "Update boot-enabled watchdog until userspace takes over"
 	default y
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ffbdc4642ea5..6064806a2a8d 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -87,6 +87,9 @@ static struct kthread_worker *watchdog_kworker;
 static bool handle_boot_enabled =
 	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
 
+static bool timeout_is_readonly =
+	IS_ENABLED(CONFIG_WATCHDOG_TIMEOUT_READONLY);
+
 static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 {
 	/* All variables in milli-seconds */
@@ -359,7 +362,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 {
 	int err = 0;
 
-	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
+	if (!(wdd->info->options & WDIOF_SETTIMEOUT) || timeout_is_readonly)
 		return -EOPNOTSUPP;
 
 	if (watchdog_timeout_invalid(wdd, timeout))
@@ -390,7 +393,7 @@ static int watchdog_set_pretimeout(struct watchdog_device *wdd,
 {
 	int err = 0;
 
-	if (!(wdd->info->options & WDIOF_PRETIMEOUT))
+	if (!(wdd->info->options & WDIOF_PRETIMEOUT) || timeout_is_readonly)
 		return -EOPNOTSUPP;
 
 	if (watchdog_pretimeout_invalid(wdd, timeout))
@@ -1181,3 +1184,8 @@ module_param(handle_boot_enabled, bool, 0444);
 MODULE_PARM_DESC(handle_boot_enabled,
 	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
 	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
+
+module_param(timeout_is_readonly, bool, 0444);
+MODULE_PARM_DESC(timeout_is_readonly,
+	"Watchdog timeouts is readonly from userspace (default="
+	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_TIMEOUT_READONLY)) ")");
-- 
2.16.2

