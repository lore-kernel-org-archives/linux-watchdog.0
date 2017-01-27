Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170126161729.GA1515@linaro.org>
References: <1485312289-18354-1-git-send-email-baoyou.xie@linaro.org>
 <1485312289-18354-3-git-send-email-baoyou.xie@linaro.org> <20170125162346.GA591@linaro.org>
 <CA+DQWkxpcHqVfDSGuUK-i4DOVXsYEYo60MG5y_oBDNp+ykEdLQ@mail.gmail.com> <20170126161729.GA1515@linaro.org>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Fri, 27 Jan 2017 10:40:09 +0800
Message-ID: <CA+DQWkyPtndGEz-QYvmKaXoGNKQ69Zqu-aG7tCKnT-Mrmx5Wsw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jun Nie <jun.nie@linaro.org>, wim@iguana.be, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a1140b0fa66761a05470a62f9
List-ID: <linux-watchdog@vger.kernel.org>

--001a1140b0fa66761a05470a62f9
Content-Type: text/plain; charset=UTF-8

On 27 January 2017 at 00:17, Mathieu Poirier <mathieu.poirier@linaro.org>
wrote:

> On Thu, Jan 26, 2017 at 09:32:56AM +0800, Baoyou Xie wrote:
> > On 26 January 2017 at 00:23, Mathieu Poirier <mathieu.poirier@linaro.org
> >
> > wrote:
> >
> > > On Wed, Jan 25, 2017 at 10:44:49AM +0800, Baoyou Xie wrote:
> > > > This patch adds watchdog controller driver for ZTE's zx2967 family.
> > > >
> > > > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > > > ---
> > > >  drivers/watchdog/Kconfig      |  10 ++
> > > >  drivers/watchdog/Makefile     |   1 +
> > > >  drivers/watchdog/zx2967_wdt.c | 276 ++++++++++++++++++++++++++++++
> > > ++++++++++++
> > > >  3 files changed, 287 insertions(+)
> > > >  create mode 100644 drivers/watchdog/zx2967_wdt.c
> > > >
> > > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > > index acb00b5..05093a2 100644
> > > > --- a/drivers/watchdog/Kconfig
> > > > +++ b/drivers/watchdog/Kconfig
> > > > @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG
> > > >         To compile this driver as a module, choose M here: the
> > > >         module will be called aspeed_wdt.
> > > >
> > > > +config ZX2967_WATCHDOG
> > > > +     tristate "ZTE zx2967 SoCs watchdog support"
> > > > +     depends on ARCH_ZX
> > > > +     select WATCHDOG_CORE
> > > > +     help
> > > > +       Say Y here to include support for the watchdog timer
> > > > +       in ZTE zx2967 SoCs.
> > > > +       To compile this driver as a module, choose M here: the
> > > > +       module will be called zx2967_wdt.
> > > > +
> > > >  # AVR32 Architecture
> > > >
> > > >  config AT32AP700X_WDT
> > > > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > > > index 0c3d35e..bf2d296 100644
> > > > --- a/drivers/watchdog/Makefile
> > > > +++ b/drivers/watchdog/Makefile
> > > > @@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
> > > >  obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
> > > >  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
> > > >  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
> > > > +obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
> > > >
> > > >  # AVR32 Architecture
> > > >  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> > > > diff --git a/drivers/watchdog/zx2967_wdt.c
> > > b/drivers/watchdog/zx2967_wdt.c
> > > > new file mode 100644
> > > > index 0000000..8278471
> > > > --- /dev/null
> > > > +++ b/drivers/watchdog/zx2967_wdt.c
> > > > @@ -0,0 +1,276 @@
> > > > +/*
> > > > + * watchdog driver for ZTE's zx2967 family
> > > > + *
> > > > + * Copyright (C) 2017 ZTE Ltd.
> > > > + *
> > > > + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> > > > + *
> > > > + * License terms: GNU General Public License (GPL) version 2
> > > > + */
> > > > +
> > > > +#include <linux/clk.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/mfd/syscon.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/reset.h>
> > > > +#include <linux/watchdog.h>
> > > > +
> > > > +#define ZX2967_WDT_CFG_REG                   0x4
> > > > +#define ZX2967_WDT_LOAD_REG                  0x8
> > > > +#define ZX2967_WDT_REFRESH_REG                       0x18
> > > > +#define ZX2967_WDT_START_REG                 0x1c
> > > > +
> > > > +#define ZX2967_WDT_REFRESH_MASK                      0x3f
> > > > +
> > > > +#define ZX2967_WDT_CFG_DIV(n)                        ((((n) & 0xff)
> -
> > > 1) << 8)
> > > > +#define ZX2967_WDT_START_EN                  0x1
> > > > +
> > > > +#define ZX2967_WDT_WRITEKEY                  0x12340000
> > > > +
> > > > +#define ZX2967_WDT_DIV_DEFAULT                       16
> > > > +#define ZX2967_WDT_DEFAULT_TIMEOUT           32
> > > > +#define ZX2967_WDT_MIN_TIMEOUT                       1
> > > > +#define ZX2967_WDT_MAX_TIMEOUT                       524
> > > > +#define ZX2967_WDT_MAX_COUNT                 0xffff
> > > > +
> > > > +#define ZX2967_WDT_CLK_FREQ                  0x8000
> > > > +
> > > > +#define ZX2967_WDT_FLAG_REBOOT_MON           BIT(0)
> > > > +
> > > > +struct zx2967_wdt {
> > > > +     struct watchdog_device  wdt_device;
> > > > +     void __iomem            *reg_base;
> > > > +     struct clk              *clock;
> > > > +};
> > > > +
> > > > +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u16 reg)
> > > > +{
> > > > +     return readl_relaxed(wdt->reg_base + reg);
> > > > +}
> > > > +
> > > > +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt, u16
> reg,
> > > u32 val)
> > > > +{
> > > > +     writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt->reg_base + reg);
> > > > +}
> > > > +
> > > > +static void zx2967_wdt_refresh(struct zx2967_wdt *wdt)
> > > > +{
> > > > +     u32 val;
> > > > +
> > > > +     val = zx2967_wdt_readl(wdt, ZX2967_WDT_REFRESH_REG);
> > > > +     val ^= ZX2967_WDT_REFRESH_MASK;
> > > > +     zx2967_wdt_writel(wdt, ZX2967_WDT_REFRESH_REG, val);
> > > > +}
> > > > +
> > > > +static int
> > > > +zx2967_wdt_set_timeout(struct watchdog_device *wdd, unsigned int
> > > timeout)
> > > > +{
> > > > +     struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> > > > +     unsigned int divisor = ZX2967_WDT_DIV_DEFAULT;
> > > > +     unsigned int count;
> > > > +
> > > > +     count = timeout * ZX2967_WDT_CLK_FREQ;
> > > > +     if (count > divisor * ZX2967_WDT_MAX_COUNT)
> > > > +             divisor = DIV_ROUND_UP(count, ZX2967_WDT_MAX_COUNT);
> > > > +     count = DIV_ROUND_UP(count, divisor);
> > > > +     zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_REG,
> > > ZX2967_WDT_CFG_DIV(divisor));
> > > > +     zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, count);
> > > > +     zx2967_wdt_refresh(wdt);
> > > > +     wdd->timeout =  (count * divisor) / ZX2967_WDT_CLK_FREQ;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void __zx2967_wdt_start(struct zx2967_wdt *wdt)
> > > > +{
> > > > +     u32 val;
> > > > +
> > > > +     val = zx2967_wdt_readl(wdt, ZX2967_WDT_START_REG);
> > > > +     val |= ZX2967_WDT_START_EN;
> > > > +     zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val);
> > > > +}
> > > > +
> > > > +static void __zx2967_wdt_stop(struct zx2967_wdt *wdt)
> > > > +{
> > > > +     u32 val;
> > > > +
> > > > +     val = zx2967_wdt_readl(wdt, ZX2967_WDT_START_REG);
> > > > +     val &= ~ZX2967_WDT_START_EN;
> > > > +     zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val);
> > > > +}
> > > > +
> > > > +static int zx2967_wdt_start(struct watchdog_device *wdd)
> > > > +{
> > > > +     struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> > > > +
> > > > +     zx2967_wdt_set_timeout(wdd, wdd->timeout);
> > > > +     __zx2967_wdt_start(wdt);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int zx2967_wdt_stop(struct watchdog_device *wdd)
> > > > +{
> > > > +     struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> > > > +
> > > > +     __zx2967_wdt_stop(wdt);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int zx2967_wdt_keepalive(struct watchdog_device *wdd)
> > > > +{
> > > > +     struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> > > > +
> > > > +     zx2967_wdt_refresh(wdt);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +#define ZX2967_WDT_OPTIONS \
> > > > +     (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
> > > > +static const struct watchdog_info zx2967_wdt_ident = {
> > > > +     .options          =     ZX2967_WDT_OPTIONS,
> > > > +     .identity         =     "zx2967 watchdog",
> > > > +};
> > > > +
> > > > +static struct watchdog_ops zx2967_wdt_ops = {
> > > > +     .owner = THIS_MODULE,
> > > > +     .start = zx2967_wdt_start,
> > > > +     .stop = zx2967_wdt_stop,
> > > > +     .ping = zx2967_wdt_keepalive,
> > > > +     .set_timeout = zx2967_wdt_set_timeout,
> > > > +};
> > > > +
> > > > +static void zx2967_wdt_reset_sysctrl(struct device *dev)
> > > > +{
> > > > +     int ret;
> > > > +     void __iomem *regmap;
> > > > +     unsigned int offset, mask, config;
> > > > +     struct of_phandle_args out_args;
> > > > +
> > > > +     ret = of_parse_phandle_with_fixed_args(dev->of_node,
> > > > +                     "zte,wdt-reset-sysctrl", 3, 0, &out_args);
> > > > +     if (ret)
> > > > +             return;
> > > > +
> > > > +     offset = out_args.args[0];
> > > > +     config = out_args.args[1];
> > > > +     mask = out_args.args[2];
> > > > +
> > > > +     regmap = syscon_node_to_regmap(out_args.np);
> > > > +     if (IS_ERR(regmap)) {
> > > > +             of_node_put(out_args.np);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     regmap_update_bits(regmap, offset, mask, config);
> > > > +     of_node_put(out_args.np);
> > > > +}
> > > > +
> > > > +static int zx2967_wdt_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct device *dev = &pdev->dev;
> > > > +     struct zx2967_wdt *wdt;
> > > > +     struct resource *base;
> > > > +     int ret;
> > > > +     struct reset_control *rstc;
> > > > +
> > > > +     wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> > > > +     if (!wdt)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     platform_set_drvdata(pdev, wdt);
> > > > +
> > > > +     wdt->wdt_device.info = &zx2967_wdt_ident;
> > > > +     wdt->wdt_device.ops = &zx2967_wdt_ops;
> > > > +     wdt->wdt_device.timeout = ZX2967_WDT_DEFAULT_TIMEOUT;
> > > > +     wdt->wdt_device.max_timeout = ZX2967_WDT_MAX_TIMEOUT;
> > > > +     wdt->wdt_device.min_timeout = ZX2967_WDT_MIN_TIMEOUT;
> > > > +     wdt->wdt_device.parent = &pdev->dev;
> > > > +
> > > > +     base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +     wdt->reg_base = devm_ioremap_resource(dev, base);
> > > > +     if (IS_ERR(wdt->reg_base)) {
> > > > +             dev_err(dev, "ioremap failed\n");
> > > > +             return PTR_ERR(wdt->reg_base);
> > > > +     }
> > > > +
> > > > +     zx2967_wdt_reset_sysctrl(dev);
> > > > +
> > > > +     wdt->clock = devm_clk_get(dev, NULL);
> > > > +     if (IS_ERR(wdt->clock)) {
> > > > +             dev_err(dev, "failed to find watchdog clock source\n");
> > > > +             return PTR_ERR(wdt->clock);
> > > > +     }
> > > > +
> > > > +     ret = clk_prepare_enable(wdt->clock);
> > > > +     if (ret < 0) {
> > > > +             dev_err(dev, "failed to enable clock\n");
> > > > +             return ret;
> > > > +     }
> > > > +     clk_set_rate(wdt->clock, ZX2967_WDT_CLK_FREQ);
> > > > +
> > > > +     rstc = devm_reset_control_get(dev, NULL);
> > > > +     if (IS_ERR(rstc)) {
> > > > +             dev_err(dev, "failed to get rstc");
> > > > +             ret = PTR_ERR(rstc);
> > > > +             goto err;
> > > > +     }
> > > > +
> > > > +     reset_control_assert(rstc);
> > > > +     usleep_range(500, 20000);
> > >
> > > Alright, I'm officially confused.
> > >
> > > First and foremost you still haven't provided an explanation as to why
> > > this is
> > > required.  Second, in your previous submission you had:
> > >
> > >         mdelay(10);
> > >
> > > That is a busy loop of 10ms.  In this post using usleep_range() is a
> step
> > > in the
> > > right direction but the min and max values to wait for don't make
> sense.
> > > Here
> > > you have 500 and 20000, which is 0.5ms and 20ms.
> > >
> > > In fact, sleeping for 0.5ms is enough.
> > we extended the sleeping time to 20ms, the purpose is merging the timer
> > interrupts. of course, it's happy to replace it with usleep_range(500,
> > 1000).
>
> "merging the timer interrupts" - you mean trying to get the WD tick to be
> closer
> to other timers?  If so I really don't see why.  Timers are asynchronous by
> nature and there can be dozens of them enabled at any given time.
>
> Really?
Even if the system runs asynchronously, early process may trigger delayed
process, for example delayed work queue or timers, we can merge our
watchdog timer and those delayed work's timers.

Furthermore, what happen if we build this driver as module?

But, as i said early, it's a trial optimization but can be instead with
usleep_range(500, 1000).

In some case, such optimization is helpful. I'd like to talk a story here,
about before ten years, I pressed a return key in console, you know, in
this case, a process be created and exited, so the cpu core that process
run at sent an IPI to other CPU, IPI interrupt resulted in the performance
decreased by 20%, so sad:)

Unless there is a H/W constraint requiring a delay between the
> assert/deassert
> of the WD, I don't think adding a wait operation (of any kind) make sense.
>
> >
> >
> >
> > > > +     reset_control_deassert(rstc);
> > > > +
> > > > +     watchdog_set_drvdata(&wdt->wdt_device, wdt);
> > > > +     watchdog_init_timeout(&wdt->wdt_device,
> > > > +                     ZX2967_WDT_DEFAULT_TIMEOUT, dev);
> > > > +     watchdog_set_nowayout(&wdt->wdt_device, WATCHDOG_NOWAYOUT);
> > > > +
> > > > +     ret = watchdog_register_device(&wdt->wdt_device);
> > > > +     if (ret)
> > > > +             goto err;
> > > > +
> > > > +     dev_info(dev, "watchdog enabled (timeout=%d sec, nowayout=%d)",
> > > > +              wdt->wdt_device.timeout, WATCHDOG_NOWAYOUT);
> > > > +
> > > > +     return 0;
> > > > +
> > > > +err:
> > > > +     clk_disable_unprepare(wdt->clock);
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int zx2967_wdt_remove(struct platform_device *pdev)
> > > > +{
> > > > +     struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
> > > > +
> > > > +     watchdog_unregister_device(&wdt->wdt_device);
> > > > +     clk_disable_unprepare(wdt->clock);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct of_device_id zx2967_wdt_match[] = {
> > > > +     { .compatible = "zte,zx296718-wdt", },
> > > > +     {}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, zx2967_wdt_match);
> > > > +
> > > > +static struct platform_driver zx2967_wdt_driver = {
> > > > +     .probe          = zx2967_wdt_probe,
> > > > +     .remove         = zx2967_wdt_remove,
> > > > +     .driver         = {
> > > > +             .name   = "zx2967-wdt",
> > > > +             .of_match_table = of_match_ptr(zx2967_wdt_match),
> > > > +     },
> > > > +};
> > > > +module_platform_driver(zx2967_wdt_driver);
> > > > +
> > > > +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
> > > > +MODULE_DESCRIPTION("ZTE zx2967 Watchdog Device Driver");
> > > > +MODULE_LICENSE("GPL v2");
> > > > --
> > > > 2.7.4
> > > >
> > >
>

--001a1140b0fa66761a05470a62f9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 27 January 2017 at 00:17, Mathieu Poirier <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:mathieu.poirier@linaro.org" target=3D"_blank">mathieu.poirier=
@linaro.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Thu, Jan=
 26, 2017 at 09:32:56AM +0800, Baoyou Xie wrote:<br>
&gt; On 26 January 2017 at 00:23, Mathieu Poirier &lt;<a href=3D"mailto:mat=
hieu.poirier@linaro.org">mathieu.poirier@linaro.org</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Wed, Jan 25, 2017 at 10:44:49AM +0800, Baoyou Xie wrote:<br>
&gt; &gt; &gt; This patch adds watchdog controller driver for ZTE&#39;s zx2=
967 family.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@l=
inaro.org">baoyou.xie@linaro.org</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 drivers/watchdog/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1=
0 ++<br>
&gt; &gt; &gt;=C2=A0 drivers/watchdog/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
&gt; &gt; &gt;=C2=A0 drivers/watchdog/zx2967_wdt.c | 276 ++++++++++++++++++=
++++++++++++<br>
&gt; &gt; ++++++++++++<br>
&gt; &gt; &gt;=C2=A0 3 files changed, 287 insertions(+)<br>
&gt; &gt; &gt;=C2=A0 create mode 100644 drivers/watchdog/zx2967_wdt.c<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kco=
nfig<br>
&gt; &gt; &gt; index acb00b5..05093a2 100644<br>
&gt; &gt; &gt; --- a/drivers/watchdog/Kconfig<br>
&gt; &gt; &gt; +++ b/drivers/watchdog/Kconfig<br>
&gt; &gt; &gt; @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a=
 module, choose M here: the<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called aspee=
d_wdt.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +config ZX2967_WATCHDOG<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;ZTE zx2967 SoCs watchdog=
 support&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0depends on ARCH_ZX<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0select WATCHDOG_CORE<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here to include support fo=
r the watchdog timer<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0in ZTE zx2967 SoCs.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a modu=
le, choose M here: the<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called zx2967_wdt=
.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 # AVR32 Architecture<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 config AT32AP700X_WDT<br>
&gt; &gt; &gt; diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Ma=
kefile<br>
&gt; &gt; &gt; index 0c3d35e..bf2d296 100644<br>
&gt; &gt; &gt; --- a/drivers/watchdog/Makefile<br>
&gt; &gt; &gt; +++ b/drivers/watchdog/Makefile<br>
&gt; &gt; &gt; @@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) +=3D bcm7038_wdt=
.o<br>
&gt; &gt; &gt;=C2=A0 obj-$(CONFIG_ATLAS7_WATCHDOG) +=3D atlas7_wdt.o<br>
&gt; &gt; &gt;=C2=A0 obj-$(CONFIG_RENESAS_WDT) +=3D renesas_wdt.o<br>
&gt; &gt; &gt;=C2=A0 obj-$(CONFIG_ASPEED_WATCHDOG) +=3D aspeed_wdt.o<br>
&gt; &gt; &gt; +obj-$(CONFIG_ZX2967_WATCHDOG) +=3D zx2967_wdt.o<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 # AVR32 Architecture<br>
&gt; &gt; &gt;=C2=A0 obj-$(CONFIG_AT32AP700X_WDT) +=3D at32ap700x_wdt.o<br>
&gt; &gt; &gt; diff --git a/drivers/watchdog/zx2967_wdt.<wbr>c<br>
&gt; &gt; b/drivers/watchdog/zx2967_wdt.<wbr>c<br>
&gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; index 0000000..8278471<br>
&gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; +++ b/drivers/watchdog/zx2967_wdt.<wbr>c<br>
&gt; &gt; &gt; @@ -0,0 +1,276 @@<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * watchdog driver for ZTE&#39;s zx2967 family<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Copyright (C) 2017 ZTE Ltd.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Author: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@lina=
ro.org">baoyou.xie@linaro.org</a>&gt;<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * License terms: GNU General Public License (GPL) version =
2<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#include &lt;linux/clk.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/delay.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/io.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/mfd/syscon.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/module.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/of_address.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/regmap.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/reset.h&gt;<br>
&gt; &gt; &gt; +#include &lt;linux/watchdog.h&gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ZX2967_WDT_CFG_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4<br>
&gt; &gt; &gt; +#define ZX2967_WDT_LOAD_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8<br>
&gt; &gt; &gt; +#define ZX2967_WDT_REFRESH_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x18<br>
&gt; &gt; &gt; +#define ZX2967_WDT_START_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1c<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ZX2967_WDT_REFRESH_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3f<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ZX2967_WDT_CFG_DIV(n)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((((n) &amp; 0xff) =
-<br>
&gt; &gt; 1) &lt;&lt; 8)<br>
&gt; &gt; &gt; +#define ZX2967_WDT_START_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ZX2967_WDT_WRITEKEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x12340000<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ZX2967_WDT_DIV_DEFAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
&gt; &gt; &gt; +#define ZX2967_WDT_DEFAULT_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A032<br>
&gt; &gt; &gt; +#define ZX2967_WDT_MIN_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
&gt; &gt; &gt; +#define ZX2967_WDT_MAX_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0524<br>
&gt; &gt; &gt; +#define ZX2967_WDT_MAX_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xffff<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ZX2967_WDT_CLK_FREQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8000<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ZX2967_WDT_FLAG_REBOOT_MON=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct zx2967_wdt {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device=C2=A0 wdt_device=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 *reg_base;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *clock;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, =
u16 reg)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return readl_relaxed(wdt-&gt;reg_base +=
 reg);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt=
