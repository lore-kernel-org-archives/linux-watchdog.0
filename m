Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33469 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBCRH2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Feb 2017 12:07:28 -0500
Date: Fri, 3 Feb 2017 09:07:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>, jun.nie@linaro.org,
        wim@iguana.be, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
Subject: Re: [PATCH v8 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
Message-ID: <20170203170717.GA14521@roeck-us.net>
References: <1486092140-1017-1-git-send-email-baoyou.xie@linaro.org>
 <1486092140-1017-3-git-send-email-baoyou.xie@linaro.org>
 <20170203160257.GA30336@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203160257.GA30336@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 03, 2017 at 09:02:57AM -0700, Mathieu Poirier wrote:
> On Fri, Feb 03, 2017 at 11:22:20AM +0800, Baoyou Xie wrote:
> > This patch adds watchdog controller driver for ZTE's zx2967 family.
> > 
> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > ---
> >  drivers/watchdog/Kconfig      |  10 ++
> >  drivers/watchdog/Makefile     |   1 +
> >  drivers/watchdog/zx2967_wdt.c | 285 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 296 insertions(+)
> >  create mode 100644 drivers/watchdog/zx2967_wdt.c
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index acb00b5..05093a2 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called aspeed_wdt.
> >  
> > +config ZX2967_WATCHDOG
> > +	tristate "ZTE zx2967 SoCs watchdog support"
> > +	depends on ARCH_ZX
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Say Y here to include support for the watchdog timer
> > +	  in ZTE zx2967 SoCs.
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called zx2967_wdt.
> > +
> >  # AVR32 Architecture
> >  
> >  config AT32AP700X_WDT
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 0c3d35e..bf2d296 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
> >  obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
> >  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
> >  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
> > +obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
> >  
> >  # AVR32 Architecture
> >  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> > diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
> > new file mode 100644
> > index 0000000..2daaca2
> > --- /dev/null
> > +++ b/drivers/watchdog/zx2967_wdt.c
> > @@ -0,0 +1,285 @@
> > +/*
> > + * watchdog driver for ZTE's zx2967 family
> > + *
> > + * Copyright (C) 2017 ZTE Ltd.
> > + *
> > + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> > + *
> > + * License terms: GNU General Public License (GPL) version 2
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include <linux/watchdog.h>
> > +
> > +#define ZX2967_WDT_CFG_REG			0x4
> > +#define ZX2967_WDT_LOAD_REG			0x8
> > +#define ZX2967_WDT_REFRESH_REG			0x18
> > +#define ZX2967_WDT_START_REG			0x1c
> > +
> > +#define ZX2967_WDT_REFRESH_MASK			0x3f
> > +
> > +#define ZX2967_WDT_CFG_DIV(n)			((((n) & 0xff) - 1) << 8)
> > +#define ZX2967_WDT_START_EN			0x1
> > +
> > +/*
> > + * Hardware magic number.
> > + * When watchdog reg is written, the lowest 16 bits are valid, but
> > + * the highest 16 bits should be always this number.
> > + */
> 
> Thanks for the explanation, much better now.
> 
> > +#define ZX2967_WDT_WRITEKEY			(0x1234 << 16)
> > +
> > +#define ZX2967_WDT_DIV_DEFAULT			16
> > +#define ZX2967_WDT_DEFAULT_TIMEOUT		32
> > +#define ZX2967_WDT_MIN_TIMEOUT			1
> > +#define ZX2967_WDT_MAX_TIMEOUT			524
> > +#define ZX2967_WDT_MAX_COUNT			0xffff
> > +
> > +#define ZX2967_WDT_CLK_FREQ			0x8000
> > +
> > +#define ZX2967_WDT_FLAG_REBOOT_MON		BIT(0)
> > +
> > +struct zx2967_wdt {
> > +	struct watchdog_device	wdt_device;
> > +	void __iomem		*reg_base;
> > +	struct clk		*clock;
> > +};
> > +
> > +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u16 reg)
> > +{
> > +	return readl_relaxed(wdt->reg_base + reg);
> > +}
> > +
> > +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt, u16 reg, u16 val)
> > +{
> > +	writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt->reg_base + reg);
> > +}
> 
> You were correct with the u32 type.  My comment was about making sure the value
> of the value given to the function wasn't bigger than 65535 (0xffff), which
> would have been corrupted by the OR'ing with ZX2967_WDT_WRITEKEY.  
> 
> Going with a u16 forces you to manipulate u16 types in all the functions below
> but the read operation is still a u32, leaving to the compiler the task of
> stripping the top 16 bit.  
> 
> My suggestion is to go back to a u32 for zx2967_wdt_writel() but to AND 'val'
> with 0x0000ffff before OR'ing it with ZX2967_WDT_WRITEKEY.
> 

For the record, I am fine either way, including not masking at all;
I considered that a theoretic problem that only applies if reading
a register can return a value other than 0 in the upper 16 bit.
So, ultimately, this patch series is now waiting for your Ack.

Guenter
