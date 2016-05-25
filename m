Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36373 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbcEYNct (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 09:32:49 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Robin Gong <b38343@freescale.com>
Subject: [PATCH 3/7] watchdog: pretimeout: add noop pretimeout governor
Date: Wed, 25 May 2016 15:32:27 +0200
Message-Id: <1464183151-4912-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Noop watchdog pretimeout governor, only an informational message is
added to the kernel log buffer.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since Vladimir's last version:

* rebased
* use pr_* now since device pointer became private

 drivers/watchdog/Kconfig               | 15 +++++++++++
 drivers/watchdog/Makefile              |  1 +
 drivers/watchdog/pretimeout_noop.c     | 47 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  2 ++
 4 files changed, 65 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_noop.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 36b7d1f83b3c51..a3ef2bcd94f10c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1800,6 +1800,14 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
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
@@ -1809,6 +1817,13 @@ config WATCHDOG_PRETIMEOUT_GOV_PANIC
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
index 56dfadc0cee2a9..3ad68029916e00 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -9,6 +9,7 @@ watchdog-y += watchdog_core.o watchdog_dev.o
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV) += watchdog_pretimeout.o
 
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC) += pretimeout_panic.o
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP) += pretimeout_noop.o
 
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
diff --git a/drivers/watchdog/pretimeout_noop.c b/drivers/watchdog/pretimeout_noop.c
new file mode 100644
index 00000000000000..91f36aa533b398
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
+#include "watchdog_pretimeout.h"
+
+/**
+ * pretimeout_noop - No operation on watchdog pretimeout event
+ * @wdd - watchdog_device
+ *
+ * This function prints a message about pretimeout to kernel log.
+ */
+static void pretimeout_noop(struct watchdog_device *wdd)
+{
+	pr_info("watchdog%d: pretimeout event\n", wdd->id);
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
+module_init(watchdog_gov_noop_register);
+
+static void __exit watchdog_gov_noop_unregister(void)
+{
+	watchdog_unregister_governor(&watchdog_gov_noop);
+}
+module_exit(watchdog_gov_noop_unregister);
+
+MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
+MODULE_DESCRIPTION("Noop watchdog pretimeout governor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index 8b03fd480cb533..2e60450a2be64e 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -21,6 +21,8 @@ void watchdog_unregister_governor(struct watchdog_governor *gov);
 
 #if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"panic"
+#elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV	"noop"
 #else
 #error "Default watchdog pretimeout governor is not set."
 #endif
-- 
2.8.1

