Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <55637A6D.3080403@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>
	<1432548193-19569-6-git-send-email-fu.wei@linaro.org>
	<55637A6D.3080403@roeck-us.net>
Date: Fri, 29 May 2015 17:11:13 +0800
Message-ID: <CADyBb7t_OC0FwoCeOr-umZhjTMxXZ65g7U8Ca+SUgmiWwjvm2w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,
Great thanks,  feedback inline

On 26 May 2015 at 03:39, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/25/2015 03:03 AM, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This driver bases on linux kernel watchdog framework, and
>> use "pretimeout" in the framework. It supports getting timeout and
>> pretimeout from parameter and FDT at the driver init stage.
>> In first timeout, the interrupt routine run panic to save
>> system context.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>
>
> Comments inline.
>
> Thanks,
> Guenter
>
>
>>   drivers/watchdog/Kconfig     |  11 +
>>   drivers/watchdog/Makefile    |   1 +
>>   drivers/watchdog/sbsa_gwdt.c | 474
>> +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 486 insertions(+)
>>   create mode 100644 drivers/watchdog/sbsa_gwdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index e5e7c55..554f18a 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -152,6 +152,17 @@ config ARM_SP805_WATCHDOG
>>           ARM Primecell SP805 Watchdog timer. This will reboot your system
>> when
>>           the timeout is reached.
>>
>> +config ARM_SBSA_WATCHDOG
>> +       tristate "ARM SBSA Generic Watchdog"
>> +       depends on ARM64
>> +       depends on ARM_ARCH_TIMER
>> +       select WATCHDOG_CORE
>> +       help
>> +         ARM SBSA Generic Watchdog. This watchdog has two Watchdog
>> timeouts.
>> +         The first timeout will trigger a panic; the second timeout will
>> +         trigger a system reset.
>> +         More details: ARM DEN0029B - Server Base System Architecture
>> (SBSA)
>> +
>>   config AT91RM9200_WATCHDOG
>>         tristate "AT91RM9200 watchdog"
>>         depends on SOC_AT91RM9200 && MFD_SYSCON
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 5c19294..471f1b7c 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
>>
>>   # ARM Architecture
>>   obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
>> +obj-$(CONFIG_ARM_SBSA_WATCHDOG) += sbsa_gwdt.o
>>   obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
>>   obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
>>   obj-$(CONFIG_CADENCE_WATCHDOG) += cadence_wdt.o
>> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
>> new file mode 100644
>> index 0000000..0d1aff1
>> --- /dev/null
>> +++ b/drivers/watchdog/sbsa_gwdt.c
>> @@ -0,0 +1,474 @@
>> +/*
>> + * SBSA(Server Base System Architecture) Generic Watchdog driver
>> + *
>> + * Copyright (c) 2015, Linaro Ltd.
>> + * Author: Fu Wei <fu.wei@linaro.org>
>> + *         Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License 2 as published
>> + * by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * Note: This SBSA Generic watchdog driver is compatible with
>> + *       the pretimeout concept of Linux kernel.
>> + *       The timeout and pretimeout are set by the different REGs.
>> + *       The first watch period is set by writing WCV directly,
>> + *       that can support more than 10s timeout at the maximum
>> + *       system counter frequency.
>> + *       The second watch period is set by WOR(32bit) which will be
>> loaded
>> + *       automatically by hardware, when WS0 is triggered.
>> + *       This gives a maximum watch period of around 10s at the maximum
>> + *       system counter frequency.
>> + *       The System Counter shall run at maximum of 400MHz.
>> + *       More details: ARM DEN0029B - Server Base System Architecture
>> (SBSA)
>> + *
>> + * Kernel/API:                         P---------| pretimeout
>> + *               |-------------------------------T timeout
>> + * SBSA GWDT:                          P--WOR---WS1 pretimeout
>> + *               |-------WCV----------WS0~~~~~~~~T timeout
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/watchdog.h>
>> +#include <asm/arch_timer.h>
>> +
>> +/* SBSA Generic Watchdog register definitions */
>> +/* refresh frame */
>> +#define SBSA_GWDT_WRR                          0x000
>> +
>> +/* control frame */
>> +#define SBSA_GWDT_WCS                          0x000
>> +#define SBSA_GWDT_WOR                          0x008
>> +#define SBSA_GWDT_WCV_LO                       0x010
>> +#define SBSA_GWDT_WCV_HI                       0x014
>> +
>> +/* refresh/control frame */
>> +#define SBSA_GWDT_W_IIDR                       0xfcc
>> +#define SBSA_GWDT_IDR                          0xfd0
>> +
>> +/* Watchdog Control and Status Register */
>> +#define SBSA_GWDT_WCS_EN                       BIT(0)
>> +#define SBSA_GWDT_WCS_WS0                      BIT(1)
>> +#define SBSA_GWDT_WCS_WS1                      BIT(2)
>> +
>> +/**
>> + * struct sbsa_gwdt - Internal representation of the SBSA GWDT
>> + * @wdd:               kernel watchdog_device structure
>> + * @clk:               store the System Counter clock frequency, in Hz.
>> + * @refresh_base:      Virtual address of the watchdog refresh frame
>> + * @control_base:      Virtual address of the watchdog control frame
>> + */
>> +struct sbsa_gwdt {
>> +       struct watchdog_device  wdd;
>> +       u32                     clk;
>> +       void __iomem            *refresh_base;
>> +       void __iomem            *control_base;
>> +};
>> +
>> +#define to_sbsa_gwdt(e) container_of(e, struct sbsa_gwdt, wdd)
>> +
>> +#define DEFAULT_TIMEOUT                10 /* seconds, the 1st + 2nd watch
>> periods*/
>
>
> That is a bit low for a default. Is that on purpose ?
> Most drivers use 30 or 60 seconds.

