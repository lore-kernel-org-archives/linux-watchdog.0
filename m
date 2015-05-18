Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33051 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbERRia (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 13:38:30 -0400
Received: by obblk2 with SMTP id lk2so134493648obb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2015 10:38:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555679DE.4080502@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1431689090-3125-1-git-send-email-fu.wei@linaro.org>
	<1431689090-3125-2-git-send-email-fu.wei@linaro.org>
	<555679DE.4080502@roeck-us.net>
Date: Tue, 19 May 2015 01:38:29 +0800
Message-ID: <CADyBb7vtDfJEtA+mphuHEDf=SyANVdHcDunpuJw+vuVXfxEDsQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] Watchdog: introdouce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Grenter,

Great thanks for your review,

On 16 May 2015 at 06:57, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/15/2015 04:24 AM, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>>      (1)Use linux kernel watchdog framework
>>      (2)Work with FDT on ARM64
>>      (3)Use "pretimeout" in watchdog framework
>>      (4)In first timeout(WS0), do panic to save system context
>>      (5)support geting timeout and pretimeout from
>
>
> getting
>
>>         parameter and FDT at the driver init stage.
>
>
> Subject: s/introdouce/introduce/
>
> Please find a better description.
>
> Also, please provide revisions numbers for your patch sets, and
> list the changes from one revision to the next.

sorry for those typo, I have fixed them,
and will provide revisions numbers and changelog in next patch

>
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>   drivers/watchdog/Kconfig     |  10 +
>>   drivers/watchdog/Makefile    |   1 +
>>   drivers/watchdog/sbsa_gwdt.c | 553
>> +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 564 insertions(+)
>>   create mode 100644 drivers/watchdog/sbsa_gwdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index e5e7c55..1e1bc8b 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -152,6 +152,16 @@ config ARM_SP805_WATCHDOG
>>           ARM Primecell SP805 Watchdog timer. This will reboot your system
>> when
>>           the timeout is reached.
>>
>> +config ARM_SBSA_WATCHDOG
>> +       tristate "ARM SBSA Generic Watchdog"
>> +       depends on ARM || ARM64 || COMPILE_TEST
>> +       select WATCHDOG_CORE
>> +       help
>> +         ARM SBSA Generic Watchdog timer. This has two Watchdog
>> Signal(WS0/WS1),
>
>
> signals
>
>> +         will trigger a warnning interrupt(do panic) in the first
>> timeout(WS0);
>
>
> warning

sorry for these typoes, I have fixed them,


>
>
>> +         will reboot your system when the second timeout(WS1) is reached.
>> +         More details: DEN0029B - Server Base System Architecture (SBSA)
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
>> index 0000000..52838b1
>> --- /dev/null
>> +++ b/drivers/watchdog/sbsa_gwdt.c
>> @@ -0,0 +1,553 @@
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
>> + *       But timeout and pretimeout are set by the different REGs.
>
>
> Why "But" ?

deleted it :-)

>
>> + *       The first watch period is set by writing WCV directly,
>> + *       that can support more than 10s timeout at the maximum
>> + *       system counter frequency.
>> + *       And the second watch period is set by WOR(32bit) which will be
>> loaded
>
>
> s/And the/The/

Thanks,  I have fixed them,

