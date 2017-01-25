Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <35dcd00f-a4bd-a313-0d6f-932a3f5888f0@roeck-us.net>
References: <1485248322-24299-1-git-send-email-baoyou.xie@linaro.org>
 <1485248322-24299-3-git-send-email-baoyou.xie@linaro.org> <35dcd00f-a4bd-a313-0d6f-932a3f5888f0@roeck-us.net>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Wed, 25 Jan 2017 10:16:45 +0800
Message-ID: <CA+DQWky4---=gRipAR=NqajvwYV2QQQWbztTpPJS5oaL4D6QaQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jun Nie <jun.nie@linaro.org>, wim@iguana.be, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a1148cd220e68e00546e1d3b5
List-ID: <linux-watchdog@vger.kernel.org>

--001a1148cd220e68e00546e1d3b5
Content-Type: text/plain; charset=UTF-8

On 24 January 2017 at 22:50, Guenter Roeck <linux@roeck-us.net> wrote:

> On 01/24/2017 12:58 AM, Baoyou Xie wrote:
>
>> This patch adds watchdog controller driver for ZTE's zx2967 family.
>>
>> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
>> ---
>>  drivers/watchdog/Kconfig      |  10 ++
>>  drivers/watchdog/Makefile     |   1 +
>>  drivers/watchdog/zx2967_wdt.c | 274 ++++++++++++++++++++++++++++++
>> ++++++++++++
>>  3 files changed, 285 insertions(+)
>>  create mode 100644 drivers/watchdog/zx2967_wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index acb00b5..05093a2 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -714,6 +714,16 @@ config ASPEED_WATCHDOG
>>           To compile this driver as a module, choose M here: the
>>           module will be called aspeed_wdt.
>>
>> +config ZX2967_WATCHDOG
>> +       tristate "ZTE zx2967 SoCs watchdog support"
>> +       depends on ARCH_ZX
>> +       select WATCHDOG_CORE
>> +       help
>> +         Say Y here to include support for the watchdog timer
>> +         in ZTE zx2967 SoCs.
>> +         To compile this driver as a module, choose M here: the
>> +         module will be called zx2967_wdt.
>> +
>>  # AVR32 Architecture
>>
>>  config AT32AP700X_WDT
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 0c3d35e..bf2d296 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>>  obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
>>  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
>>  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>> +obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
>>
>>  # AVR32 Architecture
>>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
>> diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.
>> c
>> new file mode 100644
>> index 0000000..89a7018
>> --- /dev/null
>> +++ b/drivers/watchdog/zx2967_wdt.c
>> @@ -0,0 +1,274 @@
>> +/*
>> + * watchdog driver for ZTE's zx2967 family
>> + *
>> + * Copyright (C) 2017 ZTE Ltd.
>> + *
>> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
>> + *
>> + * License terms: GNU General Public License (GPL) version 2
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/watchdog.h>
>> +
>> +#define ZX2967_WDT_CFG_REG                     0x4
>> +#define ZX2967_WDT_LOAD_REG                    0x8
>> +#define ZX2967_WDT_REFRESH_REG                 0x18
>> +#define ZX2967_WDT_START_REG                   0x1c
>> +
>> +#define ZX2967_WDT_REFRESH_MASK                        0x3f
>> +
>> +#define ZX2967_WDT_CFG_DIV(n)                  ((((n) & 0xff) - 1) << 8)
>> +#define ZX2967_WDT_START_EN                    0x1
>> +
>> +#define ZX2967_WDT_WRITEKEY                    0x12340000
>> +
>> +#define ZX2967_WDT_DIV_DEFAULT                 16
>> +#define ZX2967_WDT_DEFAULT_TIMEOUT             32
>> +#define ZX2967_WDT_MIN_TIMEOUT                 1
>> +#define ZX2967_WDT_MAX_TIMEOUT                 500
>>
>
> Why not use the real maximum ? Just wondering.
>
> Obviously, 524 is the accruate value, but we believe 500 is long enough.
For accuracy, I will modify this value to 524 in next version.

>
> +#define ZX2967_WDT_MAX_COUNT                   0xffff
>> +
>> +#define ZX2967_WDT_CLK_FREQ                    0x8000
>> +
>> +#define ZX2967_WDT_FLAG_REBOOT_MON             BIT(0)
>> +
>> +struct zx2967_wdt {
>> +       struct watchdog_device  wdt_device;
>> +       void __iomem            *reg_base;
>> +       struct clk              *clock;
>> +};
>> +
>> +static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u16 reg)
>> +{
>> +       return readl_relaxed(wdt->reg_base + reg);
>> +}
>> +
>> +static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt, u16 reg,
>> u32 val)
>> +{
>> +       writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt->reg_base + reg);
>> +}
>> +
>> +static void zx2967_wdt_refresh(struct zx2967_wdt *wdt)
>> +{
>> +       u32 val;
>> +
>> +       val = zx2967_wdt_readl(wdt, ZX2967_WDT_REFRESH_REG);
>> +       val ^= ZX2967_WDT_REFRESH_MASK;
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_REFRESH_REG, val);
>> +}
>> +
>> +static int
>> +zx2967_wdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)
>> +{
>> +       struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
>> +       unsigned int divisor = ZX2967_WDT_DIV_DEFAULT;
>> +       unsigned int count;
>> +
>> +       count = timeout * ZX2967_WDT_CLK_FREQ;
>> +       if (count > divisor * ZX2967_WDT_MAX_COUNT)
>> +               divisor = DIV_ROUND_UP(count, ZX2967_WDT_MAX_COUNT);
>> +       count = DIV_ROUND_UP(count, divisor);
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_REG,
>> ZX2967_WDT_CFG_DIV(divisor));
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, count);
>> +       zx2967_wdt_refresh(wdt);
>> +       wdd->timeout =  (count * divisor) / ZX2967_WDT_CLK_FREQ;
>> +
>> +       return 0;
>> +}
>> +
>> +static void __zx2967_wdt_start(struct zx2967_wdt *wdt)
>> +{
>> +       u32 val;
>> +
>> +       val = zx2967_wdt_readl(wdt, ZX2967_WDT_START_REG);
>> +       val |= ZX2967_WDT_START_EN;
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val);
>> +}
>> +
>> +static void __zx2967_wdt_stop(struct zx2967_wdt *wdt)
>> +{
>> +       u32 val;
>> +
>> +       val = zx2967_wdt_readl(wdt, ZX2967_WDT_START_REG);
>> +       val &= ~ZX2967_WDT_START_EN;
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, val);
>> +}
>> +
>> +static int zx2967_wdt_start(struct watchdog_device *wdd)
>> +{
>> +       struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +       zx2967_wdt_set_timeout(wdd, wdd->timeout);
>> +       __zx2967_wdt_start(wdt);
>> +
>> +       return 0;
>> +}
>> +
>> +static int zx2967_wdt_stop(struct watchdog_device *wdd)
>> +{
>> +       struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +       __zx2967_wdt_stop(wdt);
>> +
>> +       return 0;
>> +}
>> +
>> +static int zx2967_wdt_keepalive(struct watchdog_device *wdd)
>> +{
>> +       struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +       zx2967_wdt_refresh(wdt);
>> +
>> +       return 0;
>> +}
>> +
>> +#define ZX2967_WDT_OPTIONS \
>> +       (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
>> +static const struct watchdog_info zx2967_wdt_ident = {
>> +       .options          =     ZX2967_WDT_OPTIONS,
>>
>
> Does that make the code easier to read ? I presonally like being able to
> grep for
> "options" in the driver to get a glimpse.
>
> +       .firmware_version =     0,
>>
>
> Initializing a static field to 0 is unnecessary.
>
> ok.

>
> +       .identity         =     "zx2967 watchdog",
>> +};
>> +
>> +static struct watchdog_ops zx2967_wdt_ops = {
>> +       .owner = THIS_MODULE,
>> +       .start = zx2967_wdt_start,
>> +       .stop = zx2967_wdt_stop,
>> +       .ping = zx2967_wdt_keepalive,
>> +       .set_timeout = zx2967_wdt_set_timeout,
>> +};
>> +
>> +static void zx2967_wdt_reset_sysctrl(struct device *dev)
>> +{
>> +       int ret;
>> +       void __iomem *regmap;
>> +       unsigned int offset, mask, config;
>> +       struct of_phandle_args out_args;
>> +
>> +       ret = of_parse_phandle_with_fixed_args(dev->of_node,
>> +                       "zte,wdt-reset-sysctrl", 3, 0, &out_args);
>> +       if (ret)
>> +               return;
>> +
>> +       offset = out_args.args[0];
>> +       config = out_args.args[1];
>> +       mask = out_args.args[2];
>> +
>> +       regmap = syscon_node_to_regmap(out_args.np);
>> +       if (IS_ERR(regmap))
>> +               return;
>> +
>> +       regmap_update_bits(regmap, offset, mask, config);
>>
>
> Another comment suggested adding
>         of_node_put(out_args.np);
> here.
>
>
> is it really? most of the driver that call this function don't call
of_node_put. but it seems harmless to call of_node_put.


> +}
>> +
>> +static int zx2967_wdt_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct zx2967_wdt *wdt;
>> +       struct resource *base;
>> +       int ret;
>> +       struct reset_control *rstc;
>> +
>> +       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> +       if (!wdt)
>> +               return -ENOMEM;
>> +
>> +       platform_set_drvdata(pdev, wdt);
>> +
>> +       wdt->wdt_device.info = &zx2967_wdt_ident;
>> +       wdt->wdt_device.ops = &zx2967_wdt_ops;
>> +       wdt->wdt_device.timeout = ZX2967_WDT_DEFAULT_TIMEOUT;
>> +       wdt->wdt_device.max_timeout = ZX2967_WDT_MAX_TIMEOUT;
>> +       wdt->wdt_device.min_timeout = ZX2967_WDT_MIN_TIMEOUT;
>> +       wdt->wdt_device.parent = &pdev->dev;
>> +
>> +       base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       wdt->reg_base = devm_ioremap_resource(dev, base);
>> +       if (IS_ERR(wdt->reg_base)) {
>> +               dev_err(dev, "ioremap failed\n");
>> +               return PTR_ERR(wdt->reg_base);
>> +       }
>> +
>> +       zx2967_wdt_reset_sysctrl(dev);
>> +
>> +       wdt->clock = devm_clk_get(dev, NULL);
>> +       if (IS_ERR(wdt->clock)) {
>> +               dev_err(dev, "failed to find watchdog clock source\n");
>> +               return PTR_ERR(wdt->clock);
>> +       }
>> +
>> +       ret = clk_prepare_enable(wdt->clock);
>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to enable clock\n");
>> +               return ret;
>> +       }
>> +       clk_set_rate(wdt->clock, ZX2967_WDT_CLK_FREQ);
>> +
>> +       rstc = devm_reset_control_get(dev, NULL);
>> +       if (IS_ERR(rstc)) {
>> +               dev_err(dev, "failed to get rstc");
>> +               ret = PTR_ERR(rstc);
>> +               goto fail_get_reset_control;
>> +       }
>> +
>> +       reset_control_assert(rstc);
>> +       mdelay(10);
>> +       reset_control_deassert(rstc);
>> +
>> +       watchdog_set_drvdata(&wdt->wdt_device, wdt);
>> +       watchdog_set_nowayout(&wdt->wdt_device, WATCHDOG_NOWAYOUT);
>>
>
> A call to watchdog_init_timeout() may be valuable here to catch
> timeout values from devicetree. Otherwise, displaying the selected timeout
> below (which is a constant) doesn't really add much value.
>
> ok. I will modify the code and zte,zx2967-wdt.txt.


> +
>> +       ret = watchdog_register_device(&wdt->wdt_device);
>> +       if (ret)
>> +               goto fail_register;
>> +
>> +       dev_info(dev, "watchdog enabled (timeout=%d sec, nowayout=%d)",
>> +                wdt->wdt_device.timeout, WATCHDOG_NOWAYOUT);
>> +
>> +       return 0;
>> +
>> +fail_register:
>> +       watchdog_unregister_device(&wdt->wdt_device);
>>
>
> As asked before - why try to unregister if the registration failed ?
>
>
ok, fixed it.

> +fail_get_reset_control:
>> +       clk_disable_unprepare(wdt->clock);
>> +       return ret;
>> +}
>> +
>> +static int zx2967_wdt_remove(struct platform_device *pdev)
>> +{
>> +       struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
>> +
>> +       watchdog_unregister_device(&wdt->wdt_device);
>> +       clk_disable_unprepare(wdt->clock);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id zx2967_wdt_match[] = {
>> +       { .compatible = "zte,zx296718-wdt", },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, zx2967_wdt_match);
>> +
>> +static struct platform_driver zx2967_wdt_driver = {
>> +       .probe          = zx2967_wdt_probe,
>> +       .remove         = zx2967_wdt_remove,
>> +       .driver         = {
>> +               .name   = "zx2967-wdt",
>> +               .of_match_table = of_match_ptr(zx2967_wdt_match),
>> +       },
>> +};
>> +module_platform_driver(zx2967_wdt_driver);
>> +
>> +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
>> +MODULE_DESCRIPTION("ZTE zx2967 Watchdog Device Driver");
>> +MODULE_LICENSE("GPL v2");
>>
>>
>

--001a1148cd220e68e00546e1d3b5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 24 January 2017 at 22:50, Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div c=
lass=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On 01/24/2017 12:58 AM, Baoyo=
u Xie wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
This patch adds watchdog controller driver for ZTE&#39;s zx2967 family.<br>
<br>
Signed-off-by: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@linaro.org" targ=
et=3D"_blank">baoyou.xie@linaro.org</a>&gt;<br>
---<br>
=C2=A0drivers/watchdog/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 ++<br>
=C2=A0drivers/watchdog/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0drivers/watchdog/zx2967_wdt.c | 274 ++++++++++++++++++++++++++++++<wb=
r>++++++++++++<br>
=C2=A03 files changed, 285 insertions(+)<br>
=C2=A0create mode 100644 drivers/watchdog/zx2967_wdt.c<br>
<br>
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig<br>
index acb00b5..05093a2 100644<br>
--- a/drivers/watchdog/Kconfig<br>
+++ b/drivers/watchdog/Kconfig<br>
@@ -714,6 +714,16 @@ config ASPEED_WATCHDOG<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, choo=
se M here: the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 module will be called aspeed_wdt.<br>
<br>
+config ZX2967_WATCHDOG<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;ZTE zx2967 SoCs watchdog support=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_ZX<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0select WATCHDOG_CORE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here to include support for the wa=
tchdog timer<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in ZTE zx2967 SoCs.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choo=
se M here: the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called zx2967_wdt.<br>
+<br>
=C2=A0# AVR32 Architecture<br>
<br>
=C2=A0config AT32AP700X_WDT<br>
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile<br>
index 0c3d35e..bf2d296 100644<br>
--- a/drivers/watchdog/Makefile<br>
+++ b/drivers/watchdog/Makefile<br>
@@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) +=3D bcm7038_wdt.o<br>
=C2=A0obj-$(CONFIG_ATLAS7_WATCHDOG) +=3D atlas7_wdt.o<br>
=C2=A0obj-$(CONFIG_RENESAS_WDT) +=3D renesas_wdt.o<br>
=C2=A0obj-$(CONFIG_ASPEED_WATCHDOG) +=3D aspeed_wdt.o<br>
+obj-$(CONFIG_ZX2967_WATCHDOG) +=3D zx2967_wdt.o<br>
<br>
=C2=A0# AVR32 Architecture<br>
=C2=A0obj-$(CONFIG_AT32AP700X_WDT) +=3D at32ap700x_wdt.o<br>
diff --git a/drivers/watchdog/zx2967_wdt.<wbr>c b/drivers/watchdog/zx2967_w=
dt.<wbr>c<br>
new file mode 100644<br>
index 0000000..89a7018<br>
--- /dev/null<br>
+++ b/drivers/watchdog/zx2967_wdt.<wbr>c<br>
@@ -0,0 +1,274 @@<br>
+/*<br>
+ * watchdog driver for ZTE&#39;s zx2967 family<br>
+ *<br>
+ * Copyright (C) 2017 ZTE Ltd.<br>
+ *<br>
+ * Author: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@linaro.org" target=
=3D"_blank">baoyou.xie@linaro.org</a>&gt;<br>
+ *<br>
+ * License terms: GNU General Public License (GPL) version 2<br>
+ */<br>
+<br>
+#include &lt;linux/clk.h&gt;<br>
+#include &lt;linux/delay.h&gt;<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/mfd/syscon.h&gt;<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/of_address.h&gt;<br>
+#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/regmap.h&gt;<br>
+#include &lt;linux/reset.h&gt;<br>
+#include &lt;linux/watchdog.h&gt;<br>
+<br>
+#define ZX2967_WDT_CFG_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4<br>
+#define ZX2967_WDT_LOAD_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x8<br>
+#define ZX2967_WDT_REFRESH_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x18<br>
+#define ZX2967_WDT_START_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x1c<br>
+<br>
+#define ZX2967_WDT_REFRESH_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3f<br>
+<br>
+#define ZX2967_WDT_CFG_DIV(n)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ((((n) &amp; 0xff) - 1) &lt;&lt; 8)<br>
+#define ZX2967_WDT_START_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x1<br>
+<br>
+#define ZX2967_WDT_WRITEKEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x12340000<br>
+<br>
+#define ZX2967_WDT_DIV_DEFAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A016<br>
+#define ZX2967_WDT_DEFAULT_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A032<br>
+#define ZX2967_WDT_MIN_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01<br>
+#define ZX2967_WDT_MAX_TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0500<br>
</blockquote>
<br></div></div>
Why not use the real maximum ? Just wondering.<div><div class=3D"gmail-h5">=
<br></div></div></blockquote><div>Obviously, 524 is the accruate value, but=
 we believe 500 is long enough. For accuracy, I will modify this value to 5=
