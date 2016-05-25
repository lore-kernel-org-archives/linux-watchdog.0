Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36370 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbcEYNct (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 09:32:49 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Robin Gong <b38343@freescale.com>
Subject: [PATCH 2/7] watchdog: pretimeout: add panic pretimeout governor
Date: Wed, 25 May 2016 15:32:26 +0200
Message-Id: <1464183151-4912-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Panic watchdog pretimeout governor, on watchdog pretimeout event the
kernel shall panic.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since Vladimir's last version:

* rebased
* shortened the panic message a little (removed redundancy)

 drivers/watchdog/Kconfig               | 29 +++++++++++++++++++++
 drivers/watchdog/Makefile              |  2 ++
 drivers/watchdog/pretimeout_panic.c    | 47 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  6 ++++-
 4 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/watchdog/pretimeout_panic.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 909d1021de5cbc..36b7d1f83b3c51 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1782,4 +1782,33 @@ config WATCHDOG_PRETIMEOUT_GOV
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
+	tristate "Panic watchdog pretimeout governor"
+	help
+	  Select this option to enable panic watchdog pretimeout
+	  governor, on a watchdog pretimeout event the kernel shall
+	  panic before an expected system reboot.
+
+endif # WATCHDOG_PRETIMEOUT_GOV
+
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 820860cf3e8d62..56dfadc0cee2a9 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -8,6 +8,8 @@ obj-$(CONFIG_WATCHDOG_CORE) += watchdog.o
 watchdog-y += watchdog_core.o watchdog_dev.o
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV) += watchdog_pretimeout.o
 
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC) += pretimeout_panic.o
+
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
 # drivers and then the architecture independent "softdog" driver.
diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
new file mode 100644
index 00000000000000..f8c2410d993f02
--- /dev/null
+++ b/drivers/watchdog/pretimeout_panic.c
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
+ * pretimeout_panic - Panic on watchdog pretimeout event
+ * @wdd - watchdog_device
+ *
+ * Panic, watchdog has not been fed till pretimeout event.
+ */
+static void pretimeout_panic(struct watchdog_device *wdd)
+{
+	panic("watchdog pretimeout event");
+}
+
+static struct watchdog_governor watchdog_gov_panic = {
+	.name		= "panic",
+	.pretimeout	= pretimeout_panic,
+	.owner		= THIS_MODULE,
+};
+
+static int __init watchdog_gov_panic_register(void)
+{
+	return watchdog_register_governor(&watchdog_gov_panic);
+}
+module_init(watchdog_gov_panic_register);
+
+static void __exit watchdog_gov_panic_unregister(void)
+{
+	watchdog_unregister_governor(&watchdog_gov_panic);
+}
+module_exit(watchdog_gov_panic_unregister);
+
+MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
+MODULE_DESCRIPTION("Panic watchdog pretimeout governor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index 38965cdd23bebe..8b03fd480cb533 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -19,7 +19,11 @@ void watchdog_unregister_governor(struct watchdog_governor *gov);
 /* Interfaces to watchdog_core.c */
 #ifdef CONFIG_WATCHDOG_PRETIMEOUT_GOV
 
-#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"none"
+#if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"panic"
+#else
+#error "Default watchdog pretimeout governor is not set."
+#endif
 
 int watchdog_register_pretimeout(struct watchdog_device *wdd, struct device *dev);
 void watchdog_unregister_pretimeout(struct watchdog_device *wdd);
-- 
2.8.1