>
>
>> + *       automatically by hardware, when WS0 is triggered.
>> + *       This gives a maximum watch period of around 10s at the maximum
>> + *       system counter frequency.
>> + *       The System Counter shall run at maximum of 400MHz.
>> + *       More details: DEN0029B - Server Base System Architecture (SBSA)
>> + *
>> + * Kernel/API:                         P---------| pretimeout
>> + *               |-------------------------------T timeout
>> + * SBSA GWDT:                          P--WOR---WS1 pretimeout
>> + *               |-------WCV----------WS0~~~~~~~~T timeout
>> + */
>> +
>> +#include <asm/arch_timer.h>
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/io.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/watchdog.h>
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
>> +/* Watchdog Interface Identification Register */
>> +#define SBSA_GWDT_W_IIDR_PID(x)                        ((x >> 20) &
>> 0xfff)
>> +#define SBSA_GWDT_W_IIDR_ARCH_VER(x)           ((x >> 16) & 0xf)
>> +#define SBSA_GWDT_W_IIDR_REV(x)                        ((x >> 12) & 0xf)
>> +#define SBSA_GWDT_W_IIDR_IMPLEMENTER(x)                (x & 0xfff)
>> +#define SBSA_GWDT_W_IIDR_VID_BANK(x)           ((x >> 8) & 0xf)
>> +#define SBSA_GWDT_W_IIDR_VID(x)                        (x & 0x7f)
>> +
>> +/* Watchdog Identification Register */
>> +#define SBSA_GWDT_IDR_W_PIDR2                  0xfe8
>> +#define SBSA_GWDT_IDR_W_PIDR2_ARCH_VER(x)      ((x >> 4) & 0xf)
>> +
>
>
> (x) for all the above macros, please.

Great thanks , my bad , I have fixed them

>
>> +/**
>> + * struct sbsa_gwdt - Internal representation of the SBSA GWDT
>> + * @wdd:               kernel watchdog_device structure
>> + * @clk:               store the System Counter clock frequency, in Hz.
>> + * @refresh_base:      VA of the watchdog refresh frame
>> + * @control_base:      VA of the watchdog control frame
>
>
> Please spell out "Virtual address".

done :-)

>
>> + * @lock:              struct sbsa_gwdt spinlock
>> + * @pm_status_store:   store the PM info of WDT
>> + */
>> +struct sbsa_gwdt {
>> +       struct watchdog_device  wdd;
>> +       u32                     clk;
>> +       void __iomem            *refresh_base;
>> +       void __iomem            *control_base;
>> +#ifdef CONFIG_PM_SLEEP
>> +       spinlock_t              lock;
>> +       u8                      pm_status_store;
>> +#endif
>
>
> Please avoid the #ifdef

I have deleted them , thanks

>
>
>> +};
>> +
>> +#define to_sbsa_gwdt(e) container_of(e, struct sbsa_gwdt, wdd)
>> +
>> +#define DEFAULT_TIMEOUT_WS0    10 /* seconds, the 1st watch period*/
>> +#define DEFAULT_PRETIMEOUT     5 /* seconds, the 2nd watch period*/
>> +
>> +static unsigned int timeout;
>> +module_param(timeout, uint, 0);
>> +MODULE_PARM_DESC(timeout,
>> +                "Watchdog timeout in seconds. (>=0, default="
>> +                __MODULE_STRING(DEFAULT_TIMEOUT_WS0 + DEFAULT_PRETIMEOUT)
>> ")");
>> +
>> +static unsigned int max_timeout = UINT_MAX;
>> +module_param(max_timeout, uint, 0);
>> +MODULE_PARM_DESC(max_timeout,
>> +                "Watchdog max timeout in seconds. (>=0, default="
>> +                __MODULE_STRING(UINT_MAX) ")");
>> +
>> +static unsigned int max_pretimeout = U32_MAX;
>> +module_param(max_pretimeout, uint, 0);
>> +MODULE_PARM_DESC(max_pretimeout,
>> +                "Watchdog max pretimeout in seconds. (>=0, default="
>> +                __MODULE_STRING(U32_MAX) ")");
>> +
>> +static unsigned int pretimeout;
>> +module_param(pretimeout, uint, 0);
>> +MODULE_PARM_DESC(pretimeout,
>> +                "Watchdog pretimeout in seconds. (>=0, default="
>> +                __MODULE_STRING(DEFAULT_PRETIMEOUT) ")");
>> +
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, S_IRUGO);
>> +MODULE_PARM_DESC(nowayout,
>> +                "Watchdog cannot be stopped once started (default="
>> +                __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>> +/*
>> + * Architected system timer support.
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
>> + * help founctions for accessing 64bit WCV register
>> + * mutex_lock must be called prior to calling this function.
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
>> +
>> +       pr_debug("sbsa_gwdt: set WCV to %llu, result: %llu\n",
>> +                value, sbsa_gwdt_get_wcv(wdd));
>
>
> Is this pr_debug still necessary ?

will remove it , Thanks

>
>
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
>> + * Use the following function to set the limit of timeout
>> + * after updating pretimeout
>> + */
>> +static void sbsa_gwdt_set_timeout_limits(struct sbsa_gwdt *gwdt)
>> +{
>> +       unsigned int first_period_max = (U64_MAX / gwdt->clk);
>> +       struct watchdog_device *wdd = &gwdt->wdd;
>> +
>> +       wdd->min_timeout = wdd->pretimeout + 1;
>> +       wdd->max_timeout = min(wdd->pretimeout + first_period_max,
>> max_timeout);
>> +
>> +       pr_debug("sbsa_gwdt: timeout (%u-%u), pretimeout (%u-%u)\n",
>> +                wdd->min_timeout, wdd->max_timeout,
>> +                wdd->min_pretimeout, wdd->max_pretimeout);
>
>
> Is this still necessary ?

will remove it , Thanks

>
>> +}
>> +
>> +static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>> +                                unsigned int timeout)
>> +{
>> +       wdd->timeout = timeout;
>> +
>> +       return 0;
>> +       /* watchdog framework will trigger a ping, after this call */
>
>
> Unnecessary comment.

will remove it , Thanks

>
>> +}
>> +
>> +static int sbsa_gwdt_set_pretimeout(struct watchdog_device *wdd,
>> +                                   unsigned int pretimeout)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +       u32 wor;
>> +
>> +       wdd->pretimeout = pretimeout;
>> +       sbsa_gwdt_set_timeout_limits(gwdt);
>> +
>> +       if (!pretimeout)
>> +               /* gives sbsa_gwdt_start a chance to setup timeout */
>> +               wor = gwdt->clk;
>> +       else
>> +               wor = pretimeout * gwdt->clk;
>> +
>> +       /* refresh the WOR, that will cause an explicit watchdog refresh
>> */
>> +       sbsa_gwdt_cf_write(SBSA_GWDT_WOR, wor, wdd);
>> +
>> +       pr_debug("sbsa_gwdt: set WOR to %x(%us), result: %x\n",
>> +                wor, pretimeout, sbsa_gwdt_cf_read(SBSA_GWDT_WOR, wdd));
>
>
> Is this still necessary ?

