Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bon0119.outbound.protection.outlook.com ([157.56.111.119]:39648
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755041AbcBHQG6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 8 Feb 2016 11:06:58 -0500
Date: Mon, 8 Feb 2016 10:06:20 -0600
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC 1/4] watchdog: ni9x3x_wdt: Add NI 903x/913x watchdog driver
Message-ID: <20160208160619.GA13123@senary>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <56B61F90.3000207@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56B61F90.3000207@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 06, 2016 at 08:30:08AM -0800, Guenter Roeck wrote:
> On 02/04/2016 05:28 PM, Kyle Roeschley wrote:
> >Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
> >time controllers.
> >
> >Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
> >Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> >---
> >  drivers/watchdog/Kconfig      |  11 ++
> >  drivers/watchdog/Makefile     |   1 +
> >  drivers/watchdog/ni9x3x_wdt.c | 264 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 276 insertions(+)
> >  create mode 100644 drivers/watchdog/ni9x3x_wdt.c
> >
> >diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >index 0f6d851..18bd13a 100644
> >--- a/drivers/watchdog/Kconfig
> >+++ b/drivers/watchdog/Kconfig
> >@@ -1214,6 +1214,17 @@ config SBC_EPX_C3_WATCHDOG
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called sbc_epx_c3.
> >
> >+config NI9X3X_WDT
> >+	tristate "NI 903x/913x Watchdog"
> >+	depends on X86 && ACPI
> >+	select WATCHDOG_CORE
> >+	---help---
> >+	  This is the driver for the watchdog timer on the National Instruments
> >+	  903x/913x real-time controllers.
> >+
> >+	  To compile this driver as a module, choose M here: the module will be
> >+	  called ni9x3x_wdt.
> >+
> >  # M32R Architecture
> >
> >  # M68K Architecture
> >diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> >index f566753..527978b 100644
> >--- a/drivers/watchdog/Makefile
> >+++ b/drivers/watchdog/Makefile
> >@@ -126,6 +126,7 @@ obj-$(CONFIG_MACHZ_WDT) += machzwd.o
> >  obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
> >  obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
> >  obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
> >+obj-$(CONFIG_NI9X3X_WDT) += ni9x3x_wdt.o
> >
> >  # M32R Architecture
> >
> >diff --git a/drivers/watchdog/ni9x3x_wdt.c b/drivers/watchdog/ni9x3x_wdt.c
> >new file mode 100644
> >index 0000000..2cb5627
> >--- /dev/null
> >+++ b/drivers/watchdog/ni9x3x_wdt.c
> >@@ -0,0 +1,264 @@
> >+/*
> >+ * Copyright (C) 2013 National Instruments Corp.
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify
> >+ * it under the terms of the GNU General Public License as published by
> >+ * the Free Software Foundation; either version 2 of the License, or
> >+ * (at your option) any later version.
> >+ *
> >+ * This program is distributed in the hope that it will be useful,
> >+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+ * GNU General Public License for more details.
> >+ */
> >+
> >+#include <linux/acpi.h>
> >+#include <linux/interrupt.h>
> >+#include <linux/module.h>
> >+#include <linux/watchdog.h>
> >+
> >+#define NIWD_CONTROL	0x01
> >+#define NIWD_COUNTER2	0x02
> >+#define NIWD_COUNTER1	0x03
> >+#define NIWD_COUNTER0	0x04
> >+#define NIWD_SEED2	0x05
> >+#define NIWD_SEED1	0x06
> >+#define NIWD_SEED0	0x07
> >+
> >+#define NIWD_IO_SIZE	0x08
> >+
> >+#define NIWD_CONTROL_MODE		0x80
> >+#define NIWD_CONTROL_PROC_RESET		0x20
> >+#define NIWD_CONTROL_PET		0x10
> >+#define NIWD_CONTROL_RUNNING		0x08
> >+#define NIWD_CONTROL_CAPTURECOUNTER	0x04
> >+#define NIWD_CONTROL_RESET		0x02
> >+#define NIWD_CONTROL_ALARM		0x01
> >+
> >+#define NIWD_PERIOD_NS		30720
> >+#define NIWD_MIN_TIMEOUT	1
> >+#define NIWD_MAX_TIMEOUT	515
> >+#define NIWD_DEFAULT_TIMEOUT	60
> >+
> >+#define NI9X3X_WDT_NAME		"ni9x3x_wdt"
> >+
> >+#define to_ni9x3x_wdt(_wdog)	container_of(_wdog, struct ni9x3x_wdt, wdog)
> >+
> >+struct ni9x3x_wdt {
> >+	struct acpi_device *acpi_device;
> >+	u16 io_base;
> >+	u16 io_size;
> >+	spinlock_t lock;
> >+	struct watchdog_device wdog;
> >+};
> >+
> >+static void ni9x3x_wdt_start(struct ni9x3x_wdt *wdt)
> >+{
> >+	u8 control = inb(wdt->io_base + NIWD_CONTROL);
> >+
> >+	outb(control | NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
> >+	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);
> >+}
> >+
> >+static int ni9x3x_wdt_wdd_set_timeout(struct watchdog_device *wdd,
> >+				      unsigned int timeout)
> >+{
> >+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
> >+	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
> >+
> >+	outb(((0x00FF0000 & counter) >> 16), wdt->io_base + NIWD_SEED2);
> >+	outb(((0x0000FF00 & counter) >> 8), wdt->io_base + NIWD_SEED1);
> >+	outb((0x000000FF & counter), wdt->io_base + NIWD_SEED0);
> >+
> >+	return 0;
> >+}
> >+
> >+static unsigned int ni9x3x_wdt_wdd_get_timeleft(struct watchdog_device *wdd)
> >+{
> >+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
> >+	u8 control, counter0, counter1, counter2;
> >+	u32 counter;
> >+
> >+	control = inb(wdt->io_base + NIWD_CONTROL);
> >+	control |= NIWD_CONTROL_CAPTURECOUNTER;
> >+	outb(control, wdt->io_base + NIWD_CONTROL);
> >+
> >+	counter2 = inb(wdt->io_base + NIWD_COUNTER2);
> >+	counter1 = inb(wdt->io_base + NIWD_COUNTER1);
> >+	counter0 = inb(wdt->io_base + NIWD_COUNTER0);
> >+
> >+	counter = (counter2 << 16) | (counter1 << 8) | counter0;
> >+	counter = (counter * (u64)NIWD_PERIOD_NS) / 1000000000;
> >+
> 
> The maximum value of 'counter' from the registers is
> 	515 * (1000000000/30720) = 16764280
> 
> Multiplying this value by 30720 yields 514998681600, much more than
> fits in a 32 bit value. This means you'll have to use u64 for the
> counter variable and use 64 bit operations for the divide operation.
> 
> Guenter
> 

A u32 * u64 is a u64, and a u64 / u32 is a u64, so counter doesn't need to be
u64. Unless you meant I should move the cast to counter or use a u64 counter
for clarity's sake, in which case sure. I've also tested this with an
explicitly 32-bit counter and 64-bit NIWD_PERIOD_NS with no problems, i.e.
	sizeof(uint32_t): 4
	sizeof(uint64_t): 8
	sizeof(counter * (u64)NIWD_PERIOD_NS): 8
	sizeof((counter * (u64)NIWD_PERIOD_NS)/1000000000): 8
	register = 16777215 -> counter value = 514

Kyle

