Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170125162346.GA591@linaro.org>
References: <1485312289-18354-1-git-send-email-baoyou.xie@linaro.org>
 <1485312289-18354-3-git-send-email-baoyou.xie@linaro.org> <20170125162346.GA591@linaro.org>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Thu, 26 Jan 2017 09:32:56 +0800
Message-ID: <CA+DQWkxpcHqVfDSGuUK-i4DOVXsYEYo60MG5y_oBDNp+ykEdLQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jun Nie <jun.nie@linaro.org>, wim@iguana.be, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a1144ca223760f40546f5544e
List-ID: <linux-watchdog@vger.kernel.org>

--001a1144ca223760f40546f5544e
Content-Type: text/plain; charset=UTF-8

On 26 January 2017 at 00:23, Mathieu Poirier <mathieu.poirier@linaro.org>
wrote:

> On Wed, Jan 25, 2017 at 10:44:49AM +0800, Baoyou Xie wrote:
> > This patch adds watchdog controller driver for ZTE's zx2967 family.
> >
> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > ---
> >  drivers/watchdog/Kconfig      |  10 ++
> >  drivers/watchdog/Makefile     |   1 +
> >  drivers/watchdog/zx2967_wdt.c | 276 ++++++++++++++++++++++++++++++
> ++++++++++++
> >  3 files changed, 287 insertions(+)
> >  create mode 100644 drivers/watchdog/zx2967_wdt.c
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index acb00b5..05093a2 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG
> >         To compile this driver as a module, choose M here: the
> >         module will be called aspeed_wdt.
> >
> > +config ZX2967_WATCHDOG
> > +     tristate "ZTE zx2967 SoCs watchdog support"
> > +     depends on ARCH_ZX
> > +     select WATCHDOG_CORE
> > +     help
> > +       Say Y here to include support for the watchdog timer
> > +       in ZTE zx2967 SoCs.
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called zx2967_wdt.
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
> > diff --git a/drivers/watchdog/zx2967_wdt.c
> b/drivers/watchdog/zx2967_wdt.c
> > new file mode 100644
> > index 0000000..8278471
> > --- /dev/null
> > +++ b/drivers/watchdog/zx2967_wdt.c
> > @@ -0,0 +1,276 @@
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
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include <linux/watchdog.h>
> > +
> > +#define ZX2967_WDT_CFG_REG                   0x4
> > +#define ZX2967_WDT_LOAD_REG                  0x8
> > +#define ZX2967_WDT_REFRESH_REG                       0x18
> > +#define ZX2967_WDT_START_REG                 0x1c
> > +
> > +#define ZX2967_WDT_REFRESH_MASK                      0x3f
> > +
> > +#define ZX2967_WDT_CFG_DIV(n)                        ((((n) & 0xff) -
> 1) << 8)
> > +#define ZX2967_WDT_START_EN                  0x1
> > +
> > +#define ZX2967_WDT_WRITEKEY                  0x12340000
> > +
> > +#define ZX2967_WDT_DIV_DEFAULT                       16
> > +#define ZX2967_WDT_DEFAULT_TIMEOUT           32
> > +#define ZX2967_WDT_MIN_TIMEOUT                       1
> > +#define ZX2967_WDT_MAX_TIMEOUT                       524
> > +#define ZX2967_WDT_MAX_COUNT                 0xffff
> > +
> > +#define ZX2967_WDT_CLK_FREQ                  0x8000
> > +
> > +#define ZX2967_WDT_FLAG_REBOOT_MON           BIT(0)
> > +
> > +struct zx2967_wdt {
> > +     struct watchdog_device  wdt_device;
> > +     void __iomem            *reg_base;
> > +     struct clk              *clock;
> > +};
> > +
> > +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u16 reg)
> > +{
> > +     return readl_relaxed(wdt->reg_base + reg);
> > +}
> > +
> > +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt, u16 reg,
> u32 val)
> > +{
> > +     writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt->reg_base + reg);
> > +}
> > +
> > +static void zx2967_wdt_refresh(struct zx2967_wdt *wdt)
> > +{
> > +     u32 val;
> > +
> > +     val = zx2967_wdt_readl(wdt, ZX2967_WDT_REFRESH_REG);
> > +     val ^= ZX2967_WDT_REFRESH_MASK;
> > +     zx2967_wdt_writel(wdt, ZX2967_WDT_REFRESH_REG, val);
> > +}
> > +
> > +static int
> > +zx2967_wdt_set_timeout(struct watchdog_device *wdd, unsigned int
> timeout)
> > +{
> > +     struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> > +     unsigned int divisor = ZX2967_WDT_DIV_DEFAULT;
> > +     unsigned int count;
> > +
> > +     count = timeout * ZX2967_WDT_CLK_FREQ;
> > +     if (count > divisor * ZX2967_WDT_MAX_COUNT)
> > +             divisor = DIV_ROUND_UP(count, ZX2967_WDT_MAX_COUNT);
> > +     count = DIV_ROUND_UP(count, divisor);
> > +     zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_REG,
> ZX2967_WDT_CFG_DIV(divisor));
> > +     zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, count);
> > +     zx2967_wdt_refresh(wdt);
> > +     wdd->timeout =  (count * divisor) / ZX2967_WDT_CLK_FREQ;
> > +
> > +     return 0;
> > +}
> > +
> > +static void __zx2967_wdt_start(struct zx2967_wdt *wdt)
> > +{
> > +     u32 val;
> > +
> > +     val = zx2967_wdt_readl(wdt, ZX2967_WDT_START_REG);
> > +     val |= ZX2967_WDT_START_EN;
> > +     zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val);
> > +}
> > +
> > +static void __zx2967_wdt_stop(struct zx2967_wdt *wdt)
> > +{
> > +     u32 val;
> > +
> > +     val = zx2967_wdt_readl(wdt, ZX2967_WDT_START_REG);
> > +     val &= ~ZX2967_WDT_START_EN;
> > +     zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val);
> > +}
> > +
> > +static int zx2967_wdt_start(struct watchdog_device *wdd)
> > +{
> > +     struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> > +
> > +     zx2967_wdt_set_timeout(wdd, wdd->timeout);
> > +     __zx2967_wdt_start(wdt);
> > +
> > +     return 0;
> > +}
> > +
> > +static int zx2967_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +     struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> > +
> > +     __zx2967_wdt_stop(wdt);
> > +
> > +     return 0;
> > +}
> > +
> > +static int zx2967_wdt_keepalive(struct watchdog_device *wdd)
> > +{
> > +     struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
> > +
> > +     zx2967_wdt_refresh(wdt);
> > +
> > +     return 0;
> > +}
> > +
> > +#define ZX2967_WDT_OPTIONS \
> > +     (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
> > +static const struct watchdog_info zx2967_wdt_ident = {
> > +     .options          =     ZX2967_WDT_OPTIONS,
> > +     .identity         =     "zx2967 watchdog",
> > +};
> > +
> > +static struct watchdog_ops zx2967_wdt_ops = {
> > +     .owner = THIS_MODULE,
> > +     .start = zx2967_wdt_start,
> > +     .stop = zx2967_wdt_stop,
> > +     .ping = zx2967_wdt_keepalive,
> > +     .set_timeout = zx2967_wdt_set_timeout,
> > +};
> > +
> > +static void zx2967_wdt_reset_sysctrl(struct device *dev)
> > +{
> > +     int ret;
> > +     void __iomem *regmap;
> > +     unsigned int offset, mask, config;
> > +     struct of_phandle_args out_args;
> > +
> > +     ret = of_parse_phandle_with_fixed_args(dev->of_node,
> > +                     "zte,wdt-reset-sysctrl", 3, 0, &out_args);
> > +     if (ret)
> > +             return;
> > +
> > +     offset = out_args.args[0];
> > +     config = out_args.args[1];
> > +     mask = out_args.args[2];
> > +
> > +     regmap = syscon_node_to_regmap(out_args.np);
> > +     if (IS_ERR(regmap)) {
> > +             of_node_put(out_args.np);
> > +             return;
> > +     }
> > +
> > +     regmap_update_bits(regmap, offset, mask, config);
> > +     of_node_put(out_args.np);
> > +}
> > +
> > +static int zx2967_wdt_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct zx2967_wdt *wdt;
> > +     struct resource *base;
> > +     int ret;
> > +     struct reset_control *rstc;
> > +
> > +     wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> > +     if (!wdt)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, wdt);
> > +
> > +     wdt->wdt_device.info = &zx2967_wdt_ident;
> > +     wdt->wdt_device.ops = &zx2967_wdt_ops;
> > +     wdt->wdt_device.timeout = ZX2967_WDT_DEFAULT_TIMEOUT;
> > +     wdt->wdt_device.max_timeout = ZX2967_WDT_MAX_TIMEOUT;
> > +     wdt->wdt_device.min_timeout = ZX2967_WDT_MIN_TIMEOUT;
> > +     wdt->wdt_device.parent = &pdev->dev;
> > +
> > +     base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     wdt->reg_base = devm_ioremap_resource(dev, base);
> > +     if (IS_ERR(wdt->reg_base)) {
> > +             dev_err(dev, "ioremap failed\n");
> > +             return PTR_ERR(wdt->reg_base);
> > +     }
> > +
> > +     zx2967_wdt_reset_sysctrl(dev);
> > +
> > +     wdt->clock = devm_clk_get(dev, NULL);
> > +     if (IS_ERR(wdt->clock)) {
> > +             dev_err(dev, "failed to find watchdog clock source\n");
> > +             return PTR_ERR(wdt->clock);
> > +     }
> > +
> > +     ret = clk_prepare_enable(wdt->clock);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to enable clock\n");
> > +             return ret;
> > +     }
> > +     clk_set_rate(wdt->clock, ZX2967_WDT_CLK_FREQ);
> > +
> > +     rstc = devm_reset_control_get(dev, NULL);
> > +     if (IS_ERR(rstc)) {
> > +             dev_err(dev, "failed to get rstc");
> > +             ret = PTR_ERR(rstc);
> > +             goto err;
> > +     }
> > +
> > +     reset_control_assert(rstc);
> > +     usleep_range(500, 20000);
>
> Alright, I'm officially confused.
>
> First and foremost you still haven't provided an explanation as to why
> this is
> required.  Second, in your previous submission you had:
>
>         mdelay(10);
>
> That is a busy loop of 10ms.  In this post using usleep_range() is a step
> in the
> right direction but the min and max values to wait for don't make sense.
> Here
> you have 500 and 20000, which is 0.5ms and 20ms.
>
> In fact, sleeping for 0.5ms is enough.
we extended the sleeping time to 20ms, the purpose is merging the timer
interrupts. of course, it's happy to replace it with usleep_range(500,
1000).



