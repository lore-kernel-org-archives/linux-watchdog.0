Return-path: <Vladimir_Zapolskiy@mentor.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v2 3/4] watchdog: pretimeout: add noop pretimeout governor
Date: Sun, 29 Nov 2015 14:10:51 +0200
Message-ID: <1448799052-18984-4-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1448799052-18984-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1448799052-18984-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Noop watchdog pretimeout governor, only an informational message is
added to the kernel log buffer.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v1 to v2:
* removed #ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP,
  now this selection is done in a centralized manner,
* added module owner reference to count users of the governor,
* slightly improved description of the governors in Kconfig.

 drivers/watchdog/Kconfig               | 15 +++++++++++
 drivers/watchdog/Makefile              |  1 +
 drivers/watchdog/pretimeout_noop.c     | 47 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  2 ++
 4 files changed, 65 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_noop.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8eccc93..48062ec 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1651,6 +1651,14 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
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
@@ -1660,6 +1668,13 @@ config WATCHDOG_PRETIMEOUT_GOV_PANIC
 	  governor, on a watchdog pretimeout event the kernel shall
 	  panic before an expected system reboot.
 
+config WATCHDOG_PRETIMEOUT_GOV_NOOP
+	tristate "Noop watchdog pretimeout governor"
+	help
+	  Select this option to enable noop watchdog pretimeout
+	  governor, only an informational message is added to the
+	  kernel log buffer, if watchdog pretimeout is happened.
+
 endif # WATCHDOG_PRETIMEOUT_GOV
 
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 127f342..b45b1ef 100644
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
index 0000000..082eff7
--- /dev/null
+++ b/drivers/watchdog/pretimeout_noop.c
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
+	dev_info(wdd->dev, "watchdog pretimeout event\n");
+}
+
+static struct watchdog_governor watchdog_gov_noop = {
+	.name		= "noop",
+	.pretimeout	= pretimeout_noop,
+	.owner		= THIS_MODULE,
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
+MODULE_DESCRIPTION("Noop watchdog pretimeout governor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index cf28267..2124a173 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -22,6 +22,8 @@ void watchdog_unregister_governor(struct watchdog_governor *gov);
 
 #if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"panic"
+#elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"noop"
 #else
 #error "Default watchdog pretimeout governor is not set."
 #endif
-- 
2.5.0
