Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225519ADA4;
	Tue,  7 Jul 2026 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409515; cv=none; b=n8qTgXsEufpivCuOPkEDUNwGn2sRzj+RO8AaamHW1pgWvD2SptvsvacQRaHrNldlYPzGmwHSG5uGmZQL6eNWx7QTHiWF7g+pLxFXPzbtiszT/wtixCyZIjWKlXpwgpsRgKlO7ufqZmsmne169ovL4KMegGLklotzsbJkGMqtPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409515; c=relaxed/simple;
	bh=8fug/FuI+r3S1oe8fzxU9+acMSnkqYq38sV7zEN7Ulw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GE58aIeoA8kvUw5ujtbvIr/SCxGMjsBn32vQZXteZ1/WCJ1aShbmxzbRgFFTgmrkdgsBAd1/cEHx4wOQdx+j6sPg2s0rgmlFrxksNfqmiWx8Oi45488GqWyFecABhq8dU1vxRQcalC9EQefsK2k7CoyYG1r29KqO+bgET2oqAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYOyQdEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYOyQdEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533C11F000E9;
	Tue,  7 Jul 2026 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409513;
	bh=zWNRlC0BCn/3VNWCcaDdEwQxsxnSyC5bD64PD3xFzyg=;
	h=From:To:Cc:Subject:Date;
	b=UYOyQdEEmPBuh5LDvAKmtYRkDTkeSOyCQLlJy2QOxfT86zg8vPTHbxv1YUyPTocbG
	 RbpkekIIGhx0w9gcdoJJNQHskrzovhdmxe5CToM/3IV3C4THFvfdf9YuTxKrqHEkw0
	 kkw+DyD8Ag4dibfMTQUilYxzBSJJkUHgTHB2+KZJJ0G8itq9xoIbG1lWQlU7GgEG7I
	 FE8Yiy2ssVtgW3q6vddF8qKn6zXePoNalci1G+0OVoQiCuM9Yo7grxgQALERw3T88o
	 nLMRmOHqjVc8IqziupAujSITGU/ODW8yq6rPLCTtNRehJAePrj/Nh5G/3qOCYA9G/1
	 zSMM0xjzJ73gA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: tfiga@chromium.org,
	tzungbi@kernel.org,
	sboyd@kernel.org,
	dianders@chromium.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: pretimeout: Add "dump" pretimeout governor
Date: Tue,  7 Jul 2026 07:31:17 +0000
Message-ID: <20260707073117.2962676-1-tzungbi@kernel.org>
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
 drivers/watchdog/Kconfig               | 19 ++++++++++-
 drivers/watchdog/Makefile              |  1 +
 drivers/watchdog/pretimeout_dump.c     | 45 ++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  4 ++-
 4 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 drivers/watchdog/pretimeout_dump.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08cb8612d41f..7b291ea8b0f0 100644
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
+	tristate "Dump watchdog pretimeout governor"
+	depends on WATCHDOG_CORE
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