> > +     reset_control_deassert(rstc);
> > +
> > +     watchdog_set_drvdata(&wdt->wdt_device, wdt);
> > +     watchdog_init_timeout(&wdt->wdt_device,
> > +                     ZX2967_WDT_DEFAULT_TIMEOUT, dev);
> > +     watchdog_set_nowayout(&wdt->wdt_device, WATCHDOG_NOWAYOUT);
> > +
> > +     ret = watchdog_register_device(&wdt->wdt_device);
> > +     if (ret)
> > +             goto err;
> > +
> > +     dev_info(dev, "watchdog enabled (timeout=%d sec, nowayout=%d)",
> > +              wdt->wdt_device.timeout, WATCHDOG_NOWAYOUT);
> > +
> > +     return 0;
> > +
> > +err:
> > +     clk_disable_unprepare(wdt->clock);
> > +     return ret;
> > +}
> > +
> > +static int zx2967_wdt_remove(struct platform_device *pdev)
> > +{
> > +     struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
> > +
> > +     watchdog_unregister_device(&wdt->wdt_device);
> > +     clk_disable_unprepare(wdt->clock);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id zx2967_wdt_match[] = {
> > +     { .compatible = "zte,zx296718-wdt", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, zx2967_wdt_match);
> > +
> > +static struct platform_driver zx2967_wdt_driver = {
> > +     .probe          = zx2967_wdt_probe,
> > +     .remove         = zx2967_wdt_remove,
> > +     .driver         = {
> > +             .name   = "zx2967-wdt",
> > +             .of_match_table = of_match_ptr(zx2967_wdt_match),
> > +     },
> > +};
> > +module_platform_driver(zx2967_wdt_driver);
> > +
> > +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
> > +MODULE_DESCRIPTION("ZTE zx2967 Watchdog Device Driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.7.4
> >
>

--001a1144ca223760f40546f5544e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 26 January 2017 at 00:23, Mathieu Poirier <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:mathieu.poirier@linaro.org" target=3D"_blank">mathieu.poirier=
@linaro.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cl=
ass=3D"HOEnZb"><div class=3D"h5">On Wed, Jan 25, 2017 at 10:44:49AM +0800, =
Baoyou Xie wrote:<br>
&gt; This patch adds watchdog controller driver for ZTE&#39;s zx2967 family=
.<br>
&gt;<br>
&gt; Signed-off-by: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@linaro.org"=
>baoyou.xie@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/watchdog/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 ++<br>
&gt;=C2=A0 drivers/watchdog/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<b=
r>
&gt;=C2=A0 drivers/watchdog/zx2967_wdt.c | 276 ++++++++++++++++++++++++++++=
++<wbr>++++++++++++<br>
&gt;=C2=A0 3 files changed, 287 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/watchdog/zx2967_wdt.c<br>
&gt;<br>
&gt; diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig<br>
&gt; index acb00b5..05093a2 100644<br>
&gt; --- a/drivers/watchdog/Kconfig<br>
&gt; +++ b/drivers/watchdog/Kconfig<br>
&gt; @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, c=
hoose M here: the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called aspeed_wdt.<br>
&gt;<br>
&gt; +config ZX2967_WATCHDOG<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;ZTE zx2967 SoCs watchdog support&q=
uot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on ARCH_ZX<br>
&gt; +=C2=A0 =C2=A0 =C2=A0select WATCHDOG_CORE<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here to include support for the watc=
hdog timer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0in ZTE zx2967 SoCs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choose=
 M here: the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called zx2967_wdt.<br>
&gt; +<br>
&gt;=C2=A0 # AVR32 Architecture<br>
&gt;<br>
&gt;=C2=A0 config AT32AP700X_WDT<br>
&gt; diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile<br>
&gt; index 0c3d35e..bf2d296 100644<br>
&gt; --- a/drivers/watchdog/Makefile<br>
&gt; +++ b/drivers/watchdog/Makefile<br>
&gt; @@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) +=3D bcm7038_wdt.o<br>
&gt;=C2=A0 obj-$(CONFIG_ATLAS7_WATCHDOG) +=3D atlas7_wdt.o<br>
&gt;=C2=A0 obj-$(CONFIG_RENESAS_WDT) +=3D renesas_wdt.o<br>
&gt;=C2=A0 obj-$(CONFIG_ASPEED_WATCHDOG) +=3D aspeed_wdt.o<br>
&gt; +obj-$(CONFIG_ZX2967_WATCHDOG) +=3D zx2967_wdt.o<br>
&gt;<br>
&gt;=C2=A0 # AVR32 Architecture<br>
&gt;=C2=A0 obj-$(CONFIG_AT32AP700X_WDT) +=3D at32ap700x_wdt.o<br>
&gt; diff --git a/drivers/watchdog/zx2967_wdt.<wbr>c b/drivers/watchdog/zx2=
967_wdt.<wbr>c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8278471<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/watchdog/zx2967_wdt.<wbr>c<br>
&gt; @@ -0,0 +1,276 @@<br>
&gt; +/*<br>
&gt; + * watchdog driver for ZTE&#39;s zx2967 family<br>
&gt; + *<br>
&gt; + * Copyright (C) 2017 ZTE Ltd.<br>
&gt; + *<br>
&gt; + * Author: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@linaro.org">ba=
oyou.xie@linaro.org</a>&gt;<br>
&gt; + *<br>
&gt; + * License terms: GNU General Public License (GPL) version 2<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/clk.h&gt;<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/io.h&gt;<br>
&gt; +#include &lt;linux/mfd/syscon.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/of_address.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/regmap.h&gt;<br>
&gt; +#include &lt;linux/reset.h&gt;<br>
&gt; +#include &lt;linux/watchdog.h&gt;<br>
&gt; +<br>
&gt; +#define ZX2967_WDT_CFG_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x4<br>
&gt; +#define ZX2967_WDT_LOAD_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x8<br>
&gt; +#define ZX2967_WDT_REFRESH_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x18<br>
&gt; +#define ZX2967_WDT_START_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x1c<br>
&gt; +<br>
&gt; +#define ZX2967_WDT_REFRESH_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3f<br>
&gt; +<br>
&gt; +#define ZX2967_WDT_CFG_DIV(n)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((((n) &amp; 0xff) - 1) &lt;&=
lt; 8)<br>
&gt; +#define ZX2967_WDT_START_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x1<br>
&gt; +<br>
&gt; +#define ZX2967_WDT_WRITEKEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x12340000<br>
&gt; +<br>
&gt; +#define ZX2967_WDT_DIV_DEFAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
&gt; +#define ZX2967_WDT_DEFAULT_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A032<br>
&gt; +#define ZX2967_WDT_MIN_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
&gt; +#define ZX2967_WDT_MAX_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0524<br>
&gt; +#define ZX2967_WDT_MAX_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00xffff<br>
&gt; +<br>
&gt; +#define ZX2967_WDT_CLK_FREQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x8000<br>
&gt; +<br>
&gt; +#define ZX2967_WDT_FLAG_REBOOT_MON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0BIT(0)<br>
&gt; +<br>
&gt; +struct zx2967_wdt {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device=C2=A0 wdt_device;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *reg_base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *clock;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u16 reg)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return readl_relaxed(wdt-&gt;reg_base + reg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt, u16 reg,=
 u32 val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt-&gt=
;reg_base + reg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void zx2967_wdt_refresh(struct zx2967_wdt *wdt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WDT_REFRESH_=
REG);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val ^=3D ZX2967_WDT_REFRESH_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_REFRESH_REG, va=
l);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +zx2967_wdt_set_timeout(struct watchdog_device *wdd, unsigned int time=
out)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata(w=
dd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int divisor =3D ZX2967_WDT_DIV_DEFAULT;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int count;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0count =3D timeout * ZX2967_WDT_CLK_FREQ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (count &gt; divisor * ZX2967_WDT_MAX_COUNT)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divisor =3D DIV_ROUND=
_UP(count, ZX2967_WDT_MAX_COUNT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0count =3D DIV_ROUND_UP(count, divisor);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_REG, ZX2967=
_WDT_CFG_DIV(divisor));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, count=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_refresh(wdt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdd-&gt;timeout =3D=C2=A0 (count * divisor) / ZX2=
967_WDT_CLK_FREQ;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void __zx2967_wdt_start(struct zx2967_wdt *wdt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WDT_START_RE=
G);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val |=3D ZX2967_WDT_START_EN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void __zx2967_wdt_stop(struct zx2967_wdt *wdt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WDT_START_RE=
G);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val &amp;=3D ~ZX2967_WDT_START_EN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int zx2967_wdt_start(struct watchdog_device *wdd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata(w=
dd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_set_timeout(wdd, wdd-&gt;timeout);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__zx2967_wdt_start(wdt);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int zx2967_wdt_stop(struct watchdog_device *wdd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata(w=
dd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__zx2967_wdt_stop(wdt);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int zx2967_wdt_keepalive(struct watchdog_device *wdd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata(w=
dd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_refresh(wdt);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define ZX2967_WDT_OPTIONS \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_M=
AGICCLOSE)<br>
&gt; +static const struct watchdog_info zx2967_wdt_ident =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.options=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=
=A0 =C2=A0 =C2=A0ZX2967_WDT_OPTIONS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.identity=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=
=A0 =C2=A0 =C2=A0&quot;zx2967 watchdog&quot;,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct watchdog_ops zx2967_wdt_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.start =3D zx2967_wdt_start,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.stop =3D zx2967_wdt_stop,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.ping =3D zx2967_wdt_keepalive,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_timeout =3D zx2967_wdt_set_timeout,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void zx2967_wdt_reset_sysctrl(<wbr>struct device *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *regmap;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int offset, mask, config;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct of_phandle_args out_args;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D of_parse_phandle_with_fixed_<wbr>args(dev=
-&gt;of_node,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;zte,wdt-reset-sysctrl&quot;, 3, 0, &amp;out_args);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0offset =3D out_args.args[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0config =3D out_args.args[1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mask =3D out_args.args[2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regmap =3D syscon_node_to_regmap(<a href=3D"http:=
//out_args.np" rel=3D"noreferrer" target=3D"_blank">out_<wbr>args.np</a>);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(regmap)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of_node_put(<a href=
=3D"http://out_args.np" rel=3D"noreferrer" target=3D"_blank">out_args.np</a=
>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regmap_update_bits(regmap, offset, mask, config);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0of_node_put(<a href=3D"http://out_args.np" rel=3D=
"noreferrer" target=3D"_blank">out_args.np</a>);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int zx2967_wdt_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource *base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct reset_control *rstc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt =3D devm_kzalloc(dev, sizeof(*wdt), GFP_KERNE=
L);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!wdt)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, wdt);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;<a href=3D"http://wdt_device.info" rel=3D=
"noreferrer" target=3D"_blank">wdt_device.info</a> =3D &amp;zx2967_wdt_iden=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.ops =3D &amp;zx2967_wdt_ops;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.timeout =3D ZX2967_WDT_DEFAULT=
_TIMEOUT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.max_timeout =3D ZX2967_WDT_MAX=
_TIMEOUT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.min_timeout =3D ZX2967_WDT_MIN=
_TIMEOUT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.parent =3D &amp;pdev-&gt;dev;<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0base =3D platform_get_resource(pdev, IORESOURCE_M=
EM, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;reg_base =3D devm_ioremap_resource(dev, b=
ase);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(wdt-&gt;reg_base)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;io=
remap failed\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(wdt-&g=
t;reg_base);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0zx2967_wdt_reset_sysctrl(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdt-&gt;clock =3D devm_clk_get(dev, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(wdt-&gt;clock)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to find watchdog clock source\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(wdt-&g=
t;clock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(wdt-&gt;clock)<wbr>;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to enable clock\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_set_rate(wdt-&gt;clock, ZX2967_WDT_CLK_FREQ);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rstc =3D devm_reset_control_get(dev, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(rstc)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to get rstc&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ERR(rstc)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reset_control_assert(rstc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0usleep_range(500, 20000);<br>
<br>
</div></div>Alright, I&#39;m officially confused.<br>
<br>
First and foremost you still haven&#39;t provided an explanation as to why =
this is<br>
required.=C2=A0 Second, in your previous submission you had:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(10);<br>
<br>
That is a busy loop of 10ms.=C2=A0 In this post using usleep_range() is a s=
tep in the<br>
right direction but the min and max values to wait for don&#39;t make sense=
.=C2=A0 Here<br>
you have 500 and 20000, which is 0.5ms and 20ms.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div>I=
n fact, sleeping for 0.5ms is enough.<br></div><div>we extended the sleepin=
g time to 20ms, the purpose is merging the timer interrupts. of course, it&=
#39;s happy to replace it with usleep_range(500, 1000).<br><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=
=3D"h5">
&gt; +=C2=A0 =C2=A0 =C2=A0reset_control_deassert(rstc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0watchdog_set_drvdata(&amp;wdt-&gt;<wbr>wdt_device=
, wdt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0watchdog_init_timeout(&amp;wdt-&gt;<wbr>wdt_devic=
e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ZX2967_WDT_DEFAULT_TIMEOUT, dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0watchdog_set_nowayout(&amp;wdt-&gt;<wbr>wdt_devic=
e, WATCHDOG_NOWAYOUT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D watchdog_register_device(&amp;wdt-<wbr>&g=
t;wdt_device);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot;watchdog enabled (timeout=3D%=
d sec, nowayout=3D%d)&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wdt-&gt;wdt_device.t=
imeout, WATCHDOG_NOWAYOUT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +err:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(wdt-&gt;<wbr>clock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int zx2967_wdt_remove(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D platform_get_drvdata(p=
dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0watchdog_unregister_device(&amp;<wbr>wdt-&gt;wdt_=
device);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(wdt-&gt;<wbr>clock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct of_device_id zx2967_wdt_match[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;zte,zx296718-wdt&quot;, }=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{}<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, zx2967_wdt_match);<br>
&gt; +<br>
&gt; +static struct platform_driver zx2967_wdt_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D zx29=
67_wdt_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D zx29=
67_wdt_remove,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0=3D=
 &quot;zx2967-wdt&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D o=
f_match_ptr(zx2967_wdt_match)<wbr>,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +module_platform_driver(<wbr>zx2967_wdt_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@linar=
o.org">baoyou.xie@linaro.org</a>&gt;&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;ZTE zx2967 Watchdog Device Driver&quot;);<br=
>
&gt; +MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--001a1144ca223760f40546f5544e--
