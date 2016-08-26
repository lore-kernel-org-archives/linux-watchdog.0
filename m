Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:49333 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754272AbcHZQIP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 Aug 2016 12:08:15 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v4 5/7] watchdog: pretimeout: add noop pretimeout governor
Date: Fri, 26 Aug 2016 19:07:59 +0300
Message-ID: <1472227681-1405-6-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Noop watchdog pretimeout governor, only an informational message is
added to the kernel log buffer.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v3 to v4:
* returned tristate option back
* report watchdog name in a message given by noop governor (Wolfram)

Changes from v2 to v3:
* temporarily removed tristate option, the governor can be built-in only

Changes from v1 to v2:
* removed #ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP,
  now this selection is done in a centralized manner,
* added module owner reference to count users of the governor,
* slightly improved description of the governors in Kconfig.

 drivers/watchdog/Kconfig               | 14 ++++++++++
 drivers/watchdog/Makefile              |  1 +
 drivers/watchdog/pretimeout_noop.c     | 47 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  2 ++
 4 files changed, 64 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_noop.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5f82a3fd2186..7d791fc02c42 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1856,6 +1856,14 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
 	  a watchdog pretimeout event happens, consider that
 	  a watchdog feeder is dead and reboot is unavoidable.
 
+config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
+	bool "noop"
+	select WATCHDOG_PRETIMEOUT_GOV_NOOP
+	help
+	  Use noop watchdog pretimeout governor by default. If noop
+	  governor is selected by a user, write a short message to
+	  the kernel log buffer and don't do any system changes.
+
 endchoice
 
 config WATCHDOG_PRETIMEOUT_GOV_PANIC
@@ -1864,6 +1872,12 @@ config WATCHDOG_PRETIMEOUT_GOV_PANIC
 	  Panic watchdog pretimeout governor, on watchdog pretimeout
 	  event put the kernel into panic.
 
+config WATCHDOG_PRETIMEOUT_GOV_NOOP
+	tristate "Noop watchdog pretimeout governor"
+	help
+	  Noop watchdog pretimeout governor, only an informational
+	  message is added to kernel log buffer.
+
 endif # WATCHDOG_PRETIMEOUT_GOV
 
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 179df1d63c32..c7925ee2d971 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -10,6 +10,7 @@ watchdog-objs	+= watchdog_core.o watchdog_dev.o
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
 
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
 
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
diff --git a/drivers/watchdog/pretimeout_noop.c b/drivers/watchdog/pretimeout_noop.c
new file mode 100644
index 000000000000..47bf8206c85f
--- /dev/null
+++ b/drivers/watchdog/pretimeout_noop.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2015-2016 Mentor Graphics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/watchdog.h>
+
+#include <watchdog_pretimeout.h>
+
+/**
+ * pretimeout_noop - No operation on watchdog pretimeout event
+ * @wdd - watchdog_device
+ *
+ * This function prints a message about pretimeout to kernel log.
+ */
+static void pretimeout_noop(struct watchdog_device *wdd)
+{
+	pr_alert("watchdog%d: pretimeout event\n", wdd->id);
+}
+
+static struct watchdog_governor watchdog_gov_noop = {
+	.name		= "noop",
+	.pretimeout	= pretimeout_noop,
+};
+
+static int __init watchdog_gov_noop_register(void)
+{
+	return watchdog_register_governor(&watchdog_gov_noop);
+}
+
+static void __exit watchdog_gov_noop_unregister(void)
+{
+	watchdog_unregister_governor(&watchdog_gov_noop);
+}
+module_init(watchdog_gov_noop_register);
+module_exit(watchdog_gov_noop_unregister);
+
+MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
+MODULE_DESCRIPTION("Panic watchdog pretimeout governor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index fea56bd42379..8f9804c2dd88 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -22,6 +22,8 @@ int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf);
 
 #if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"panic"
+#elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"noop"
 #endif
 
 #else
-- 
2.8.1

