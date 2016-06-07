Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:39281 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058AbcFGRjK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 13:39:10 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: Wolfram Sang <wsa@the-dreams.de>,
	Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/6] watchdog: pretimeout: add noop pretimeout governor
Date: Tue, 7 Jun 2016 20:38:47 +0300
Message-ID: <1465321127-19522-7-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Noop watchdog pretimeout governor, only an informational message is
added to the kernel log buffer.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v2 to v3:
* temporarily removed tristate option, the governor can be built-in only

Changes from v1 to v2:
* removed #ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP,
  now this selection is done in a centralized manner,
* added module owner reference to count users of the governor,
* slightly improved description of the governors in Kconfig.

 drivers/watchdog/Kconfig               | 11 ++++++++
 drivers/watchdog/Makefile              |  1 +
 drivers/watchdog/pretimeout_noop.c     | 47 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  2 ++
 4 files changed, 61 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_noop.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index bf5938a..aee2eca 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1826,11 +1826,22 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
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
 	bool
 
+config WATCHDOG_PRETIMEOUT_GOV_NOOP
+	bool
+
 endif # WATCHDOG_PRETIMEOUT_GOV
 
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 12df9c7..712f5bd 100644
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
index 0000000..7ea8ed3
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
+	pr_alert("watchdog pretimeout event\n");
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
index 8f2565e..86ddcbd 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -24,6 +24,8 @@ int watchdog_pretimeout_governor_name(struct watchdog_device *wdd, char *buf);
 
 #if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"panic"
+#elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"noop"
 #endif
 
 #else
-- 
2.5.0