That is not on purpose. will fixed them :
#define DEFAULT_TIMEOUT 30 /* seconds, the 1st + 2nd watch periods*/
#define DEFAULT_PRETIMEOUT 10 /* seconds, the 2nd watch period*/

>
>> +#define DEFAULT_PRETIMEOUT     5  /* seconds, the 2nd watch period*/
>> +
>> +static unsigned int timeout_param;
>> +module_param(timeout_param, uint, 0);
>> +MODULE_PARM_DESC(timeout_param,
>> +                "Watchdog timeout in seconds. (>=0, default="
>> +                __MODULE_STRING(DEFAULT_TIMEOUT) ")");
>> +
>
> Why _param in the module parameter names ? Seems to be redundant.

sorry, I shouldn't add _param , fixed it

>
>> +static unsigned int max_timeout_param = UINT_MAX;
>> +module_param(max_timeout_param, uint, 0);
>> +MODULE_PARM_DESC(max_timeout_param,
>> +                "Watchdog max timeout in seconds. (>=0, default="
>> +                __MODULE_STRING(UINT_MAX) ")");
>> +
>
>
> Why do we want or need this parameter and max_pretimeout ? Those
> are determined by the hardware.

Sorry, I thought we can also allow user setup a max value when insmod
the module or by boot cmdline. but I was wrong, have deleted them.

