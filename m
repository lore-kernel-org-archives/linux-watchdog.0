Return-path: <francois-nicolas.muller@intel.com>
From: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Darren Hart <dvhart@infradead.org>,
	"'platform-driver-x86@vger.kernel.org'"
	<platform-driver-x86@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>,
	Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "Wim Van
 Sebroeck" <wim@iguana.be>
Subject: RE: [PATCH] TCO Watchdog warning interrupt driver creation
Date: Tue, 20 Jan 2015 14:25:35 +0000
Message-ID: <B9C02DB17496AC4197F41A146D371B9B075D8202@hasmsx107.ger.corp.intel.com>
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com>
 <20141211040404.GA28797@vmdeb7> <5489AA6B.9080802@roeck-us.net>
 <B9C02DB17496AC4197F41A146D371B9B075C5FE3@hasmsx107.ger.corp.intel.com>
 <E73BFCB9-87CB-447D-839C-9ED4031FC6E2@infradead.org>
 <B9C02DB17496AC4197F41A146D371B9B075C6189@hasmsx107.ger.corp.intel.com>
 <54AF6288.6040305@roeck-us.net>
 <B9C02DB17496AC4197F41A146D371B9B075CC9FA@hasmsx107.ger.corp.intel.com>
 <20150114181657.GB13907@roeck-us.net>
 <B9C02DB17496AC4197F41A146D371B9B075D41C0@hasmsx107.ger.corp.intel.com>
 <54B7D35F.5010907@roeck-us.net>
In-Reply-To: <54B7D35F.5010907@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

The panic is only there for debug purposes at first expiry.
Watchdog timeout behavior (second expiry) is not changed.
I added the panic as a config option, enabled by default.
Fran=E7ois-Nicolas

>From 5e1680aa0df9f49459cdc7211ba80d6934f65fbd Mon Sep 17 00:00:00 2001
From: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
Date: Tue, 20 Jan 2015 14:55:42 +0100
Subject: [PATCH] Adding TCO watchdog warning interrupt handling.

This feature is useful to root cause watchdog expiration.
It is activated by boot parameter 'warn_irq' (disabled by default).

Upon first expiration of the TCO watchdog, a warning interrupt is fired, th=
en
the interrupt handler dumps registers and call stack of all available cpus.
TCO watchdog reloads with 2.4 seconds timeout for second expiration.

If CONFIG_ITCO_WARN_PANIC is set, the warning interrupt also calls panic()
which notifies the panic handlers then reboots the platform, depending on
CONFIG_PANIC_TIMEOUT value :

- If CONFIG_PANIC_TIMEOUT is zero or greater than 3 seconds, TCO watchdog w=
ill
reset the platform if second expiration happens before TCO has been kicked
again.

- If CONFIG_PANIC_TIMEOUT is < 0, platform will reboot immediately (emergen=
cy
restart procedure).

- If CONFIG_PANIC_TIMEOUT is 1 or 2 seconds, platform will reboot after 1 o=
r 2
seconds delay (emergency restart procedure).

Change-Id: I48dcb9d38218c8218e35f9969f064b9d5cf316f1
Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
---
 drivers/watchdog/Kconfig    |   13 +++++++++
 drivers/watchdog/iTCO_wdt.c |   66 +++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79d2589..15c3807 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -674,6 +674,19 @@ config ITCO_VENDOR_SUPPORT
 	  devices. At this moment we only have additional support for some
 	  SuperMicro Inc. motherboards.
=20
+config ITCO_WARNING_PANIC
+	bool "Intel TCO Timer/Watchdog panic on warning interrupt"
+	depends on ITCO_WDT
+	default y
+	---help---
+	  Force a call to panic() when TCO warning interrupt occurs.
+
+	  Warning interrupt happens if warn_irq module parameter is set and
+	  TCO timer first expires.
+
+	  If not set, only cpu backtraces are dumped, no call to panic() and
+	  no notification of panic are done.
+
 config IT8712F_WDT
 	tristate "IT8712F (Smart Guardian) Watchdog Timer"
 	depends on X86
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index e802a54..e7c5169 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -49,6 +49,8 @@
 /* Module and version information */
 #define DRV_NAME	"iTCO_wdt"
 #define DRV_VERSION	"1.11"
+#define DRV_NAME_ACPI	"iTCO_wdt_wirq"
+#define TCO_CLASS	DRV_NAME
=20
 /* Includes */
 #include <linux/module.h>		/* For module specific items */
@@ -68,6 +70,9 @@
 #include <linux/pm.h>			/* For suspend/resume */
 #include <linux/mfd/core.h>
 #include <linux/mfd/lpc_ich.h>