24 in next version. <br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div><div class=3D"gmail-h5">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+#define ZX2967_WDT_MAX_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00xffff<br>
+<br>
+#define ZX2967_WDT_CLK_FREQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x8000<br>
+<br>
+#define ZX2967_WDT_FLAG_REBOOT_MON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(0)<br>
+<br>
+struct zx2967_wdt {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct watchdog_device=C2=A0 wdt_device;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *reg_base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 *clock;<br>
+};<br>
+<br>
+static inline u32 zx2967_wdt_readl(struct zx2967_wdt *wdt, u16 reg)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return readl_relaxed(wdt-&gt;reg_base + reg);<b=
r>
+}<br>
+<br>
+static inline void zx2967_wdt_writel(struct zx2967_wdt *wdt, u16 reg, u32 =
val)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel_relaxed(val | ZX2967_WDT_WRITEKEY, wdt-&=
gt;reg_base + reg);<br>
+}<br>
+<br>
+static void zx2967_wdt_refresh(struct zx2967_wdt *wdt)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 val;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WDT_REFRES=
H_REG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0val ^=3D ZX2967_WDT_REFRESH_MASK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_REFRESH_REG, =
val);<br>
+}<br>
+<br>
+static int<br>
+zx2967_wdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)<=
br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata=
(wdd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int divisor =3D ZX2967_WDT_DIV_DEFAULT=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int count;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D timeout * ZX2967_WDT_CLK_FREQ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (count &gt; divisor * ZX2967_WDT_MAX_COUNT)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divisor =3D DIV_ROU=
ND_UP(count, ZX2967_WDT_MAX_COUNT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D DIV_ROUND_UP(count, divisor);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_REG, ZX29=
67_WDT_CFG_DIV(divisor));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, cou=
nt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_refresh(wdt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdd-&gt;timeout =3D=C2=A0 (count * divisor) / Z=
X2967_WDT_CLK_FREQ;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static void __zx2967_wdt_start(struct zx2967_wdt *wdt)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 val;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WDT_START_=
REG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0val |=3D ZX2967_WDT_START_EN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, va=
l);<br>
+}<br>
+<br>
+static void __zx2967_wdt_stop(struct zx2967_wdt *wdt)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 val;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D zx2967_wdt_readl(wdt, ZX2967_WDT_START_=
REG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0val &amp;=3D ~ZX2967_WDT_START_EN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, va=
l);<br>
+}<br>
+<br>
+static int zx2967_wdt_start(struct watchdog_device *wdd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata=
(wdd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_set_timeout(wdd, wdd-&gt;timeout);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__zx2967_wdt_start(wdt);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int zx2967_wdt_stop(struct watchdog_device *wdd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata=
(wdd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__zx2967_wdt_stop(wdt);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int zx2967_wdt_keepalive(struct watchdog_device *wdd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata=
(wdd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_refresh(wdt);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+#define ZX2967_WDT_OPTIONS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0(WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF=
_MAGICCLOSE)<br>
+static const struct watchdog_info zx2967_wdt_ident =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.options=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 =C2=A0 =C2=A0ZX2967_WDT_OPTIONS,<br>
</blockquote>
<br></div></div>
Does that make the code easier to read ? I presonally like being able to gr=
ep for<br>
&quot;options&quot; in the driver to get a glimpse.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.firmware_version =3D=C2=A0 =C2=A0 =C2=A00,<br>
</blockquote>
<br>
Initializing a static field to 0 is unnecessary.<div><div class=3D"gmail-h5=
"><br></div></div></blockquote><div>ok. <br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div><div class=3D"gmail-h5">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.identity=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
=C2=A0 =C2=A0 =C2=A0&quot;zx2967 watchdog&quot;,<br>
+};<br>
+<br>
+static struct watchdog_ops zx2967_wdt_ops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.start =3D zx2967_wdt_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.stop =3D zx2967_wdt_stop,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.ping =3D zx2967_wdt_keepalive,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_timeout =3D zx2967_wdt_set_timeout,<br>
+};<br>
+<br>
+static void zx2967_wdt_reset_sysctrl(struc<wbr>t device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *regmap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int offset, mask, config;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct of_phandle_args out_args;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D of_parse_phandle_with_fixed_ar<wbr>gs(d=
ev-&gt;of_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;zte,wdt-reset-sysctrl&quot;, 3, 0, &amp;out_args);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D out_args.args[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0config =3D out_args.args[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D out_args.args[2];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regmap =3D syscon_node_to_regmap(<a href=3D"htt=
p://out_args.np" rel=3D"noreferrer" target=3D"_blank">out_args<wbr>.np</a>)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(regmap))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regmap_update_bits(regmap, offset, mask, config=
);<br>
</blockquote>
<br></div></div>
Another comment suggested adding<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 of_node_put(<a href=3D"http://out_args.np" rel=
=3D"noreferrer" target=3D"_blank">out_args.np</a>);<br>
here.<div><div class=3D"gmail-h5"><br>
<br></div></div></blockquote><div>is it really? most of the driver that cal=
l this function don&#39;t call of_node_put. but it seems harmless to call o=
f_node_put. <br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div><div class=3D"gmail-h5">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static int zx2967_wdt_probe(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct reset_control *rstc;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt =3D devm_kzalloc(dev, sizeof(*wdt), GFP_KER=
NEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, wdt);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;<a href=3D"http://wdt_device.info" rel=
=3D"noreferrer" target=3D"_blank">wdt_device.info</a> =3D &amp;zx2967_wdt_i=
dent;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.ops =3D &amp;zx2967_wdt_ops;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.timeout =3D ZX2967_WDT_DEFAU=
LT_TIMEOUT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.max_timeout =3D ZX2967_WDT_M=
AX_TIMEOUT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.min_timeout =3D ZX2967_WDT_M=
IN_TIMEOUT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;wdt_device.parent =3D &amp;pdev-&gt;dev=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0base =3D platform_get_resource(pdev, IORESOURCE=
_MEM, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;reg_base =3D devm_ioremap_resource(dev,=
 base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(wdt-&gt;reg_base)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
ioremap failed\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(wdt-=
&gt;reg_base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_reset_sysctrl(dev)<wbr>;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;clock =3D devm_clk_get(dev, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(wdt-&gt;clock)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
failed to find watchdog clock source\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(wdt-=
&gt;clock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(wdt-&gt;clock)<wbr>;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
failed to enable clock\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_set_rate(wdt-&gt;clock, ZX2967_WDT_CLK_FREQ=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rstc =3D devm_reset_control_get(dev, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(rstc)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
failed to get rstc&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ERR(rst=
c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail_get_reset=
_control;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reset_control_assert(rstc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reset_control_deassert(rstc);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_set_drvdata(&amp;wdt-&gt;wd<wbr>t_devi=
ce, wdt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_set_nowayout(&amp;wdt-&gt;w<wbr>dt_dev=
ice, WATCHDOG_NOWAYOUT);<br>
</blockquote>
<br></div></div>
A call to watchdog_init_timeout() may be valuable here to catch<br>
timeout values from devicetree. Otherwise, displaying the selected timeout<=
br>
below (which is a constant) doesn&#39;t really add much value.<span class=
=3D"gmail-"><br>
<br></span></blockquote><div>ok. I will modify the code and zte,zx2967-wdt.=
txt.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><span class=3D"gmail-">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D watchdog_register_device(&amp;wdt-<wbr>=
&gt;wdt_device);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail_register;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot;watchdog enabled (timeout=
=3D%d sec, nowayout=3D%d)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wdt-&gt;wdt_device=
.timeout, WATCHDOG_NOWAYOUT);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+fail_register:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_unregister_device(&amp;w<wbr>dt-&gt;wd=
t_device);<br>
</blockquote>
<br></span>
As asked before - why try to unregister if the registration failed ?<div>=
=C2=A0<br></div></blockquote><div>ok, fixed it. <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div class=3D"gmail-HOEnZb"><div class=3D"=
gmail-h5">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+fail_get_reset_control:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(wdt-&gt;cl<wbr>ock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static int zx2967_wdt_remove(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D platform_get_drvdata=
(pdev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_unregister_device(&amp;w<wbr>dt-&gt;wd=
t_device);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(wdt-&gt;cl<wbr>ock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static const struct of_device_id zx2967_wdt_match[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;zte,zx296718-wdt&quot;,=
 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
+};<br>
+MODULE_DEVICE_TABLE(of, zx2967_wdt_match);<br>
+<br>
+static struct platform_driver zx2967_wdt_driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D zx=
2967_wdt_probe,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D zx=
2967_wdt_remove,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0=
=3D &quot;zx2967-wdt&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D=
 of_match_ptr(zx2967_wdt_match)<wbr>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+module_platform_driver(zx2967<wbr>_wdt_driver);<br>
+<br>
+MODULE_AUTHOR(&quot;Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@linaro.org=
" target=3D"_blank">baoyou.xie@linaro.org</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;ZTE zx2967 Watchdog Device Driver&quot;);<br>
+MODULE_LICENSE(&quot;GPL v2&quot;);<br>
<br>
</blockquote>
<br>
</div></div></blockquote></div><br></div></div>

--001a1148cd220e68e00546e1d3b5--