>
>
>> +static unsigned int pretimeout_param;
>> +module_param(pretimeout_param, uint, 0);
>> +MODULE_PARM_DESC(pretimeout_param,
>> +                "Watchdog pretimeout in seconds. (>=0, default="
>> +                __MODULE_STRING(DEFAULT_PRETIMEOUT) ")");
>> +
>> +static unsigned int max_pretimeout_param = U32_MAX;
>> +module_param(max_pretimeout_param, uint, 0);
>> +MODULE_PARM_DESC(max_pretimeout_param,
>> +                "Watchdog max pretimeout in seconds. (>=0, default="
>> +                __MODULE_STRING(U32_MAX) ")");
>> +
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, S_IRUGO);
>> +MODULE_PARM_DESC(nowayout,
>> +                "Watchdog cannot be stopped once started (default="
>> +                __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>> +/*
>> + * help functions for accessing 32bit registers of SBSA Generic Watchdog
>> + */
>> +static void sbsa_gwdt_cf_write(unsigned int reg, u32 val,
>> +                              struct watchdog_device *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +       writel_relaxed(val, gwdt->control_base + reg);
>> +}
>> +
>> +static void sbsa_gwdt_rf_write(unsigned int reg, u32 val,
>> +                              struct watchdog_device *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +       writel_relaxed(val, gwdt->refresh_base + reg);
>> +}
>> +
>> +static u32 sbsa_gwdt_cf_read(unsigned int reg, struct watchdog_device
>> *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +       return readl_relaxed(gwdt->control_base + reg);
>> +}
>> +
>> +/*
>> + * help functions for accessing 64bit WCV register
>> + */
>> +static u64 sbsa_gwdt_get_wcv(struct watchdog_device *wdd)
>> +{
>> +       u32 wcv_lo, wcv_hi;
>> +
>> +       do {
>> +               wcv_hi = sbsa_gwdt_cf_read(SBSA_GWDT_WCV_HI, wdd);
>> +               wcv_lo = sbsa_gwdt_cf_read(SBSA_GWDT_WCV_LO, wdd);
>> +       } while (wcv_hi != sbsa_gwdt_cf_read(SBSA_GWDT_WCV_HI, wdd));
>> +
>> +       return (((u64)wcv_hi << 32) | wcv_lo);
>> +}
>> +
>> +static void sbsa_gwdt_set_wcv(struct watchdog_device *wdd, u64 value)
>> +{
>> +       u32 wcv_lo, wcv_hi;
>> +
>> +       wcv_lo = value & U32_MAX;
>> +       wcv_hi = (value >> 32) & U32_MAX;
>> +
>> +       sbsa_gwdt_cf_write(SBSA_GWDT_WCV_HI, wcv_hi, wdd);
>> +       sbsa_gwdt_cf_write(SBSA_GWDT_WCV_LO, wcv_lo, wdd);
>> +}
>> +
>> +static void reload_timeout_to_wcv(struct watchdog_device *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +       u64 wcv;
>> +
>> +       wcv = arch_counter_get_cntvct() +
>> +               (u64)(wdd->timeout - wdd->pretimeout) * gwdt->clk;
>> +
>> +       sbsa_gwdt_set_wcv(wdd, wcv);
>> +}
>> +
>> +/*
>> + * Use the following function to update the timeout limits
>> + * after updating pretimeout
>> + */
>> +static void sbsa_gwdt_update_limits(struct watchdog_device *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +       u64 first_period_max = U64_MAX;
>> +
>> +       do_div(first_period_max, gwdt->clk);
>> +
>> +       wdd->min_timeout = wdd->pretimeout + 1;
>> +       wdd->max_timeout = min((uint)(wdd->pretimeout + first_period_max),
>> +                              wdd->max_timeout);
>> +}
>> +
>
>
> After understanding the watchdog a bit better now, I think you should drop
> those updates and set
>         min_timeout = 1
>         max_timeout = min(UINT_MAX, U64_MAX / clk)
>         min_pretimeout = 0
>         max_pretimeout = U32_MAX / clk
>
> and then ensure that pretimeout < timeout at runtime (if possible in
> the infrastructure code).
>
> Even at maximum clock rate, max_timeout is so large that anything else
> is really overkill.

you are right, fixed it, thanks

>
>> +static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>> +                                unsigned int timeout)
>> +{
>> +       wdd->timeout = timeout;
>> +
>> +       return 0;
>> +}
>> +
>> +static int sbsa_gwdt_set_pretimeout(struct watchdog_device *wdd,
>> +                                   unsigned int pretimeout)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +       u32 wor;
>> +
>> +       wdd->pretimeout = pretimeout;
>> +       sbsa_gwdt_update_limits(wdd);
>> +
>> +       if (!pretimeout)
>> +               /* gives sbsa_gwdt_start a chance to setup timeout */
>> +               wor = gwdt->clk;
>> +       else
>> +               wor = pretimeout * gwdt->clk;
>> +
>
>
> So in practice you always have a pretimeout of at least one second,
> correct ? That kind of violates the ABI, which says that the pretimeout
> should be disabled if set to 0. Is there anything we can do about that ?
>
> What exactly happens if WOR = 0 ? Doesn't that just mean that the second
> timeout will happen immediately, and isn't that what we would want if
> pretimeout = 0