will remove it , Thanks

>
>> +
>> +       return 0;
>> +       /* watchdog framework will trigger a ping, after this call */
>
>
> Unnecessary comment.

will remove it , Thanks

>
>> +}
>> +
>> +static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +       u64 timeleft = sbsa_gwdt_get_wcv(wdd) - arch_counter_get_cntvct();
>> +
>> +       return timeleft / gwdt->clk;
>
>
> Will this ever be built on a 32 bit target ? That may cause a link error
> due to the 64 bit divide operation.

yes, you are right, you found a bug,  I have fixed it by do_div().

Great thanks !!

>
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
>> +       pr_debug("sbsa_gwdt: WCS is %x(%s)\n",
>> +                sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd), __func__);
>
>
> Another one. If you think you need to keep those, can you at least use
> dev_dbg ?
> I won't comment on the debug messages further, but I really think that even
> for debug messages this is a bit noisy.

will remove it , Thanks

>
>
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
>> +       pr_debug("sbsa_gwdt: WCS is %x(%s)\n",
>> +                sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd), __func__);
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
>> +
>> +       reload_timeout_to_wcv(wdd);
>> +
>> +       pr_debug("sbsa_gwdt: ping, %us left.\n",
>> sbsa_gwdt_get_timeleft(wdd));
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
>> +       pr_debug("sbsa_gwdt: interrupt routine, WCS@%x\n", status);
>> +
>> +       if (status & SBSA_GWDT_WCS_WS0) {
>> +               pr_debug("sbsa_gwdt WS0: trigger WS1 in %ds!\n",
>> +                        sbsa_gwdt_get_timeleft(wdd));
>> +               panic("SBSA Watchdog pre-timeout");
>> +       }
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
>> +
>> +       struct sbsa_gwdt *gwdt;
>> +       struct watchdog_device *wdd;
>> +
>> +       struct resource *res;
>> +       void *rf_base, *cf_base;
>> +       int irq;
>> +       u32 clk, status, w_iidr;
>> +
>> +       int ret = 0;
>
>
> Please drop the empty lines above.

