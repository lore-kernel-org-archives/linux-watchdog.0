Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FA3E0C7A;
	Tue,  7 Jul 2026 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419690; cv=none; b=rKPuDAen69E47bMj/A9NAvgP2afJ30LWeEkHZAEhgcKaTMedjqpXbe9IWCUg9To5dJQGI2CZ/hzV7Q1b2eCJih2Dfax/UCqXnuhOhiRMt7agewbFxuF7ejZg+b/1q0fPOTejE0ML7+/leZmb7J5g1kOyW+v7tZlYWWNiHrhjfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419690; c=relaxed/simple;
	bh=hkCkuW0/oiapqFK7e2e/XyRBn27uc+/w4kSoUarN0uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGBoaFreYlkA/mQklJX5KVzLd6MRYxmaa1P+6xCYC3dH3ZfAFrEQlNHbCq2Kgzwvxzfatu6spycxt+3rVk/69eIZnE6NJlx48W2G2lQy59CfDJ7c2JScR6iNXtZLWC/OaPw5lP+hSp6OK7xvg7tgoorWkxUCuWbckd4n6asbO5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka/i58Vs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka/i58Vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FA71F000E9;
	Tue,  7 Jul 2026 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419689;
	bh=Z7U88BnSQU5hB0eAl4IccbWD9oaTHkfGP+TLeXWobEQ=;
	h=From:To:Cc:Subject:Date;
	b=ka/i58VsbH/Cp7zpdB9SAdCsVrWBNHsL7DO64e+sRxtl6hV+z3ZbzQq3d1CwhKMTO
	 DWeXOf2Q1D7gV9HBZ/0Hm53hiXNI0ADudidav50aJodsldSblh2MZo0O1fJ2Jt7ehW
	 eTTdhOnRKfcE2/PsNEoQC4jEUvS8D0qNhc6/Q3yF0SGLo3x9WGdSp6reUYshqqgIZA
	 02MwAZxmp5ghYvl9tC9xi1N5tJSRFafIdjpUmJrsbiO1MO4nJJPvyN+jMD99OXw4p8
	 TjcTaaZ6G5cBPbkbCykFOR1AUXbWHl6Y/tY85LURVX/uJFaghNP0veyfahmwShN+hv
	 KEav5zLOSJ+pQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: tfiga@chromium.org,
	tzungbi@kernel.org,
	sboyd@kernel.org,
	dianders@chromium.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: pretimeout: Add "dump" pretimeout governor
Date: Tue,  7 Jul 2026 10:21:05 +0000
Message-ID: <20260707102105.3600275-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new "dump" pretimeout governor that triggers a backtrace of all
CPUs (via trigger_all_cpu_backtrace()) to the kernel log buffer.  This
provides diagnostic information right before the hardware watchdog
fires.

In addition, update the WATCHDOG_PRETIMEOUT_GOV_SEL Kconfig logic to
fall back to the "panic" governor only when both "noop" and "dump"
governors are disabled.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Alternatives considered:
We can also introduce some options and put trigger_all_cpu_backtrace()
into the existing "noop" governor.
---
v2:
- Change "tristate" -> "bool" for WATCHDOG_PRETIMEOUT_GOV_DUMP.

v1: https://lore.kernel.org/all/20260707073117.2962676-1-tzungbi@kernel.org
---
 drivers/watchdog/Kconfig               | 19 ++++++++++-
 drivers/watchdog/Makefile              |  1 +
 drivers/watchdog/pretimeout_dump.c     | 45 ++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  4 ++-
 4 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 drivers/watchdog/pretimeout_dump.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08cb8612d41f..c93bc0d285f0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -93,10 +93,19 @@ config WATCHDOG_PRETIMEOUT_GOV_SEL
 	tristate
 	depends on WATCHDOG_PRETIMEOUT_GOV
 	default m
-	select WATCHDOG_PRETIMEOUT_GOV_PANIC if WATCHDOG_PRETIMEOUT_GOV_NOOP=n
+	select WATCHDOG_PRETIMEOUT_GOV_PANIC if \
+		WATCHDOG_PRETIMEOUT_GOV_NOOP=n && WATCHDOG_PRETIMEOUT_GOV_DUMP=n
 
 if WATCHDOG_PRETIMEOUT_GOV
 
+config WATCHDOG_PRETIMEOUT_GOV_DUMP
+	bool "Dump watchdog pretimeout governor"
+	depends on WATCHDOG_CORE=y
+	default WATCHDOG_CORE
+	help
+	  Dump watchdog pretimeout governor, all cpu backtrace is
+	  added to kernel log buffer.
+
 config WATCHDOG_PRETIMEOUT_GOV_NOOP
 	tristate "Noop watchdog pretimeout governor"
 	depends on WATCHDOG_CORE
@@ -121,6 +130,14 @@ choice
 	  The governor takes its action, if a watchdog is capable
 	  to report a pretimeout event.
 
+config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_DUMP
+	bool "dump"
+	depends on WATCHDOG_PRETIMEOUT_GOV_DUMP
+	help
+	  Use dump watchdog pretimeout governor by default. If dump
+	  governor is selected by a user, dump all cpu backtrace to
+	  the kernel log buffer and don't do any system changes.
+
 config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
 	bool "noop"
 	depends on WATCHDOG_PRETIMEOUT_GOV_NOOP
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index bc1d52220f22..598556f03bc3 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -11,6 +11,7 @@ watchdog-objs	+= watchdog_core.o watchdog_dev.o
 watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)	+= watchdog_pretimeout.o
 watchdog-$(CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT)	+= watchdog_hrtimer_pretimeout.o
 
+obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_DUMP)	+= pretimeout_dump.o
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)	+= pretimeout_noop.o
 obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)	+= pretimeout_panic.o
 
diff --git a/drivers/watchdog/pretimeout_dump.c b/drivers/watchdog/pretimeout_dump.c
new file mode 100644
index 000000000000..c5d3dac2606c
--- /dev/null
+++ b/drivers/watchdog/pretimeout_dump.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2026 Google LLC
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nmi.h>
+#include <linux/watchdog.h>
+
+#include "watchdog_pretimeout.h"
+
+/**
+ * pretimeout_dump - Dump on watchdog pretimeout event
+ * @wdd: watchdog_device
+ *
+ * Dump all cpu backtrace on pretimeout event.
+ */
+static void pretimeout_dump(struct watchdog_device *wdd)
+{
+	pr_alert("watchdog%d: pretimeout event\n", wdd->id);
+	if (!trigger_all_cpu_backtrace())
+		pr_alert("trigger_all_cpu_backtrace() isn't available\n");
+}
+
+static struct watchdog_governor watchdog_gov_dump = {
+	.name		= "dump",
+	.pretimeout	= pretimeout_dump,
+};
+
+static int __init watchdog_gov_dump_register(void)
+{
+	return watchdog_register_governor(&watchdog_gov_dump);
+}
+
+static void __exit watchdog_gov_dump_unregister(void)
+{
+	watchdog_unregister_governor(&watchdog_gov_dump);
+}
+module_init(watchdog_gov_dump_register);
+module_exit(watchdog_gov_dump_unregister);
+
+MODULE_AUTHOR("Tzung-Bi Shih <tzungbi@kernel.org>");
+MODULE_DESCRIPTION("Dump watchdog pretimeout governor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index a3f1abc68839..57aa790e2669 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -24,7 +24,9 @@ int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf);
 int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
 				     const char *buf);
 
-#if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
+#if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_DUMP)
+#define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"dump"
+#elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"noop"
 #elif IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"panic"
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

