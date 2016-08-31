Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:38186 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbcHaLw4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Aug 2016 07:52:56 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v5 04/10] watchdog: pretimeout: add panic pretimeout governor
Date: Wed, 31 Aug 2016 14:52:44 +0300
Message-ID: <1472644370-16982-5-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The change adds panic watchdog pretimeout governor, on watchdog
pretimeout event the kernel shall panic.

While introducing the first pretimeout governor the selected design
assumes that the default pretimeout governor is selected by its name
and it is always built-in, thus the default pretimeout governor can
not be unregistered and the correspondent check can be removed from
watchdog_unregister_governor() function.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v4 to v5:
* fixed in source tree compilation issue, thanks to Wolfram

Changes from v3 to v4:
* returned tristate option back, it is safe to have it, because
  the single governor is the default one, thus it is built-in, but with
  the introduction of another governor it should be tristate
* removed "panic panic" duplication in a user's message (Wolfram)
* added minor changes to watchdog_pretimeout.c to support built time
  selectable default governor

Changes from v2 to v3:
* temporarily removed tristate option, the governor can be built-in only

Changes from v1 to v2:
* removed #ifdef CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC,
  now this selection is done in a centralized manner,
* added module owner reference to count users of the governor,
* slightly improved description of the governors in Kconfig.

 drivers/watchdog/Kconfig               | 28 ++++++++++++++++++++
 drivers/watchdog/Makefile              |  2 ++
 drivers/watchdog/pretimeout_panic.c    | 47 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.c |  6 ++---
 drivers/watchdog/watchdog_pretimeout.h |  4 +++
 5 files changed, 83 insertions(+), 4 deletions(-)
 create mode 100644 drivers/watchdog/pretimeout_panic.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 04d535ae497d..5f82a3fd2186 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1838,4 +1838,32 @@ config WATCHDOG_PRETIMEOUT_GOV
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
+	  Panic watchdog pretimeout governor, on watchdog pretimeout
+	  event put the kernel into panic.
+
+endif # WATCHDOG_PRETIMEOUT_GOV
+
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 990c36ed4716..179df1d63c32 100644
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
index c6cd9f80adb2..fea56bd42379 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -20,6 +20,10 @@ int watchdog_register_pretimeout(struct watchdog_device *wdd);
 void watchdog_unregister_pretimeout(struct watchdog_device *wdd);
 int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf);
 
+#if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"panic"
+#endif
+
 #else
 static inline int watchdog_register_pretimeout(struct watchdog_device *wdd)
 {
-- 
2.8.1