OK, np, done :-)

>
>> +
>> +       /*
>> +        * Try to determine the frequency from the cp15 interface
>> +        */
>> +       clk = arch_timer_get_cntfrq();
>> +       if (!clk) {
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
>> +       pr_debug("sbsa_gwdt: ioremap %s frame 0x%llx(size: %llu)-->%p.\n",
>> +                res->name, (unsigned long long)res->start,
>> +               (unsigned long long)(res->end - res->start + 1), rf_base);
>
>
> If you think you need to keep those messages, please at least use %pR.

thanks for your suggestion, but I will remove it

>
>
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "control");
>> +       cf_base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(rf_base))
>> +               return PTR_ERR(rf_base);
>> +
>> +       pr_debug("sbsa_gwdt: ioremap %s frame 0x%llx(size: %llu)-->%p.\n",
>> +                res->name, (unsigned long long)res->start,
>> +               (unsigned long long)(res->end - res->start + 1), cf_base);
>> +
>> +       irq = platform_get_irq_byname(pdev, "ws0");
>> +       if (irq < 0) {
>> +               dev_err(dev, "unable to get ws0 interrupt.\n");
>> +               return irq;
>> +       }
>> +
>> +       pr_debug("sbsa_gwdt: ws0 irq %d.\n", irq);
>> +
>> +       gwdt->refresh_base = rf_base;
>> +       gwdt->control_base = cf_base;
>> +       gwdt->clk = clk;
>> +#ifdef CONFIG_PM_SLEEP
>> +       spin_lock_init(&gwdt->lock);
>> +#endif
>> +       platform_set_drvdata(pdev, gwdt);
>> +
>> +       pr_debug("sbsa_gwdt: hw clk: %uHz--> WOR(32bit) max timeout is
>> %us.\n",
>> +                gwdt->clk, U32_MAX / clk);
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
>> +               dev_warn(dev, "System was reseted by WDT(WCS: %x, WCV:
>> %llx)\n",
>
>
> "was reseted" is kind of odd. Can you use just "reset" or maybe "restarted"
> ?

yes, will do , thanks