Accroding to SBSA, in theory,
if WOR == 0, once we write WRR(refresh), we will get WS0 and WS1 immediately .
that means timeout == 0.

So I will add more comment here to explain this.

>
>> +       /* refresh the WOR, that will cause an explicit watchdog refresh
>> */
>
>
> Except that we use wcv which needs a manual refresh, so this is a bit
> misleading, isn't it ?

if we setup  wcv manually, we maybe don't need a manual refresh.
I will test it later.

>
>
>> +       sbsa_gwdt_cf_write(SBSA_GWDT_WOR, wor, wdd);
>> +
>> +       return 0;
>> +}
>> +
>> +static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +       u64 timeleft = sbsa_gwdt_get_wcv(wdd) - arch_counter_get_cntvct();
>> +
>> +       do_div(timeleft, gwdt->clk);
>> +
>> +       return timeleft;
>> +}
>> +
>> +static int sbsa_gwdt_start(struct watchdog_device *wdd)
>> +{
>> +       /* Force refresh */
>> +       sbsa_gwdt_rf_write(SBSA_GWDT_WRR, 0xc0ffee, wdd);
>> +       /* writing WCS will cause an explicit watchdog refresh */
>> +       sbsa_gwdt_cf_write(SBSA_GWDT_WCS, SBSA_GWDT_WCS_EN, wdd);
>> +
>> +       reload_timeout_to_wcv(wdd);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sbsa_gwdt_stop(struct watchdog_device *wdd)
>> +{
>> +       /* Force refresh */
>> +       sbsa_gwdt_rf_write(SBSA_GWDT_WRR, 0xc0ffee, wdd);
>> +       /* writing WCS will cause an explicit watchdog refresh */
>> +       sbsa_gwdt_cf_write(SBSA_GWDT_WCS, 0, wdd);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
>> +{
>> +       /*
>> +        * Writing WRR for an explicit watchdog refresh
>> +        * You can write anyting(like 0xc0ffee)
>> +        */
>> +       sbsa_gwdt_rf_write(SBSA_GWDT_WRR, 0xc0ffee, wdd);
>
>
> Should that happen after writing wcv ?

no, if so, WOR + current_time will be loaded into wcv. I put this
before writing wcv on purpose.
maybe we can just update wcv without a force refresh.

will test it later


>
>
>> +
>> +       reload_timeout_to_wcv(wdd);
>> +
>> +       return 0;
>> +}
>> +
>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>> +{
>> +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>> +       struct watchdog_device *wdd = &gwdt->wdd;
>> +       u32 status;
>> +
>> +       status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
>> +
>> +       if (status & SBSA_GWDT_WCS_WS0)
>> +               panic("SBSA Watchdog pre-timeout");
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static struct watchdog_info sbsa_gwdt_info = {
>> +       .identity       = "SBSA Generic Watchdog",
>> +       .options        = WDIOF_SETTIMEOUT |
>> +                         WDIOF_KEEPALIVEPING |
>> +                         WDIOF_MAGICCLOSE |
>> +                         WDIOF_PRETIMEOUT |
>> +                         WDIOF_CARDRESET,
>> +};
>> +
>> +static struct watchdog_ops sbsa_gwdt_ops = {
>> +       .owner          = THIS_MODULE,
>> +       .start          = sbsa_gwdt_start,
>> +       .stop           = sbsa_gwdt_stop,
>> +       .ping           = sbsa_gwdt_keepalive,
>> +       .set_timeout    = sbsa_gwdt_set_timeout,
>> +       .set_pretimeout = sbsa_gwdt_set_pretimeout,
>> +       .get_timeleft   = sbsa_gwdt_get_timeleft,
>> +};
>> +
>> +static int sbsa_gwdt_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct sbsa_gwdt *gwdt;
>> +       struct watchdog_device *wdd;
>> +       struct resource *res;
>> +       void *rf_base, *cf_base;
>> +       int irq;
>> +       u32 clk, status;
>> +       int ret = 0;
>> +       u64 first_period_max = U64_MAX;
>> +
>> +       /*
>> +        * Get the frequency of system counter from
>> +        * the cp15 interface of ARM Generic timer
>> +        */
>> +       clk = arch_timer_get_cntfrq();
>
>
> That can not return 0, presumably, from looking into its implementation.
> And the system should panic if it is ever 0.
>
>> +       if (!clk) {
>
>
> Given that, I don't think this check is necessary.

yes, you are right , I have got your point, and improved it .

>
>
>> +               dev_err(dev, "System Counter frequency not available\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
>> +       if (!gwdt)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "refresh");
>> +       rf_base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(rf_base))
>> +               return PTR_ERR(rf_base);
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "control");
>> +       cf_base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(cf_base))
>> +               return PTR_ERR(cf_base);
>> +
>> +       irq = platform_get_irq_byname(pdev, "ws0");
>> +       if (irq < 0) {
>> +               dev_err(dev, "unable to get ws0 interrupt.\n");
>> +               return irq;
>> +       }
>> +
>> +       gwdt->refresh_base = rf_base;
>> +       gwdt->control_base = cf_base;
>> +       gwdt->clk = clk;
>> +
>> +       platform_set_drvdata(pdev, gwdt);
>> +
>> +       wdd = &gwdt->wdd;
>> +       wdd->parent = dev;
>> +       wdd->info = &sbsa_gwdt_info;
>> +       wdd->ops = &sbsa_gwdt_ops;
>> +       watchdog_set_drvdata(wdd, gwdt);
>> +       watchdog_set_nowayout(wdd, nowayout);
>> +
>> +       status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
>> +       if (status & SBSA_GWDT_WCS_WS1) {
>> +               dev_warn(dev, "System reset by WDT(WCS: %x, WCV: %llx)\n",
>> +                        status, sbsa_gwdt_get_wcv(wdd));
>
>
> Does this message (specifically the WCS / WCV values) have any
> useful meaning for the user ?

I think so, according to SBSA spec:
If WS0 is asserted and a timeout refresh occurs then the following must occur:
    If the system is compliant to SBSA level 2 or higher the compare
value must retain its current value. This means that the compare value
records the time that WS1 is asserted.

So, I think WCV can log the time when system reset by WDT, that may
help user figure out the problem. but WCS can be delete I think.


>
>> +               wdd->bootstatus |= WDIOF_CARDRESET;
>> +       }
>> +       /* Check if watchdog is already enabled */
>> +       if (status & SBSA_GWDT_WCS_EN) {
>> +               dev_warn(dev, "already enabled! WCS:0x%x\n", status);
>> +               sbsa_gwdt_keepalive(wdd);
>
>
> You have not configured wdd->timeout and wdd->pretimeout here,
> yet the function calls reload_timeout_to_wcv which needs it.

Ah, sorry, that is a bug, have reordered the code, Thanks

>
>> +       }
>> +
>> +       wdd->min_pretimeout = 0;
>> +       wdd->max_pretimeout = min(U32_MAX / clk, max_pretimeout_param);
>> +       wdd->min_timeout = 1;
>> +       do_div(first_period_max, clk);
>> +       wdd->max_timeout = min((uint)(wdd->pretimeout + first_period_max),
>> +                              max_timeout_param);
>> +
>> +       wdd->pretimeout = DEFAULT_PRETIMEOUT;
>> +       wdd->timeout = DEFAULT_TIMEOUT;
>> +       watchdog_init_timeouts(wdd, pretimeout_param, timeout_param, dev);
>> +       /* update pretimeout to WOR */
>> +       sbsa_gwdt_cf_write(SBSA_GWDT_WOR, wdd->pretimeout * clk, wdd);
>
>
> This is interesting because you set WOR to 0 here if pretimeout is 0.
> Yet, when pretimeout is updated later on, you always set it to at least
> one second. Any reason for doing this differently ?
>
> If the above works, and presumably you have tested it, I don't see why
> it would be necessary to set WOR to a value larger than 0 when updating
> pretimeout.

Ah I should tested more in extreme case, but here, I can use
sbsa_gwdt_set_pretimeout directly.


>
>> +
>> +       ret = devm_request_irq(dev, irq, sbsa_gwdt_interrupt, IRQF_TIMER,
>> +                              pdev->name, gwdt);
>> +       if (ret) {
>> +               dev_err(dev, "unable to request IRQ %d\n", irq);
>> +               return ret;
>> +       }
>> +
>> +       ret = watchdog_register_device(wdd);
>> +       if (ret)
>> +               return ret;
>> +
>> +       dev_info(dev, "Initialized with %ds timeout, %ds pretimeout @
>> %uHz\n",
>> +                wdd->timeout, wdd->pretimeout, gwdt->clk);
>
>
> 400000Hz reads a bit odd. How about a space between the number and Hz ?

np, fixed it , thanks :-)

