Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:39276 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064AbcFGRi7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 13:38:59 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: Wolfram Sang <wsa@the-dreams.de>,
	Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/6] watchdog: pretimeout: add panic pretimeout governor
Date: Tue, 7 Jun 2016 20:38:46 +0300
Message-ID: <1465321127-19522-6-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Panic watchdog pretimeout governor, on watchdog pretimeout event the
kernel shall panic.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v2 to v3:
* temporarily removed tristate option, the governor can be built-in only

Changes from v1 to v2:
* removed #ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC,
  now this selection is done in a centralized manner,
* added module owner reference to count users of the governor,
* slightly improved description of the governors in Kconfig.

 drivers/watchdog/Kconfig               | 25 ++++++++++++++++++
 drivers/watchdog/Makefile              |  2 ++
 drivers/watchdog/pretimeout_panic.c    | 47 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  4 +++
 4 files changed, 78 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_panic.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 354217e..bf5938a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1808,4 +1808,29 @@ config WATCHDOG_PRETIMEOUT_GOV
 	help
 	  The option allows to select watchdog pretimeout governors.
 
+if WATCHDOG_PRETIMEOUT_GOV
+
+choice
+	prompt "Default Watchdog Pretimeout Governor"
+	default WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
+	help
+	  This option selects a default watchdog pretimeout governor.
+	  The governor takes its action, if a watchdog is capable
+	  to report a pretimeout event.
+
+config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
+	bool "panic"
+	select WATCHDOG_PRETIMEOUT_GOV_PANIC
+	help
+	  Use panic watchdog pretimeout governor by default, if
+	  a watchdog pretimeout event happens, consider that
+	  a watchdog feeder is dead and reboot is unavoidable.
+
+endchoice
+
+config WATCHDOG_PRETIMEOUT_GOV_PANIC
+	bool
+
+endif # WATCHDOG_PRETIMEOUT_GOV
+
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index cca47de..12df9c7 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -9,6 +9,8 @@ watchdog-objs	+= watchdog_core.o watchdog_dev.o
 
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
 
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
+
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
 # drivers and then the architecture independent "softdog" driver.
diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
new file mode 100644
index 0000000..4d5338d
--- /dev/null
+++ b/drivers/watchdog/pretimeout_panic.c
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
+#include <linux/kernel.h>
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
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index 9e08d56..8f2565e 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -22,6 +22,10 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd);
 /* Interfaces to watchdog_dev.c */
 int watchdog_pretimeout_governor_name(struct watchdog_device *wdd, char *buf);
 
+#if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"panic"
+#endif
+
 #else
 static inline int watchdog_register_pretimeout(struct watchdog_device *wdd)
 {
-- 
2.5.0

