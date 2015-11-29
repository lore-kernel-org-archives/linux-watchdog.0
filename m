Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:50213 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbK2MMT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 29 Nov 2015 07:12:19 -0500
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v2 4/4] watchdog: pretimeout: add userspace notifier pretimeout governor
Date: Sun, 29 Nov 2015 14:10:52 +0200
Message-ID: <1448799052-18984-5-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1448799052-18984-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1448799052-18984-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Userspace notifier watchdog pretimeout governor, on watchdog
pretimeout event sends a notification to userspace for further
handling.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v1 to v2:
* removed #ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_USERSPACE,
  now this selection is done in a centralized manner,
* added .can_sleep attribute,
* added module owner reference to count users of the governor,
* slightly improved description of the governors in Kconfig.

 drivers/watchdog/Kconfig                | 16 +++++++++++
 drivers/watchdog/Makefile               |  1 +
 drivers/watchdog/pretimeout_userspace.c | 48 +++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h  |  2 ++
 4 files changed, 67 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_userspace.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 48062ec..31e67f4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1659,6 +1659,15 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
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
@@ -1675,6 +1684,13 @@ config WATCHDOG_PRETIMEOUT_GOV_NOOP
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
index b45b1ef..2dd91ae 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -11,6 +11,7 @@ watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
 
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_USERSPACE)	+= pretimeout_userspace.o
 
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
diff --git a/drivers/watchdog/pretimeout_userspace.c b/drivers/watchdog/pretimeout_userspace.c
new file mode 100644
index 0000000..bdaa70c
--- /dev/null
+++ b/drivers/watchdog/pretimeout_userspace.c
@@ -0,0 +1,48 @@
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
+	.can_sleep	= true,
+	.owner		= THIS_MODULE,
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
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index 2124a173..21c6b72 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -24,6 +24,8 @@ void watchdog_unregister_governor(struct watchdog_governor *gov);
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"panic"
 #elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"noop"
+#elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_USERSPACE)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"userspace"
 #else
 #error "Default watchdog pretimeout governor is not set."
 #endif
-- 
2.5.0

