Return-path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [RFC 2/2] watchdog: pretimeout: add userspace notifier pretimeout governor
Date: Wed, 25 May 2016 15:47:42 +0200
Message-Id: <1464184062-5230-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464184062-5230-1-git-send-email-wsa@the-dreams.de>
References: <1464184062-5230-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Userspace notifier watchdog pretimeout governor, on watchdog
pretimeout event sends a notification to userspace for further
handling.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/Kconfig                | 16 +++++++++++
 drivers/watchdog/Makefile               |  1 +
 drivers/watchdog/pretimeout_userspace.c | 47 +++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h  |  2 ++
 4 files changed, 66 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_userspace.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3682ae9d8a50ca..e69c17f518ef43 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1800,6 +1800,15 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
 	  governor is selected by a user, write a short message to
 	  the kernel log buffer and don't do any system changes.
 
+config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_USERSPACE
+	bool "userspace"
+	select WATCHDOG_PRETIMEOUT_GOV_USERSPACE
+	help
+	  Use userspace watchdog pretimeout governor by default,
+	  the governor sends a device state change uevent
+	  notification, if a pretimeout event a reported by a
+	  watchdog.
+
 endchoice
 
 config WATCHDOG_PRETIMEOUT_GOV_PANIC
@@ -1816,6 +1825,13 @@ config WATCHDOG_PRETIMEOUT_GOV_NOOP
 	  governor, only an informational message is added to the
 	  kernel log buffer, if watchdog pretimeout is happened.
 
+config WATCHDOG_PRETIMEOUT_GOV_USERSPACE
+	tristate "Userspace notifier watchdog pretimeout governor"
+	help
+	  Userspace notifier watchdog pretimeout governor, on watchdog
+	  pretimeout event send a notification to userspace for
+	  further handling.
+
 endif # WATCHDOG_PRETIMEOUT_GOV
 
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9330e4cabd8f9c..23423b8b73620c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -10,6 +10,7 @@ watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV) += watchdog_pretimeout.o
 
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC) += pretimeout_panic.o
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP) += pretimeout_noop.o
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_USERSPACE) += pretimeout_userspace.o
 
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
diff --git a/drivers/watchdog/pretimeout_userspace.c b/drivers/watchdog/pretimeout_userspace.c
new file mode 100644
index 00000000000000..cf7b03765f3254
--- /dev/null
+++ b/drivers/watchdog/pretimeout_userspace.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2015 Mentor Graphics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/watchdog.h>
+
+#include "watchdog_pretimeout.h"
+
+/**
+ * pretimeout_userspace - Notify userspace on watchdog pretimeout event
+ * @wdd - watchdog_device
+ *
+ * Send watchdog device uevent to userspace to handle pretimeout event
+ */
+static void pretimeout_userspace(struct watchdog_device *wdd)
+{
+	watchdog_dev_uevent(wdd);
+}
+
+static struct watchdog_governor watchdog_gov_userspace = {
+	.name		= "userspace",
+	.pretimeout	= pretimeout_userspace,
+	.owner		= THIS_MODULE,
+};
+
+static int __init watchdog_gov_userspace_register(void)
+{
+	return watchdog_register_governor(&watchdog_gov_userspace);
+}
+module_init(watchdog_gov_userspace_register);
+
+static void __exit watchdog_gov_userspace_unregister(void)
+{
+	watchdog_unregister_governor(&watchdog_gov_userspace);
+}
+module_exit(watchdog_gov_userspace_unregister);
+
+MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
+MODULE_DESCRIPTION("Userspace notifier watchdog pretimeout governor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index 2e60450a2be64e..8365cd78f2507b 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -23,6 +23,8 @@ void watchdog_unregister_governor(struct watchdog_governor *gov);
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"panic"
 #elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"noop"
+#elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_USERSPACE)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"userspace"
 #else
 #error "Default watchdog pretimeout governor is not set."
 #endif
-- 
2.8.1