>
>> +
>> +       return 0;
>> +}
>> +
>> +static void sbsa_gwdt_shutdown(struct platform_device *pdev)
>> +{
>> +       struct sbsa_gwdt *gwdt = platform_get_drvdata(pdev);
>> +
>> +       sbsa_gwdt_stop(&gwdt->wdd);
>> +}
>> +
>> +static int sbsa_gwdt_remove(struct platform_device *pdev)
>> +{
>> +       struct sbsa_gwdt *gwdt = platform_get_drvdata(pdev);
>> +       int ret = 0;
>> +
>> +       if (!nowayout)
>> +               ret = sbsa_gwdt_stop(&gwdt->wdd);
>> +
>
> I don't think you should do anything here. The driver can only be removed
> if closed, and it that case the watchdog will already have been stopped,
> or if nowayout was set it won't be stopped. Either case it is already in
> the state we want it to be in.

Sorry, I should delete it. Fixed

>
>
>> +       watchdog_unregister_device(&gwdt->wdd);
>> +
>> +       return ret;
>> +}
>> +
>> +/* Disable watchdog if it is active during suspend */
>> +static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
>> +{
>> +       struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>> +
>> +       if (watchdog_active(&gwdt->wdd))
>> +               sbsa_gwdt_stop(&gwdt->wdd);
>> +
>> +       return 0;
>> +}
>> +
>> +/* Enable watchdog and configure it if necessary */
>> +static int __maybe_unused sbsa_gwdt_resume(struct device *dev)
>> +{
>> +       struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>> +
>> +       if (watchdog_active(&gwdt->wdd))
>> +               sbsa_gwdt_start(&gwdt->wdd);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct dev_pm_ops sbsa_gwdt_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(sbsa_gwdt_suspend, sbsa_gwdt_resume)
>> +};
>> +
>> +static const struct of_device_id sbsa_gwdt_of_match[] = {
>> +       { .compatible = "arm,sbsa-gwdt", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sbsa_gwdt_of_match);
>> +
>> +static const struct platform_device_id sbsa_gwdt_pdev_match[] = {
>> +       { .name = "sbsa-gwdt", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(platform, sbsa_gwdt_pdev_match);
>> +
>> +static struct platform_driver sbsa_gwdt_driver = {
>> +       .driver = {
>> +               .name = "sbsa-gwdt",
>> +               .pm = &sbsa_gwdt_pm_ops,
>> +               .of_match_table = sbsa_gwdt_of_match,
>> +       },
>> +       .probe = sbsa_gwdt_probe,
>> +       .remove = sbsa_gwdt_remove,
>> +       .shutdown = sbsa_gwdt_shutdown,
>> +       .id_table = sbsa_gwdt_pdev_match,
>> +};
>> +
>> +module_platform_driver(sbsa_gwdt_driver);
>> +
>> +MODULE_DESCRIPTION("SBSA Generic Watchdog Driver");
>> +MODULE_VERSION("v1.0");
>> +MODULE_AUTHOR("Fu Wei <fu.wei@linaro.org>");
>> +MODULE_AUTHOR("Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>");
>> +MODULE_LICENSE("GPL v2");
>>
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
