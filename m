Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53519 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756020AbbFOPAu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jun 2015 11:00:50 -0400
From: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
Subject: [PATCH] TCO watchdog pretimeout handler
Date: Mon, 15 Jun 2015 17:00:29 +0200
Message-Id: <1434380429-1069-1-git-send-email-francois-nicolas.muller@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use TCO watchdog first timeout (pretimeout) to dump CPU backtraces and ease
debug of watchdog expiration causes.
TCO logic generates a SCI interrupt, then its handler dumps all CPU backtraces
and calls panic (in order to execute registered panic callbacks).
SCI interrupt number (GPE) is configured from ACPI tables.

Change-Id: If7badb962008ff38560a02575d0d41f6aaa5f7fd
Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
---
 drivers/watchdog/iTCO_wdt.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index cf8c50d..3dd4175 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -67,6 +67,8 @@
 #include <linux/io.h>			/* For inb/outb/... */
 #include <linux/mfd/core.h>
 #include <linux/mfd/lpc_ich.h>
+#include <linux/nmi.h>
+#include <linux/acpi.h>
 
 #include "iTCO_vendor.h"
 
@@ -124,6 +126,13 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
 MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
 	"Turn off SMI clearing watchdog (depends on TCO-version)(default=1)");
 
+#define DEFAULT_PRETIMEOUT 0
+static bool pretimeout = DEFAULT_PRETIMEOUT;
+module_param(pretimeout, bool, 0);
+MODULE_PARM_DESC(pretimeout,
+	"Enable watchdog pretimeout (default="
+	__MODULE_STRING(DEFAULT_PRETIMEOUT) ")");
+
 static int iTCO_wdt_active = 0;
 
 /*
@@ -200,6 +209,45 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
 	return ret; /* returns: 0 = OK, -EIO = Error */
 }
 
+static unsigned char *tco_hid = "8086229C";
+
+static u32 iTCO_wdt_pretimeout_handler(acpi_handle gpe_device, u32 gpe,
+					void *context)
+{
+	/* dump backtraces for all available cores */
+	trigger_all_cpu_backtrace();
+
+	/* call panic notifiers */
+	panic("Kernel Watchdog");
+
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static acpi_status __init iTCO_wdt_register_gpe(acpi_handle handle,
+					u32 lvl, void *context, void **rv)
+{
+	unsigned long long gpe;
+	acpi_status status;
+	union acpi_object object = { 0 };
+	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
+
+	status = acpi_evaluate_object(handle, "_GPE", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	if (object.type != ACPI_TYPE_INTEGER)
+		return AE_BAD_DATA;
+
+	gpe = object.integer.value;
+	status = acpi_install_gpe_handler(NULL, gpe, ACPI_GPE_EDGE_TRIGGERED,
+					  iTCO_wdt_pretimeout_handler, NULL);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	acpi_enable_gpe(NULL, gpe);
+	return AE_OK;
+}
+
 static int iTCO_wdt_start(struct watchdog_device *wd_dev)
 {
 	unsigned int val;
@@ -625,6 +673,9 @@ static int __init iTCO_wdt_init_module(void)
 	if (err)
 		return err;
 
+	if (pretimeout)
+		acpi_get_devices(tco_hid, iTCO_wdt_register_gpe, NULL, NULL);
+
 	return 0;
 }
 
-- 
1.9.1

