Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:51908 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbcJGMkL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Oct 2016 08:40:11 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v6 3/7] watchdog: pretimeout: add panic pretimeout governor
Date: Fri, 7 Oct 2016 15:39:56 +0300
Message-ID: <1475843999-25978-3-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1475843826-25830-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1475843826-25830-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The change adds panic watchdog pretimeout governor, on watchdog
pretimeout event the kernel shall panic. In general watchdog
pretimeout event means that something essentially bad is going on the
system, for example a process scheduler stalls or watchdog feeder is
killed due to OOM, so printing out information attendant to panic and
before likely unavoidable reboot caused by a watchdog may help to
determine a root cause of the issue.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes from v5 to v6:
* per Wim's change request for v6 series the default pretimeout governor
  is set to be noop, panic is the secondary option,
* extended a commit message with a description why panic may be helpful,
* added commit tags given by Guenter and Wolfram for v5.

Changes from v4 to v5:
* fixed in source tree compilation issue, thanks to Wolfram

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
 drivers/watchdog/pretimeout_panic.c    | 47 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.c |  6 ++---
 drivers/watchdog/watchdog_pretimeout.h |  2 ++
 5 files changed, 66 insertions(+), 4 deletions(-)
 create mode 100644 drivers/watchdog/pretimeout_panic.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4aeb8f95beb4..cbd33321c0f8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1856,6 +1856,14 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
 	  governor is selected by a user, write a short message to
 	  the kernel log buffer and don't do any system changes.
 
+config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
+	bool "panic"
+	select WATCHDOG_PRETIMEOUT_GOV_PANIC
+	help
+	  Use panic watchdog pretimeout governor by default, if
+	  a watchdog pretimeout event happens, consider that
+	  a watchdog feeder is dead and reboot is unavoidable.
+
 endchoice
 
 config WATCHDOG_PRETIMEOUT_GOV_NOOP
@@ -1864,6 +1872,12 @@ config WATCHDOG_PRETIMEOUT_GOV_NOOP
 	  Noop watchdog pretimeout governor, only an informational
 	  message is added to kernel log buffer.
 
+config WATCHDOG_PRETIMEOUT_GOV_PANIC
+	tristate "Panic watchdog pretimeout governor"
+	help
+	  Panic watchdog pretimeout governor, on watchdog pretimeout
+	  event put the kernel into panic.
+
 endif # WATCHDOG_PRETIMEOUT_GOV
 
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 0502a21db1db..1a34c6a96988 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -10,6 +10,7 @@ watchdog-objs	+= watchdog_core.o watchdog_dev.o
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
 
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
 
 # Only one watchdog can succeed. We probe the ISA/PCI/USB based
 # watchdog-cards first, then the architecture specific watchdog
diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
new file mode 100644
index 000000000000..0c197a1c97f4
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
+	panic("watchdog pretimeout event\n");
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
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 72612255fb55..098c965f6c78 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -60,7 +60,8 @@ int watchdog_register_governor(struct watchdog_governor *gov)
 {
 	struct watchdog_pretimeout *p;
 
-	if (!default_gov) {
+	if (!strncmp(gov->name, WATCHDOG_PRETIMEOUT_DEFAULT_GOV,
+		     WATCHDOG_GOV_NAME_MAXLEN)) {
 		spin_lock_irq(&pretimeout_lock);
 		default_gov = gov;
 
@@ -79,9 +80,6 @@ void watchdog_unregister_governor(struct watchdog_governor *gov)
 	struct watchdog_pretimeout *p;
 
 	spin_lock_irq(&pretimeout_lock);
-	if (gov == default_gov)
-		default_gov = NULL;
-
 	list_for_each_entry(p, &pretimeout_list, entry)
 		if (p->wdd->gov == gov)
 			p->wdd->gov = default_gov;
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index c4b6f88dc9c9..867492aa7ea6 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -22,6 +22,8 @@ int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf);
 
 #if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"noop"
+#elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"panic"
 #endif
 
 #else
-- 
2.8.1

