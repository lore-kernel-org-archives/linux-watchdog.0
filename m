Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <cdb27525-bcf2-9ad5-08b2-d454c8d51e10@roeck-us.net>
References: <1484917398-15604-1-git-send-email-baoyou.xie@linaro.org>
 <1484917398-15604-3-git-send-email-baoyou.xie@linaro.org> <cdb27525-bcf2-9ad5-08b2-d454c8d51e10@roeck-us.net>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Sun, 22 Jan 2017 15:50:46 +0800
Message-ID: <CA+DQWkwEhj2otbJanMUTEz77PsO4d=ocQqwGLkexjjWPK6pdDQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jun Nie <jun.nie@linaro.org>, wim@iguana.be, Rob Herring <robh+dt@kernel.org>,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a1140b0fa15ca260546aa2403
List-ID: <linux-watchdog@vger.kernel.org>

--001a1140b0fa15ca260546aa2403
Content-Type: text/plain; charset=UTF-8

On 22 January 2017 at 07:06, Guenter Roeck <linux@roeck-us.net> wrote:

> On 01/20/2017 05:03 AM, Baoyou Xie wrote:
>
>> This patch adds watchdog controller driver for ZTE's zx2967 family.
>>
>> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
>> ---
>>  drivers/watchdog/Kconfig      |  10 ++
>>  drivers/watchdog/Makefile     |   1 +
>>  drivers/watchdog/zx2967_wdt.c | 376 ++++++++++++++++++++++++++++++
>> ++++++++++++
>>  3 files changed, 387 insertions(+)
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
>> index 0000000..a5656d0
>> --- /dev/null
>> +++ b/drivers/watchdog/zx2967_wdt.c
>> @@ -0,0 +1,376 @@
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
>> +#include <linux/reboot.h>
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
> Is that based on a real limit or an arbitrary value ?
>
> It's based on a real limit. In fact, the real limit is 524.


