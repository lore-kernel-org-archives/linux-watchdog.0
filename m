Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:40916 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbbKUHNq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Nov 2015 02:13:46 -0500
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH 3/6] watchdog: pretimeout: add panic pretimeout governor
Date: Sat, 21 Nov 2015 09:11:47 +0200
Message-ID: <1448089910-11453-4-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1448089910-11453-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Panic watchdog pretimeout governor, on watchdog pretimeout event the
kernel shall panic.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/watchdog/Kconfig            | 12 +++++++++
 drivers/watchdog/Makefile           |  1 +
 drivers/watchdog/pretimeout_panic.c | 49 +++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_panic.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4940c3b..6c20765 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1649,6 +1649,12 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
 	help
 	  Use noop watchdog pretimeout governor by default.
 
+config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
+	bool "panic"
+	select WATCHDOG_PRETIMEOUT_GOV_PANIC
+	help
+	  Use panic watchdog pretimeout governor by default.
+
 endchoice
 
 config WATCHDOG_PRETIMEOUT_GOV_NOOP
@@ -1657,6 +1663,12 @@ config WATCHDOG_PRETIMEOUT_GOV_NOOP
 	  Noop watchdog pretimeout governor, only an informational
 	  message is added to kernel log buffer.
 
+config WATCHDOG_PRETIMEOUT_GOV_PANIC
+	tristate "Panic watchdog pretimeout governor"
+	help
+	  Panic watchdog pretimeout governor, on watchdog pretimeout
+	  event the kernel shall panic.
+
 endif # WATCHDOG_PRETIMEOUT_GOV
 
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 16a9e32..cdcaa8a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -9,6 +9,7 @@ watchdog-objs	+= watchdog_core.o watchdog_dev.o
 
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
 
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
new file mode 100644
index 0000000..555de7e
--- /dev/null
+++ b/drivers/watchdog/pretimeout_panic.c
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
+ * pretimeout_panic - Panic on watchdog pretimeout event
+ * @wdd - watchdog_device
+ *
+ * Panic, watchdog has not been fed till pretimeout event.
+ */
+static void pretimeout_panic(struct watchdog_device *wdd)
+{
+	panic("panic on watchdog pretimeout event\n");
+}
+
+static struct watchdog_governor watchdog_gov_panic = {
+	.name		= "panic",
+	.pretimeout	= pretimeout_panic,
+#ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
+	.is_default	= true,
+#endif
+};
+
+static int __init watchdog_gov_panic_register(void)
+{
+	return watchdog_register_governor(&watchdog_gov_panic);
+}
+
+static void __exit watchdog_gov_panic_unregister(void)
+{
+	watchdog_unregister_governor(&watchdog_gov_panic);
+}
+module_init(watchdog_gov_panic_register);
+module_exit(watchdog_gov_panic_unregister);
+
+MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
+MODULE_DESCRIPTION("Panic watchdog pretimeout governor");
+MODULE_LICENSE("GPL");
-- 
2.1.4