+#include <linux/nmi.h>
+#include <linux/acpi.h>
+#include <acpi/actypes.h>
=20
 #include "iTCO_vendor.h"
=20
@@ -107,6 +112,12 @@ static struct {		/* this is private data for the iTCO_=
wdt device */
 	bool started;
 } iTCO_wdt_private;
=20
+static const struct acpi_device_id iTCO_wdt_ids[] =3D {
+	{"8086229C", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, iTCO_wdt_ids);
+
 /* module parameters */
 #define WATCHDOG_TIMEOUT 30	/* 30 sec default heartbeat */
 static int heartbeat =3D WATCHDOG_TIMEOUT;  /* in seconds */
@@ -126,6 +137,13 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
 MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
 	"Turn off SMI clearing watchdog (depends on TCO-version)(default=3D1)");
=20
+static bool warn_irq;
+module_param(warn_irq, bool, 0);
+MODULE_PARM_DESC(warn_irq,
+	"Dump all cpus backtraces at first watchdog timer expiration (default=3D0=
)");
+
+static bool warn_irq_panic =3D CONFIG_ITCO_WARNING_PANIC;
+
 /*
  * Some TCO specific functions
  */
@@ -200,6 +218,35 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
 	return ret; /* returns: 0 =3D OK, -EIO =3D Error */
 }
=20
+static u32 iTCO_wdt_wirq(acpi_handle gpe_device, u32 gpe, void *context)
+{
+	trigger_all_cpu_backtrace();
+	if (warn_irq_panic)
+		panic("Kernel Watchdog");
+
+	return IRQ_HANDLED;
+}
+
+static int iTCO_wdt_acpi_add(struct acpi_device *device)
+{
+	unsigned long long gpe;
+	acpi_status status;
+
+	status =3D acpi_evaluate_integer(device->handle, "_GPE", NULL, &gpe);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	status =3D acpi_install_gpe_handler(NULL, gpe, ACPI_GPE_EDGE_TRIGGERED,
+					  iTCO_wdt_wirq, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	acpi_enable_gpe(NULL, gpe);
+
+	pr_debug("interrupt=3DSCI GPE=3D0x%02llx", gpe);
+	return 0;
+}
+
 static int iTCO_wdt_start(struct watchdog_device *wd_dev)
 {
 	unsigned int val;
@@ -628,6 +675,15 @@ static struct platform_driver iTCO_wdt_driver =3D {
 	},
 };
=20
+static struct acpi_driver iTCO_wdt_acpi_driver =3D {
+	.name =3D DRV_NAME_ACPI,
+	.class =3D TCO_CLASS,
+	.ids =3D iTCO_wdt_ids,
+	.ops =3D {
+		.add =3D iTCO_wdt_acpi_add,
+	},
+};
+
 static int __init iTCO_wdt_init_module(void)
 {
 	int err;
@@ -638,12 +694,22 @@ static int __init iTCO_wdt_init_module(void)
 	if (err)
 		return err;
=20
+	if (warn_irq) {
+		err =3D acpi_bus_register_driver(&iTCO_wdt_acpi_driver);
+		if (err) {
+			platform_driver_unregister(&iTCO_wdt_driver);
+			return err;
+		}
+	}
+
 	return 0;
 }
=20
 static void __exit iTCO_wdt_cleanup_module(void)
 {
 	platform_driver_unregister(&iTCO_wdt_driver);
+	if (warn_irq)
+		acpi_bus_unregister_driver(&iTCO_wdt_acpi_driver);
 	pr_info("Watchdog Module Unloaded\n");
 }
=20
--=20
1.7.9.5



-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net]=20
Sent: Thursday, January 15, 2015 3:49 PM
To: Muller, Francois-nicolas
Cc: Darren Hart; 'platform-driver-x86@vger.kernel.org'; Rafael Wysocki; Lin=
ux ACPI Mailing List; linux-watchdog@vger.kernel.org; Wim Van Sebroeck
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation

On 01/15/2015 05:27 AM, Muller, Francois-nicolas wrote:
> TCO driver is anyway auto-loaded by mfd driver lpc_ich as a sub-function =
of it.
>
> The aim of my patch is only to add warning interrupt support in TCO drive=
r.
> For this it need the GPE number which is exposed by Bios in acpi tables.
> So the patch registers also the TCO driver as an acpi driver to be able t=
o retrieve this value.
>
> The acpi code part is only required by the interrupt handling support, no=
t needed for the loading of the driver itself (already done by lpc_ich).
>
> In this context I don't see the point of dissociating the driver part fro=
m the loading, unless the loading would need to be reverted later.
>

Ok, makes sense.

Regarding the patch itself, I'll leave it up to Wim to decide what to do.
Personally I dislike the notion of panicing as response to a watchdog timeo=
ut.

Guenter