> +#define ZX2967_WDT_MAX_COUNT                   0xffff
>> +
>> +#define ZX2967_WDT_FLAG_REBOOT_MON             (1 << 0)
>>
>
> BIT ?
>
>
> +
>> +struct zx2967_wdt {
>> +       struct device           *dev;
>> +       struct clk              *clock;
>> +       void __iomem            *reg_base;
>> +       unsigned int            conf;
>> +       unsigned int            load;
>> +       unsigned int            flags;
>> +       struct watchdog_device  wdt_device;
>> +       struct notifier_block   restart_handler;
>> +       struct notifier_block   reboot_handler;
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
>> +static unsigned int
>> +__zx2967_wdt_set_timeout(struct zx2967_wdt *wdt, unsigned int timeout)
>> +{
>> +       unsigned int freq = clk_get_rate(wdt->clock);
>>
>
> The clock frequency is set to 32 kHz. It seems unnecessary to re-read it
> whenever the timeout changes. Also, ...
>
> +       unsigned int divisor = ZX2967_WDT_DIV_DEFAULT;
>> +       unsigned int count;
>> +
>> +       count = timeout * freq;
>> +       if (count > divisor * ZX2967_WDT_MAX_COUNT)
>> +               divisor = DIV_ROUND_UP(count, ZX2967_WDT_MAX_COUNT);
>> +       count = DIV_ROUND_UP(count, divisor);
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_CFG_REG,
>> ZX2967_WDT_CFG_DIV(divisor));
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, count);
>> +       zx2967_wdt_refresh(wdt);
>> +       wdt->load = count;
>> +
>> +       return (count * divisor) / freq;
>>
>
> ... if you think it can change from underneath you, you'll also need to
> make sure
> it is not 0, to avoid a nasty surprise here. Of course, if it does change,
> you'll
> have no idea what the actual timeout is at any given time, and the driver
> won't work.
>
> +}
>> +
>> +static int zx2967_wdt_set_timeout(struct watchdog_device *wdd,
>> +                                 unsigned int timeout)
>> +{
>> +       struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +       if (watchdog_timeout_invalid(&wdt->wdt_device, timeout)) {
>> +               dev_err(wdt->dev, "timeout %d is invalid\n", timeout);
>> +               return -EINVAL;
>> +       }
>>
>
> This function is called from the infrastructure. Let's trust the
> infrastructure
> to check the valid range before calling this code.
>
> +
>> +       wdd->timeout = __zx2967_wdt_set_timeout(wdt, timeout);
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
>> +       __zx2967_wdt_stop(wdt);
>> +       zx2967_wdt_set_timeout(wdd, wdd->timeout);
>>
>
> This seems inconsistent. First, the watchdog should not already be
> started when this function is called. Second, if it is in fact necessary
> to stop the watchdog before updating its timeout, you might want to
> consider stopping it in the set_timeout function, because that
> function _will_ be called if the timeout is updated while the
> watchdog is running.
>
>
> +       __zx2967_wdt_start(wdt);
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
>> +       .firmware_version =     0,
>> +       .identity         =     "zx2967 watchdog",
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
>> +static void zx2967_wdt_fix_sysdown(struct zx2967_wdt *wdt)
>> +{
>> +       __zx2967_wdt_stop(wdt);
>> +       __zx2967_wdt_set_timeout(wdt, 15);
>> +       __zx2967_wdt_start(wdt);
>> +}
>>
>
> I am really not at all in favor of this code. It force-sets a watchdog
> to 15 seconds later, if it was enabled or not.
>
> I don't necessarily oppose the idea in general, but it would have to be
> configurable and part of the infrastructure.
>
> I agree you all. In fact, these codes implement the policy witch is part
of products, and don't necessarily place them here.


>
> +
>> +static int zx2967_wdt_notify_sys(struct notifier_block *this,
>> +                            unsigned long code, void *unused)
>> +{
>> +       struct zx2967_wdt *wdt = container_of(this, struct zx2967_wdt,
>> +                                             reboot_handler);
>> +
>> +       wdt->flags |= ZX2967_WDT_FLAG_REBOOT_MON;
>> +       switch (code) {
>> +       case SYS_HALT:
>> +       case SYS_POWER_OFF:
>> +       case SYS_RESTART:
>> +               zx2967_wdt_fix_sysdown(wdt);
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int zx2967_wdt_restart(struct notifier_block *this,
>> +                             unsigned long mode, void *cmd)
>> +{
>> +       struct zx2967_wdt *wdt;
>> +
>> +       wdt = container_of(this, struct zx2967_wdt, restart_handler);
>> +
>> +       zx2967_wdt_stop(&wdt->wdt_device);
>> +
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, 0x80);
>> +       zx2967_wdt_refresh(wdt);
>> +       zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, ZX2967_WDT_START_EN);
>> +
>> +       zx2967_wdt_start(&wdt->wdt_device);
>> +       /* wait for reset*/
>> +       mdelay(500);
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +static void zx2967_wdt_reset_sysctrl(struct device *dev)
>> +{
>> +       int ret;
>> +       struct device_node *np = NULL;
>> +       void __iomem *regmap;
>> +       unsigned int offset, mask, config;
>> +       struct of_phandle_args out_args;
>> +
>> +       ret = of_parse_phandle_with_fixed_args(dev->of_node,
>> +                       "zte,wdt-reset-sysctrl", 3, 0, &out_args);
>> +       if (ret) {
>> +               dev_info(dev, "failed to parse zte,wdt-reset-sysctrl");
>>
>
> Why this message ? The property is optional. There is no "failure".
>
> Repeating the information in the devicetree description:
>
>         zte,wdt-reset-sysctrl : Directs how to reset system by the
> watchdog.
>
> Given the context, and the provided implementation, I can only assume that
> this is supposed to mean which action shall be taken when the watchdog
> triggers,
> and that the bit mask provided is supposed to configure that action. If so,
> that should be explained in the devicetree description, and not be hidden
> in magic register values.
>
> The devicetree description is ok.


> +               return;
>> +       }
>> +       offset = out_args.args[0];
>> +       config = out_args.args[1];
>> +       mask = out_args.args[2];
>> +
>> +       regmap = syscon_node_to_regmap(out_args.np);
>> +       if (IS_ERR(regmap))
>> +               goto out;
>> +
>> +       regmap_update_bits(regmap, offset, mask, config);
>>
>
>
> I don't really see the value of the local variables.
>
> Are you sure? I add the local variables in V3.


> +out:
>> +       of_node_put(np);
>>
>
> I don't really see where np is set to anything but NULL.
>
> +}
>> +
>> +static int zx2967_wdt_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev;
>> +       struct zx2967_wdt *wdt;
>> +       struct resource *base;
>> +       int ret = 0;
>>
>
> Unnecessary initialization.
>
> +
>> +       struct reset_control *rstc;
>>
>
> No empty lines between variable declarations, please.
>
> +
>> +       dev = &pdev->dev;
>>
>
> Can be initialized above.
>
> +
>> +       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> +       if (!wdt)
>> +               return -ENOMEM;
>> +
>> +       platform_set_drvdata(pdev, wdt);
>> +
>> +       wdt->dev = dev;
>>
>
> This is only used by an error message in the set_timeout function,
> which is unnecessary.
>
> +       wdt->wdt_device.info = &zx2967_wdt_ident;
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
>> +       wdt->reboot_handler.notifier_call = zx2967_wdt_notify_sys;
>> +       register_reboot_notifier(&wdt->reboot_handler);
>>
>
> Without ever unregistering it ? Did you try to unload the driver and
> reboot ?
>
> +       wdt->clock = devm_clk_get(dev, NULL);
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
>> +       clk_set_rate(wdt->clock, 32768);
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
>>
>
> There is this reset, and the reset in reset_sysctrl above.
> Are they both necessary ?
>
> Here, we reset watchdog itself, but reset_sysctrl is used to reset system.


> +       watchdog_set_drvdata(&wdt->wdt_device, wdt);
>> +
>> +       watchdog_init_timeout(&wdt->wdt_device,
>> +                             ZX2967_WDT_DEFAULT_TIMEOUT, dev);
>>
>
> What is the purpose of this call ? It sets the timeout to the default
> timeout,
> which is already set, and it does not use the value from devicetree since
> the
> value passed is != 0.
>
> +       watchdog_set_nowayout(&wdt->wdt_device, WATCHDOG_NOWAYOUT);
>> +
>> +       zx2967_wdt_stop(&wdt->wdt_device);
>>
>
> The watchdog was reset twice above. Is this call really necessary ?
>
> +
>> +       ret = watchdog_register_device(&wdt->wdt_device);
>> +       if (ret)
>> +               goto fail_register;
>> +
>> +       wdt->restart_handler.notifier_call = zx2967_wdt_restart;
>> +       wdt->restart_handler.priority = 128;
>> +       ret = register_restart_handler(&wdt->restart_handler);
>> +       if (ret) {
>> +               dev_err(dev, "cannot register restart handler, %d\n",
>> ret);
>> +               goto fail_restart;
>> +       }
>> +
>>
> Why not use the infrastructure ?
>
> +       dev_info(dev, "watchdog enabled (timeout=%d sec, nowayout=%d)",
>> +                wdt->wdt_device.timeout, WATCHDOG_NOWAYOUT);
>> +
>> +       return 0;
>> +
>> +fail_get_reset_control:
>> +fail_restart:
>>
>
> Please no double labels to the same code.
>
> +       watchdog_unregister_device(&wdt->wdt_device);
>> +fail_register:
>> +       clk_disable_unprepare(wdt->clock);
>> +       return ret;
>> +}
>> +
>> +static int zx2967_wdt_remove(struct platform_device *pdev)
>> +{
>> +       struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
>> +
>> +       unregister_restart_handler(&wdt->restart_handler);
>> +       watchdog_unregister_device(&wdt->wdt_device);
>> +       clk_disable_unprepare(wdt->clock);
>> +
>> +       return 0;
>> +}
>> +
>> +static void zx2967_wdt_shutdown(struct platform_device *pdev)
>> +{
>> +       struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
>> +
>> +       if (!(wdt->flags & ZX2967_WDT_FLAG_REBOOT_MON))
>> +               zx2967_wdt_stop(&wdt->wdt_device);
>>
>
> As mentioned before, the whole reboot handling is highly unusual.
>
> I don't really like the idea of bypassing the infrastructure
> (such as watchdog_stop_on_reboot()) for driver specific special behavior.
> If such behavior is useful, it should be useful for all watchdog drivers,
> and be defined in the infrastructure.
>
>
> +}
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
>> +       .shutdown       = zx2967_wdt_shutdown,
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

--001a1140b0fa15ca260546aa2403
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 22 January 2017 at 07:06, Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div c=
lass=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On 01/20/2017 05:03 AM, Baoyo=
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
=C2=A0drivers/watchdog/zx2967_wdt.c | 376 ++++++++++++++++++++++++++++++<wb=
r>++++++++++++<br>
=C2=A03 files changed, 387 insertions(+)<br>
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
index 0000000..a5656d0<br>
--- /dev/null<br>
+++ b/drivers/watchdog/zx2967_wdt.<wbr>c<br>
@@ -0,0 +1,376 @@<br>
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
+#include &lt;linux/reboot.h&gt;<br>
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
Is that based on a real limit or an arbitrary value ?<span class=3D"gmail-"=
><br>
<br></span></blockquote><div>It&#39;s based on a real limit. In fact, the r=
eal limit is 524.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><span class=3D"gmail-">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+#define ZX2967_WDT_MAX_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00xffff<br>
+<br>
+#define ZX2967_WDT_FLAG_REBOOT_MON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; 0)<br>
</blockquote>
<br></span>
BIT ?<div><div class=3D"gmail-h5"><br></div></div></blockquote><div></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div><div class=3D"gmail-h=
5">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+struct zx2967_wdt {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 *clock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *reg_base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 conf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 load;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct watchdog_device=C2=A0 wdt_device;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block=C2=A0 =C2=A0restart_handl=
er;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block=C2=A0 =C2=A0reboot_handle=
r;<br>
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
+static unsigned int<br>
+__zx2967_wdt_set_timeout(stru<wbr>ct zx2967_wdt *wdt, unsigned int timeout=
)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int freq =3D clk_get_rate(wdt-&gt;cloc=
k);<br>
</blockquote>
<br></div></div>
The clock frequency is set to 32 kHz. It seems unnecessary to re-read it<br=
>
whenever the timeout changes. Also, ...<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int divisor =3D ZX2967_WDT_DIV_DEFAULT=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int count;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D timeout * freq;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;load =3D count;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (count * divisor) / freq;<br>
</blockquote>
<br></span>
... if you think it can change from underneath you, you&#39;ll also need to=
 make sure<br>
it is not 0, to avoid a nasty surprise here. Of course, if it does change, =
you&#39;ll<br>
have no idea what the actual timeout is at any given time, and the driver w=
on&#39;t work.<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static int zx2967_wdt_set_timeout(struct watchdog_device *wdd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int timeout)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D watchdog_get_drvdata=
(wdd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (watchdog_timeout_invalid(&amp;wdt<wbr>-&gt;=
wdt_device, timeout)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(wdt-&gt;dev=
, &quot;timeout %d is invalid\n&quot;, timeout);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
</blockquote>
<br></span>
This function is called from the infrastructure. Let&#39;s trust the infras=
tructure<br>
to check the valid range before calling this code.<div><div class=3D"gmail-=
h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdd-&gt;timeout =3D __zx2967_wdt_set_timeout(wd=
t, timeout);<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__zx2967_wdt_stop(wdt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_set_timeout(wdd, wdd-&gt;timeout);<b=
r>
</blockquote>
<br></div></div>
This seems inconsistent. First, the watchdog should not already be<br>
started when this function is called. Second, if it is in fact necessary<br=
>
to stop the watchdog before updating its timeout, you might want to<br>
consider stopping it in the set_timeout function, because that<br>
function _will_ be called if the timeout is updated while the<br>
watchdog is running.<div><div class=3D"gmail-h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.firmware_version =3D=C2=A0 =C2=A0 =C2=A00,<br>
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
+static void zx2967_wdt_fix_sysdown(struct zx2967_wdt *wdt)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__zx2967_wdt_stop(wdt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__zx2967_wdt_set_timeout(wdt, 15);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__zx2967_wdt_start(wdt);<br>
+}<br>
</blockquote>
<br></div></div>
I am really not at all in favor of this code. It force-sets a watchdog<br>
to 15 seconds later, if it was enabled or not.<br>
<br>
I don&#39;t necessarily oppose the idea in general, but it would have to be=
<br>
configurable and part of the infrastructure.<div><div class=3D"gmail-h5"><b=
r></div></div></blockquote><div>I agree you all. In fact, these codes imple=
ment the policy witch is part of products, and don&#39;t necessarily place =
them here.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div><div class=3D"gmail-h5">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+static int zx2967_wdt_notify_sys(struct notifier_block *this,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long code, void *unused)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D container_of(this, s=
truct zx2967_wdt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0reboot_handler);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;flags |=3D ZX2967_WDT_FLAG_REBOOT_MON;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (code) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case SYS_HALT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case SYS_POWER_OFF:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case SYS_RESTART:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_fix_sysd=
own(wdt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int zx2967_wdt_restart(struct notifier_block *this,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long mode, void *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt =3D container_of(this, struct zx2967_wdt, r=
estart_handler);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_stop(&amp;wdt-&gt;wdt_dev<wbr>ice);<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_LOAD_REG, 0x8=
0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_refresh(wdt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_writel(wdt, ZX2967_WDT_START_REG, ZX=
2967_WDT_START_EN);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_start(&amp;wdt-&gt;wdt_de<wbr>vice);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* wait for reset*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(500);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return NOTIFY_DONE;<br>
+}<br>
+<br>
+static void zx2967_wdt_reset_sysctrl(struc<wbr>t device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *regmap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int offset, mask, config;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct of_phandle_args out_args;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D of_parse_phandle_with_fixed_ar<wbr>gs(d=
ev-&gt;of_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;zte,wdt-reset-sysctrl&quot;, 3, 0, &amp;out_args);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot=
;failed to parse zte,wdt-reset-sysctrl&quot;);<br>
</blockquote>
<br></div></div>
Why this message ? The property is optional. There is no &quot;failure&quot=
;.<br>
<br>
Repeating the information in the devicetree description:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 zte,wdt-reset-sysctrl : Directs how to reset sy=
stem by the watchdog.<br>
<br>
Given the context, and the provided implementation, I can only assume that<=
br>
this is supposed to mean which action shall be taken when the watchdog trig=
gers,<br>
and that the bit mask provided is supposed to configure that action. If so,=
<br>
that should be explained in the devicetree description, and not be hidden<b=
r>
in magic register values.<span class=3D"gmail-"><br>
<br></span></blockquote><div>The devicetree description is ok.<br>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-"=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D out_args.args[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0config =3D out_args.args[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D out_args.args[2];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regmap =3D syscon_node_to_regmap(<a href=3D"htt=
p://out_args.np" rel=3D"noreferrer" target=3D"_blank">out_args<wbr>.np</a>)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(regmap))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regmap_update_bits(regmap, offset, mask, config=
);<br>
</blockquote>
<br>
<br></span>
I don&#39;t really see the value of the local variables.<br>
<br></blockquote><div>Are you sure? I add the  local variables<span class=
=3D"gmail-"> </span>in V3.<br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0of_node_put(np);<br>
</blockquote>
<br>
I don&#39;t really see where np is set to anything but NULL.<span class=3D"=
gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static int zx2967_wdt_probe(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
</blockquote>
<br></span>
Unnecessary initialization.<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct reset_control *rstc;<br>
</blockquote>
<br></span>
No empty lines between variable declarations, please.<span class=3D"gmail-"=
><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D &amp;pdev-&gt;dev;<br>
</blockquote>
<br></span>
Can be initialized above.<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt =3D devm_kzalloc(dev, sizeof(*wdt), GFP_KER=
NEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, wdt);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;dev =3D dev;<br>
</blockquote>
<br></span>
This is only used by an error message in the set_timeout function,<br>
which is unnecessary.<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;reboot_handler.notifier_<wbr>call =3D z=
x2967_wdt_notify_sys;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0register_reboot_notifier(&amp;<wbr>wdt-&gt;rebo=
ot_handler);<br>
</blockquote>
<br></span>
Without ever unregistering it ? Did you try to unload the driver and reboot=
 ?<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_set_rate(wdt-&gt;clock, 32768);<br>
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
</blockquote>
<br></span>
There is this reset, and the reset in reset_sysctrl above.<br>
Are they both necessary ?<span class=3D"gmail-"><br>
<br></span></blockquote><div>Here, we reset watchdog itself, but reset_sysc=
trl is used to reset system.<br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><span class=3D"gmail-">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_set_drvdata(&amp;wdt-&gt;wd<wbr>t_devi=
ce, wdt);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_init_timeout(&amp;wdt-&gt;w<wbr>dt_dev=
ice,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ZX2967_WDT_DEFAULT_TIMEOUT, dev);<br>
</blockquote>
<br></span>
What is the purpose of this call ? It sets the timeout to the default timeo=
ut,<br>
which is already set, and it does not use the value from devicetree since t=
he<br>
value passed is !=3D 0.<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_set_nowayout(&amp;wdt-&gt;w<wbr>dt_dev=
ice, WATCHDOG_NOWAYOUT);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_stop(&amp;wdt-&gt;wdt_dev<wbr>ice);<=
br>
</blockquote>
<br></span>
The watchdog was reset twice above. Is this call really necessary ?<span cl=
ass=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D watchdog_register_device(&amp;wdt-<wbr>=
&gt;wdt_device);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail_register;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;restart_handler.<wbr>notifier_call =3D =
zx2967_wdt_restart;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0wdt-&gt;restart_handler.priority =3D 128;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D register_restart_handler(&amp;wdt-<wbr>=
&gt;restart_handler);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
cannot register restart handler, %d\n&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail_restart;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
</blockquote></span>
Why not use the infrastructure ?<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot;watchdog enabled (timeout=
=3D%d sec, nowayout=3D%d)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wdt-&gt;wdt_device=
.timeout, WATCHDOG_NOWAYOUT);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+fail_get_reset_control:<br>
+fail_restart:<br>
</blockquote>
<br></span>
Please no double labels to the same code.<span class=3D"gmail-"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_unregister_device(&amp;w<wbr>dt-&gt;wd=
t_device);<br>
+fail_register:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(wdt-&gt;cl<wbr>ock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static int zx2967_wdt_remove(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D platform_get_drvdata=
(pdev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unregister_restart_handler(&amp;w<wbr>dt-&gt;re=
start_handler);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog_unregister_device(&amp;w<wbr>dt-&gt;wd=
t_device);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(wdt-&gt;cl<wbr>ock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static void zx2967_wdt_shutdown(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct zx2967_wdt *wdt =3D platform_get_drvdata=
(pdev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(wdt-&gt;flags &amp; ZX2967_WDT_FLAG_REBOO=
T_MON))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zx2967_wdt_stop(&am=
p;wdt-&gt;wdt_dev<wbr>ice);<br>
</blockquote>
<br></span>
As mentioned before, the whole reboot handling is highly unusual.<br>
<br>
I don&#39;t really like the idea of bypassing the infrastructure<br>
(such as watchdog_stop_on_reboot()) for driver specific special behavior.<b=
r>
If such behavior is useful, it should be useful for all watchdog drivers,<b=
r>
and be defined in the infrastructure.<div class=3D"gmail-HOEnZb"><div class=
=3D"gmail-h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.shutdown=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D zx2967_=
wdt_shutdown,<br>
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

--001a1140b0fa15ca260546aa2403--