>
>> +                        status, sbsa_gwdt_get_wcv(wdd));
>> +               wdd->bootstatus |= WDIOF_CARDRESET;
>> +       }
>> +       /* Check if watchdog is already enabled */
>> +       if (status & SBSA_GWDT_WCS_EN) {
>> +               dev_warn(dev, "already enabled!\n");
>> +               sbsa_gwdt_keepalive(wdd);
>> +       }
>> +
>> +       pr_debug("sbsa_gwdt: WCS: %x(%s)\n", status, __func__);
>> +
>> +       wdd->min_pretimeout = 0;
>> +       wdd->max_pretimeout = min(U32_MAX / clk, max_timeout - 1);
>> +       sbsa_gwdt_set_timeout_limits(gwdt);
>> +
>> +       watchdog_init_pretimeout(wdd, pretimeout, dev);
>> +       if (!wdd->pretimeout) {
>> +               wdd->pretimeout = DEFAULT_PRETIMEOUT;
>> +               dev_info(dev, "can't get pretimeout param, set default
>> %us.\n",
>> +                        wdd->pretimeout);
>
>
> Unnecessary message. The pretimeout is printed again below.
>
>> +       }
>> +       sbsa_gwdt_set_pretimeout(wdd, wdd->pretimeout);
>> +
>> +       watchdog_init_timeout(wdd, timeout, dev);
>> +       if (!wdd->timeout) {
>> +               wdd->timeout = wdd->pretimeout + DEFAULT_TIMEOUT_WS0;
>> +               dev_info(dev, "can't get timeout param, set default:
>> %us.\n",
>> +                        wdd->timeout);
>
>
> Same here.
>

yes,  I have removed them.


>> +       }
>> +       sbsa_gwdt_set_timeout(wdd, wdd->timeout);
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
>> +       /* get device information from control frame and display */
>> +       w_iidr = sbsa_gwdt_cf_read(SBSA_GWDT_W_IIDR, &gwdt->wdd);
>> +       dev_info(dev, "PID:%u(JEP106 %u-%u), Arch v%u Rev %u.",
>> +                SBSA_GWDT_W_IIDR_PID(w_iidr),
>> +                SBSA_GWDT_W_IIDR_VID_BANK(w_iidr),
>> +                SBSA_GWDT_W_IIDR_VID(w_iidr),
>> +                SBSA_GWDT_W_IIDR_ARCH_VER(w_iidr),
>> +                SBSA_GWDT_W_IIDR_REV(w_iidr));
>
>
> Is this valuable information ?

not too much value, just tell you the hw info,  should I remove it?

>
>
>> +
>> +       dev_info(dev, "Initialized with %ds timeout, %ds pretimeout @
>> %uHz\n",
>> +                wdd->timeout, wdd->pretimeout, gwdt->clk);
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
>> +       watchdog_unregister_device(&gwdt->wdd);
>> +
>> +       return ret;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>
>
> You don't need the #ifdef if you use __maybe_unused with the function
> declarations.

yes, doing this way now

>
>> +/* Disable watchdog if it is active during suspend */
>> +static int sbsa_gwdt_suspend(struct device *dev)
>> +{
>> +       struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>> +       struct watchdog_device *wdd = &gwdt->wdd;
>> +
>> +       spin_lock(&gwdt->lock);
>> +       gwdt->pm_status_store = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
>> +
>> +       if (gwdt->pm_status_store & SBSA_GWDT_WCS_EN)
>> +               sbsa_gwdt_stop(wdd);
>> +       spin_unlock(&gwdt->lock);
>
>
> Wonder what this lock is protecting against. Can you explain ?
> I would assume that suspend and resume are mutually exclusive
> and don't require locking against each other.
>
>> +
>> +       return 0;
>> +}
>> +
>> +/* Enable watchdog and configure it if necessary */
>> +static int sbsa_gwdt_resume(struct device *dev)
>> +{
>> +       struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>> +       struct watchdog_device *wdd = &gwdt->wdd;
>> +
>> +       spin_lock(&gwdt->lock);
>> +       if (gwdt->pm_status_store & SBSA_GWDT_WCS_EN)
>> +               sbsa_gwdt_start(wdd);
>> +       else
>> +               sbsa_gwdt_stop(wdd);
>
>
> What is the stop here for ?

Thanks ,  I have improved this part. :-)


>
>
>> +       spin_unlock(&gwdt->lock);
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>> +static const struct of_device_id sbsa_gwdt_of_match[] = {
>> +       { .compatible = "arm,sbsa-gwdt", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sbsa_gwdt_of_match);
>> +
>> +static const struct dev_pm_ops sbsa_gwdt_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(sbsa_gwdt_suspend, sbsa_gwdt_resume)
>> +};
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
>> +};
>> +
>> +module_platform_driver(sbsa_gwdt_driver);
>> +
>> +MODULE_DESCRIPTION("SBSA Generic Watchdog Driver");
>> +MODULE_AUTHOR("Fu Wei <fu.wei@linaro.org>");
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