, u16 reg,<br>
&gt; &gt; u32 val)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0writel_relaxed(val | ZX2967_WDT_WRITEKE=
Y, wdt-&gt;reg_base + reg);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static void zx2967_wdt_refresh(struct zx2967_wdt *wdt)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WD=
T_REFRESH_REG);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0val ^=3D ZX2967_WDT_REFRESH_MASK;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_REFRE=
SH_REG, val);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int<br>
&gt; &gt; &gt; +zx2967_wdt_set_timeout(struct watchdog_device *wdd, unsigne=
d int<br>
&gt; &gt; timeout)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get=
_drvdata(wdd);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int divisor =3D ZX2967_WDT_DIV=
_DEFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int count;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0count =3D timeout * ZX2967_WDT_CLK_FREQ=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (count &gt; divisor * ZX2967_WDT_MAX=
_COUNT)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divisor =3D=
 DIV_ROUND_UP(count, ZX2967_WDT_MAX_COUNT);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0count =3D DIV_ROUND_UP(count, divisor);=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_R=
EG,<br>
&gt; &gt; ZX2967_WDT_CFG_DIV(divisor));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_=
REG, count);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_refresh(wdt);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdd-&gt;timeout =3D=C2=A0 (count * divi=
sor) / ZX2967_WDT_CLK_FREQ;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static void __zx2967_wdt_start(struct zx2967_wdt *wdt)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WD=
T_START_REG);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0val |=3D ZX2967_WDT_START_EN;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_START=
_REG, val);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static void __zx2967_wdt_stop(struct zx2967_wdt *wdt)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WD=
T_START_REG);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0val &amp;=3D ~ZX2967_WDT_START_EN;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_START=
_REG, val);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int zx2967_wdt_start(struct watchdog_device *wdd)<br=
>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get=
_drvdata(wdd);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_set_timeout(wdd, wdd-&gt;tim=
eout);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__zx2967_wdt_start(wdt);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int zx2967_wdt_stop(struct watchdog_device *wdd)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get=
_drvdata(wdd);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__zx2967_wdt_stop(wdt);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int zx2967_wdt_keepalive(struct watchdog_device *wdd=
)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get=
_drvdata(wdd);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_refresh(wdt);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ZX2967_WDT_OPTIONS \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0(WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING=
 | WDIOF_MAGICCLOSE)<br>
