Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:40908 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbbKUHNl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Nov 2015 02:13:41 -0500
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH 2/6] watchdog: pretimeout: add noop pretimeout governor
Date: Sat, 21 Nov 2015 09:11:46 +0200
Message-ID: <1448089910-11453-3-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Noop watchdog pretimeout governor, only an informational message is
added to the kernel log buffer.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/watchdog/Kconfig           | 26 ++++++++++++++++++++
 drivers/watchdog/Makefile          |  1 +
 drivers/watchdog/pretimeout_noop.c | 49 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_noop.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index eeb515c..4940c3b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1633,4 +1633,30 @@ config WATCHDOG_PRETIMEOUT_GOV
 	help
 	  The option allows to select watchdog pretimeout governors.
 
+if WATCHDOG_PRETIMEOUT_GOV
+
+choice
+	prompt "Default Watchdog Pretimeout Governor"
+	default WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
+	help
+	  This option selects a default watchdog pretimeout governor.
+	  The governor takes its action, if a watchdog is capable
+	  to report a pretimeout event.
+
+config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
+	bool "noop"
+	select WATCHDOG_PRETIMEOUT_GOV_NOOP
+	help
+	  Use noop watchdog pretimeout governor by default.
+
+endchoice
+
+config WATCHDOG_PRETIMEOUT_GOV_NOOP
+	tristate "Noop watchdog pretimeout governor"
+	help
+	  Noop watchdog pretimeout governor, only an informational
+	  message is added to kernel log buffer.
+
+endif # WATCHDOG_PRETIMEOUT_GOV
+
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 6749cac..16a9e32 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_WATCHDOG_CORE)	+= watchdog.o
 watchdog-objs	+= watchdog_core.o watchdog_dev.o
 
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
 
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
diff --git a/drivers/watchdog/pretimeout_noop.c b/drivers/watchdog/pretimeout_noop.c
new file mode 100644
index 0000000..27c3bf9
--- /dev/null
+++ b/drivers/watchdog/pretimeout_noop.c
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
+#ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
+	.is_default	= true,
+#endif
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
-- 
2.1.4

