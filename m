Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:40920 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbbKUHNq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Nov 2015 02:13:46 -0500
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH 4/6] watchdog: pretimeout: add userspace notifier pretimeout governor
Date: Sat, 21 Nov 2015 09:11:48 +0200
Message-ID: <1448089910-11453-5-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Userspace notifier watchdog pretimeout governor, on watchdog
pretimeout event sends a notification to userspace for further
handling.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/watchdog/Kconfig                | 14 ++++++++++
 drivers/watchdog/Makefile               |  1 +
 drivers/watchdog/pretimeout_userspace.c | 49 +++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_userspace.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6c20765..7e9e2bb 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1655,6 +1655,13 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
 	help
 	  Use panic watchdog pretimeout governor by default.
 
+config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_USERSPACE
+	bool "userspace"
+	select WATCHDOG_PRETIMEOUT_GOV_USERSPACE
+	help
+	  Use userspace notifier watchdog pretimeout governor
+	  by default.
+
 endchoice
 
 config WATCHDOG_PRETIMEOUT_GOV_NOOP
@@ -1669,6 +1676,13 @@ config WATCHDOG_PRETIMEOUT_GOV_PANIC
 	  Panic watchdog pretimeout governor, on watchdog pretimeout
 	  event the kernel shall panic.
 
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
index cdcaa8a..7d6755b 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -10,6 +10,7 @@ watchdog-objs	+= watchdog_core.o watchdog_dev.o
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_USERSPACE)	+= pretimeout_userspace.o
 
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
diff --git a/drivers/watchdog/pretimeout_userspace.c b/drivers/watchdog/pretimeout_userspace.c
new file mode 100644
index 0000000..ff3c9e7
--- /dev/null
+++ b/drivers/watchdog/pretimeout_userspace.c
@@ -0,0 +1,49 @@
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
+#include <watchdog_pretimeout.h>
+
+/**
+ * pretimeout_userspace - Notify userspace on watchdog pretimeout event
+ * @wdd - watchdog_device
+ *
+ * Send watchdog device uevent to userspace to handle pretimeout event
+ */
+static void pretimeout_userspace(struct watchdog_device *wdd)
+{
+	kobject_uevent(&wdd->dev->kobj, KOBJ_CHANGE);
+}
+
+static struct watchdog_governor watchdog_gov_userspace = {
+	.name		= "userspace",
+	.pretimeout	= pretimeout_userspace,
+#ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_USERSPACE
+	.is_default	= true,
+#endif
+};
+
+static int __init watchdog_gov_userspace_register(void)
+{
+	return watchdog_register_governor(&watchdog_gov_userspace);
+}
+
+static void __exit watchdog_gov_userspace_unregister(void)
+{
+	watchdog_unregister_governor(&watchdog_gov_userspace);
+}
+module_init(watchdog_gov_userspace_register);
+module_exit(watchdog_gov_userspace_unregister);
+
+MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
+MODULE_DESCRIPTION("Userspace notifier watchdog pretimeout governor");
+MODULE_LICENSE("GPL");
-- 
2.1.4

