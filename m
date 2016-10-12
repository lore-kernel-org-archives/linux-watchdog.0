Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36108 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755911AbcJLQyx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Oct 2016 12:54:53 -0400
Date: Wed, 12 Oct 2016 09:54:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yang Ling <gnaygnil@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v1.1 1/2] watchdog: loongson1: Add Loongson1 SoC watchdog
 driver
Message-ID: <20161012165445.GB20472@roeck-us.net>
References: <20161011141029.GA26146@ubuntu>
 <701c5b53-c2b5-88af-1ff7-549edf68d7ae@roeck-us.net>
 <20161012163744.GA53619@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161012163744.GA53619@ubuntu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 13, 2016 at 12:37:44AM +0800, Yang Ling wrote:
> On Tue, Oct 11, 2016 at 07:54:03AM -0700, Guenter Roeck wrote:
> > On 10/11/2016 07:10 AM, Yang Ling wrote:
> > >Add watchdog timer specific driver for Loongson1 SoC.
> > >
> > >Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> > >
> > >---
> > >V1.1:
> > > Add a little debugging information.
> > >---
> > > drivers/watchdog/Kconfig         |   7 ++
> > > drivers/watchdog/Makefile        |   1 +
> > > drivers/watchdog/loongson1_wdt.c | 160 +++++++++++++++++++++++++++++++++++++++
> > > 3 files changed, 168 insertions(+)
> > > create mode 100644 drivers/watchdog/loongson1_wdt.c
> > >
> > >diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > >index 50dbaa8..28c44f2 100644
> > >--- a/drivers/watchdog/Kconfig
> > >+++ b/drivers/watchdog/Kconfig
> > >@@ -1553,6 +1553,13 @@ config PIC32_DMT
> > > 	  To compile this driver as a loadable module, choose M here.
> > > 	  The module will be called pic32-dmt.
> > >
> > >+config LOONGSON1_WDT
> > >+	tristate "Loongson1 SoC hardware watchdog"
> > >+	depends on MACH_LOONGSON32
> > >+	select WATCHDOG_CORE
> > >+	help
> > >+	  Hardware driver for the Loongson1 SoC Watchdog Timer.
> > >+
> > > # PARISC Architecture
> > >
> > > # POWERPC Architecture
> > >diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > >index cba0043..bd3b00e 100644
> > >--- a/drivers/watchdog/Makefile
> > >+++ b/drivers/watchdog/Makefile
> > >@@ -162,6 +162,7 @@ obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
> > > obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> > > obj-$(CONFIG_PIC32_WDT) += pic32-wdt.o
> > > obj-$(CONFIG_PIC32_DMT) += pic32-dmt.o
> > >+obj-$(CONFIG_LOONGSON1_WDT) += loongson1_wdt.o
> > >
> > > # PARISC Architecture
> > >
> > >diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
> > >new file mode 100644
> > >index 0000000..77b11f9
> > >--- /dev/null
> > >+++ b/drivers/watchdog/loongson1_wdt.c
> > >@@ -0,0 +1,160 @@
> > >+/*
> > >+ * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> > >+ *
> > >+ * This program is free software; you can redistribute	it and/or modify it
> > >+ * under  the terms of	the GNU General	 Public License as published by the
> > >+ * Free Software Foundation;  either version 2 of the  License, or (at your
> > >+ * option) any later version.
> > >+ */
> > >+
> > >+#include <linux/module.h>
> > >+#include <linux/watchdog.h>
> > >+#include <linux/platform_device.h>
> > >+#include <linux/clk.h>
> > >+
> > >+#include <loongson1.h>

While you are at it, please order include files alphabetically.

Thanks,
Guenter