&gt; &gt; &gt; +static const struct watchdog_info zx2967_wdt_ident =3D {<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.options=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D=C2=A0 =C2=A0 =C2=A0ZX2967_WDT_OPTIONS,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.identity=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D=C2=A0 =C2=A0 =C2=A0&quot;zx2967 watchdog&quot;,<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static struct watchdog_ops zx2967_wdt_ops =3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.start =3D zx2967_wdt_start,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.stop =3D zx2967_wdt_stop,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.ping =3D zx2967_wdt_keepalive,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.set_timeout =3D zx2967_wdt_set_timeout=
,<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static void zx2967_wdt_reset_sysctrl(<wbr>struct device *de=
v)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *regmap;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int offset, mask, config;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct of_phandle_args out_args;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D of_parse_phandle_with_fixed_<wb=
r>args(dev-&gt;of_node,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;zte,wdt-reset-sysctrl&quot;, 3, 0, &amp;out_args);<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0offset =3D out_args.args[0];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0config =3D out_args.args[1];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0mask =3D out_args.args[2];<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0regmap =3D syscon_node_to_regmap(<a hre=
f=3D"http://out_args.np" rel=3D"noreferrer" target=3D"_blank">out_<wbr>args=
.np</a>);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(regmap)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of_node_put=
(<a href=3D"http://out_args.np" rel=3D"noreferrer" target=3D"_blank">out_ar=
gs.np</a>);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0regmap_update_bits(regmap, offset, mask=
, config);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0of_node_put(<a href=3D"http://out_args.=
np" rel=3D"noreferrer" target=3D"_blank">out_args.np</a>);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int zx2967_wdt_probe(struct platform_device *pdev)<b=
r>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;de=
v;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct resource *base;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct reset_control *rstc;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt =3D devm_kzalloc(dev, sizeof(*wdt),=
 GFP_KERNEL);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (!wdt)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENO=
MEM;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, wdt);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;<a href=3D"http://wdt_device.in=
fo" rel=3D"noreferrer" target=3D"_blank">wdt_device.info</a> =3D &amp;zx296=
7_wdt_ident;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.ops =3D &amp;zx2967_=
wdt_ops;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.timeout =3D ZX2967_W=
DT_DEFAULT_TIMEOUT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.max_timeout =3D ZX29=
67_WDT_MAX_TIMEOUT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.min_timeout =3D ZX29=
67_WDT_MIN_TIMEOUT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.parent =3D &amp;pdev=
-&gt;dev;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0base =3D platform_get_resource(pdev, IO=
RESOURCE_MEM, 0);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;reg_base =3D devm_ioremap_resou=
rce(dev, base);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(wdt-&gt;reg_base)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev=
, &quot;ioremap failed\n&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_=
ERR(wdt-&gt;reg_base);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_reset_sysctrl(dev);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;clock =3D devm_clk_get(dev, NUL=
L);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(wdt-&gt;clock)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev=
, &quot;failed to find watchdog clock source\n&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_=
ERR(wdt-&gt;clock);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(wdt-&gt;cloc=
k)<wbr>;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev=
, &quot;failed to enable clock\n&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0clk_set_rate(wdt-&gt;clock, ZX2967_WDT_=
CLK_FREQ);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0rstc =3D devm_reset_control_get(dev, NU=
LL);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(rstc)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev=
, &quot;failed to get rstc&quot;);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR=
_ERR(rstc);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0reset_control_assert(rstc);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0usleep_range(500, 20000);<br>
&gt; &gt;<br>
&gt; &gt; Alright, I&#39;m officially confused.<br>
&gt; &gt;<br>
&gt; &gt; First and foremost you still haven&#39;t provided an explanation =
as to why<br>
&gt; &gt; this is<br>
&gt; &gt; required.=C2=A0 Second, in your previous submission you had:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(10);<br>
&gt; &gt;<br>
&gt; &gt; That is a busy loop of 10ms.=C2=A0 In this post using usleep_rang=
e() is a step<br>
&gt; &gt; in the<br>
&gt; &gt; right direction but the min and max values to wait for don&#39;t =
make sense.<br>
&gt; &gt; Here<br>
&gt; &gt; you have 500 and 20000, which is 0.5ms and 20ms.<br>
&gt; &gt;<br>
&gt; &gt; In fact, sleeping for 0.5ms is enough.<br>
&gt; we extended the sleeping time to 20ms, the purpose is merging the time=
r<br>
&gt; interrupts. of course, it&#39;s happy to replace it with usleep_range(=
500,<br>
&gt; 1000).<br>
<br>
</div></div>&quot;merging the timer interrupts&quot; - you mean trying to g=
et the WD tick to be closer<br>
to other timers?=C2=A0 If so I really don&#39;t see why.=C2=A0 Timers are a=
synchronous by<br>
nature and there can be dozens of them enabled at any given time.<br><br></=
blockquote><div>Really?<br></div><div>Even if the system runs asynchronousl=
y, early process may trigger delayed process, for example delayed work queu=
e or timers, we can merge our watchdog timer and those delayed work&#39;s t=
imers.<br><br>Furthermore, what happen if we build this driver as module?<b=
r><br></div><div>But, as i said early, it&#39;s a trial optimization but ca=
n be instead with usleep_range(500, 1000).<br><br></div><div>In some case, =
such optimization is helpful. I&#39;d like to talk a story here, about befo=
re ten years, I pressed a return key in console, you know, in this case, a =
process be created and exited, so the cpu core that process run at sent an =
IPI to other CPU, IPI interrupt resulted in <span id=3D"gmail-result_box" c=
lass=3D"gmail-short_text" lang=3D"en"><span class=3D"gmail-">the performanc=
e decreased by 20%, so sad:)<br></span></span></div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
Unless there is a H/W constraint requiring a delay between the assert/deass=
ert<br>
of the WD, I don&#39;t think adding a wait operation (of any kind) make sen=
se.<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0reset_control_deassert(rstc);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0watchdog_set_drvdata(&amp;wdt-&gt;<wbr>=
wdt_device, wdt);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0watchdog_init_timeout(&amp;wdt-&gt;<wbr=
>wdt_device,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ZX2967_WDT_DEFAULT_TIMEOUT, dev);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0watchdog_set_nowayout(&amp;wdt-&gt;<wbr=
>wdt_device, WATCHDOG_NOWAYOUT);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D watchdog_register_device(&amp;w=
dt-<wbr>&gt;wdt_device);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot;watchdog enabled (t=
imeout=3D%d sec, nowayout=3D%d)&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wdt-&gt;wd=
t_device.timeout, WATCHDOG_NOWAYOUT);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +err:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(wdt-&gt;<wbr>cloc=
k);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int zx2967_wdt_remove(struct platform_device *pdev)<=
br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D platform_get=
_drvdata(pdev);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0watchdog_unregister_device(&amp;<wbr>wd=
t-&gt;wdt_device);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(wdt-&gt;<wbr>cloc=
k);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static const struct of_device_id zx2967_wdt_match[] =3D {<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;zte,zx296718-wd=
t&quot;, },<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0{}<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +MODULE_DEVICE_TABLE(of, zx2967_wdt_match);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static struct platform_driver zx2967_wdt_driver =3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D zx2967_wdt_probe,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D zx2967_wdt_remove,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.driver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0=
 =C2=A0=3D &quot;zx2967-wdt&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_t=
able =3D of_match_ptr(zx2967_wdt_match)<wbr>,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +module_platform_driver(<wbr>zx2967_wdt_driver);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +MODULE_AUTHOR(&quot;Baoyou Xie &lt;<a href=3D"mailto:baoyou=
.xie@linaro.org">baoyou.xie@linaro.org</a>&gt;&quot;);<br>
&gt; &gt; &gt; +MODULE_DESCRIPTION(&quot;ZTE zx2967 Watchdog Device Driver&=
quot;);<br>
&gt; &gt; &gt; +MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.7.4<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
</div></div></blockquote></div><br></div></div>

--001a1140b0fa66761a05470a62f9--
