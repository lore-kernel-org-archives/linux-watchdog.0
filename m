Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Oct 2017 15:04:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Subject: Re: [v8,4/5] watchdog: Add RAVE SP watchdog driver
Message-ID: <20171023220454.GA6066@roeck-us.net>
References: <20171018170136.12347-5-andrew.smirnov@gmail.com>
 <20171021164730.GA20402@roeck-us.net>
 <CAHQ1cqGOL+qcN1qY0iOjE41HaA1Yako7ViuJxh1Rv47NovvKBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGOL+qcN1qY0iOjE41HaA1Yako7ViuJxh1Rv47NovvKBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Oct 23, 2017 at 10:01:42AM -0700, Andrey Smirnov wrote:
> On Sat, Oct 21, 2017 at 9:47 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Oct 18, 2017 at 10:01:35AM -0700, Andrey Smirnov wrote:
> >> This driver provides access to RAVE SP watchdog functionality.
> >>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-watchdog@vger.kernel.org
> >> Cc: cphealy@gmail.com
> >> Cc: Lucas Stach <l.stach@pengutronix.de>
> >> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Pavel Machek <pavel@ucw.cz>
> >> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: Johan Hovold <johan@kernel.org>
> >> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> >> ---
> >>  drivers/watchdog/Kconfig       |   7 +
> >>  drivers/watchdog/Makefile      |   1 +
> >>  drivers/watchdog/rave-sp-wdt.c | 310 +++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 318 insertions(+)
> >>  create mode 100644 drivers/watchdog/rave-sp-wdt.c
> >>
> >> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >> index c722cbfdc7e6..533a72248cd1 100644
> >> --- a/drivers/watchdog/Kconfig
> >> +++ b/drivers/watchdog/Kconfig
> >> @@ -223,6 +223,13 @@ config ZIIRAVE_WATCHDOG
> >>         To compile this driver as a module, choose M here: the
> >>         module will be called ziirave_wdt.
> >>
> >> +config RAVE_SP_WATCHDOG
> >> +     tristate "RAVE SP Watchdog timer"
> >> +     depends on RAVE_SP_CORE
> >> +     select WATCHDOG_CORE
> >> +     help
> >> +       Support for the watchdog on RAVE SP device.
> >> +
> >>  # ALPHA Architecture
> >>
> >>  # ARM Architecture
> >> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> >> index 56adf9fa67d0..5c9556c09f6e 100644
> >> --- a/drivers/watchdog/Makefile
> >> +++ b/drivers/watchdog/Makefile
> >> @@ -223,3 +223,4 @@ obj-$(CONFIG_MAX77620_WATCHDOG) += max77620_wdt.o
> >>  obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
> >>  obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
> >>  obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
> >> +obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
> >> diff --git a/drivers/watchdog/rave-sp-wdt.c b/drivers/watchdog/rave-sp-wdt.c
> >> new file mode 100644
> >> index 000000000000..86fdc7fb1f92
> >> --- /dev/null
> >> +++ b/drivers/watchdog/rave-sp-wdt.c
> >> @@ -0,0 +1,310 @@
> >> +/*
> >> + *  rave-sp-wdt.c - Watchdog driver preseing in RAVE SP
> >
> > present ?
> >
> 
> Yup, my bad, will fix in v9.
> 
> >> + *
> >> + * Copyright (C) 2017 Zodiac Inflight Innovation
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License as
> >> + * published by the Free Software Foundation; either version 2 of
> >> + * the License, or (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +
> >> +#include <linux/delay.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/rave-sp.h>
> >> +#include <linux/watchdog.h>
> >> +#include <linux/nvmem-consumer.h>
> >> +#include <linux/reboot.h>
> >> +#include <linux/slab.h>
> >
> > Alphabetic order please.
> >
> 
> OK, will do.
> 
> >> +
> >> +enum {
> >> +     RAVE_SP_RESET_BYTE = 1,
> >> +     RAVE_SP_RESET_REASON_NORMAL = 0,
> >> +     RAVE_SP_RESET_DELAY_MS = 500,
> >> +};
> >> +
> >> +struct rave_sp_wdt_variant {
> >> +     unsigned int max_timeout;
> >> +     unsigned int min_timeout;
> >> +
> >> +     int (*configure)(struct watchdog_device *);
> >> +     int (*restart)(struct watchdog_device *);
> >> +};
> >> +
> >> +struct rave_sp_wdt {
> >> +     struct watchdog_device wdd;
> >> +     struct rave_sp *sp;
> >> +     const struct rave_sp_wdt_variant *variant;
> >> +     struct notifier_block reboot_notifier;
> >> +};
> >> +
> >> +static struct rave_sp_wdt *to_rave_sp_wdt(struct watchdog_device *wdd)
> >> +{
> >> +     return container_of(wdd, struct rave_sp_wdt, wdd);
> >> +}
> >> +
> >> +static int __rave_sp_wdt_exec(struct watchdog_device *wdd,
> >> +                           void *data,  size_t data_size,
> >> +                           void *reply, size_t reply_size)
> >> +{
> >> +     return rave_sp_exec(to_rave_sp_wdt(wdd)->sp,
> >> +                         data, data_size, reply, reply_size);
> >> +}
> >
> > This extra function is only called once and thus quite pointless.
> >
> 
> True. Will remove in v9.
> 
> >> +
> >> +static int rave_sp_wdt_exec(struct watchdog_device *wdd, void *data,
> >> +                         size_t data_size)
> >> +{
> >> +     return __rave_sp_wdt_exec(wdd, data, data_size, NULL, 0);
> >> +}
> >> +
> >> +
> >
> > Please run checkpatch --strict and fix what it reports.
> >
> 
> Sure, will do.
> 
> >> +static int rave_sp_wdt_legacy_configure(struct watchdog_device *wdd)
> >> +{
> >> +     const bool enable = watchdog_hw_running(wdd);
> >> +     u8 cmd[] = {
> >> +             [0] = RAVE_SP_CMD_SW_WDT,
> >> +             [1] = 0,
> >> +             [2] = 0,
> >> +             [3] = !!enable,
> >
> > Useless !!. It converts a boolean to a boolean. Besides, isn't it always
> > true anyway ?
> 
> Good point, will remove the "!!". This function also is called as
> .stop method (via rave_sp_wdt_configure) for corresponding
> "watchdog_device" and I rely on code in watchdog_stop() to clear
> WDOG_HW_RUNNING. Is this not a correct thing to do?
> 
> >
> >> +             [4] = enable ? wdd->timeout : 0,
> >> +     };
> >
> > Interesting; checkpatch doesn't require an empty line after variable
> > declarations anymore ? Lets keep it anyway for consistency.
> >
> 
> OK, will fix in v9.
> 
> >> +     return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> >> +}
> >> +
> >> +static int rave_sp_wdt_rdu_configure(struct watchdog_device *wdd)
> >> +{
> >> +     u8 cmd[] = {
> >> +             [0] = RAVE_SP_CMD_SW_WDT,
> >> +             [1] = 0,
> >> +             [2] = watchdog_hw_running(wdd),
> >
> > Nitpick, but isn't this always true ? There is no stop function,
> > and HW_RUNNING is set before this function is called.
> >
> 
> Same as above. Let me know if relying on HW_RUNNING being cleared by
> watchdog_stop() is incorrect.
> 
Yes, it is incorrect; the knowledge that the flag is cleared before calling
the driver stop function is not part of the API. You should pass that in as
flag.

> >> +             [3] = (u8) wdd->timeout,
> >> +             [4] = (u8) (wdd->timeout >> 8),
> >> +     };
> >> +     return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> >> +}
> >> +
> >> +static int rave_sp_wdt_configure(struct watchdog_device *wdd)
> >> +{
> >> +     return to_rave_sp_wdt(wdd)->variant->configure(wdd);
> >> +}
> >> +
> >> +static int rave_sp_wdt_legacy_restart(struct watchdog_device *wdd)
> >> +{
> >> +     u8 cmd[] = {
> >> +             [0] = RAVE_SP_CMD_RESET,
> >> +             [1] = 0,
> >> +             [2] = RAVE_SP_RESET_BYTE
> >> +     };
> >> +     return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> >> +}
> >> +
> >> +static int rave_sp_wdt_rdu_restart(struct watchdog_device *wdd)
> >> +{
> >> +     u8 cmd[] = {
> >> +             [0] = RAVE_SP_CMD_RESET,
> >> +             [1] = 0,
> >> +             [2] = RAVE_SP_RESET_BYTE,
> >> +             [3] = RAVE_SP_RESET_REASON_NORMAL
> >> +     };
> >> +     return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> >> +}
> >> +
> >> +static int rave_sp_wdt_reboot_notifier(struct notifier_block *nb,
> >> +                                    unsigned long action, void *data)
> >> +{
> >> +     /*
> >> +      * Restart handler is called in atomic context which means we
> >> +      * can't commuicate to SP via UART. Luckily for use SP will
> >
> > communicate
> >
> 
> My bad, will fix in v9.
> 
> >> +      * wait 500ms before actually resetting us, so we ask it to do
> >> +      * so here and let the rest of the system go on wrapping
> >> +      * things up.
> >> +      */
> >> +     if (action == SYS_DOWN || action == SYS_HALT) {
> >> +             struct rave_sp_wdt *sp_wd =
> >> +                     container_of(nb, struct rave_sp_wdt, reboot_notifier);
> >> +
> >> +             const int ret = sp_wd->variant->restart(&sp_wd->wdd);
> >> +
> >> +             if (ret < 0)
> >> +                     dev_err(sp_wd->wdd.parent,
> >> +                             "Failed to issue restart command (%d)", ret);
> >> +             return NOTIFY_OK;
> >> +     }
> >> +
> >> +     return NOTIFY_DONE;
> >> +}
> >> +
> >> +static int rave_sp_wdt_restart(struct watchdog_device *wdd,
> >> +                            unsigned long action, void *data)
> >> +{
> >> +     /*
> >> +      * The actual work was done by reboot notifier above. SP
> >> +      * firmware waits 500 ms before issuing reset, so let's hang
> >> +      * here for one second and hopefuly we'd never reach that
> >
> > RAVE_SP_RESET_DELAY_MS is 500(ms), not one second.
> >
> 
> Sorry, meant to wait for twice that delay, hence one second, but wrote
> incorrect code. Will fix in v9.
> 
> >> +      * return statement
> >> +      */
> >> +     mdelay(RAVE_SP_RESET_DELAY_MS);
> >> +     return -EIO;
> >> +}
> >> +
> >> +static int rave_sp_wdt_start(struct watchdog_device *wdd)
> >> +{
> >> +     set_bit(WDOG_HW_RUNNING, &wdd->status);
> >> +     return rave_sp_wdt_configure(wdd);
> >> +}
> >> +
> >> +static int rave_sp_wdt_set_timeout(struct watchdog_device *wdd,
> >> +                                unsigned int timeout)
> >> +{
> >> +     wdd->timeout = timeout;
> >> +     return rave_sp_wdt_configure(wdd);
> >> +}
> >> +
> >> +static int rave_sp_wdt_ping(struct watchdog_device *wdd)
> >> +{
> >> +     u8 cmd[] = {
> >> +             [0] = RAVE_SP_CMD_PET_WDT,
> >> +             [1] = 0,
> >> +     };
> >> +
> >> +     return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> >> +}
> >> +
> >> +static const struct watchdog_info rave_sp_wdt_info = {
> >> +     .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> >> +     .identity = "RAVE SP Watchdog",
> >> +};
> >> +
> >> +static const struct watchdog_ops rave_sp_wdt_ops = {
> >> +     .owner = THIS_MODULE,
> >> +     .start = rave_sp_wdt_start,
> >> +     .stop = rave_sp_wdt_configure,
> >> +     .ping = rave_sp_wdt_ping,
> >> +     .set_timeout = rave_sp_wdt_set_timeout,
> >> +     .restart = rave_sp_wdt_restart,
> >> +};
> >> +
> >> +static const struct of_device_id rave_sp_wdt_of_match[] = {
> >> +     { .compatible = "zii,rave-sp-watchdog" },
> >> +     {}
> >> +};
> >> +
> >> +static const struct rave_sp_wdt_variant rave_sp_wdt_legacy = {
> >> +     .max_timeout = 255,
> >> +     .min_timeout = 1,
> >> +     .configure = rave_sp_wdt_legacy_configure,
> >> +     .restart   = rave_sp_wdt_legacy_restart,
> >> +};
> >> +
> >> +static const struct rave_sp_wdt_variant rave_sp_wdt_rdu = {
> >> +     .max_timeout = 180,
> >> +     .min_timeout = 60,
> >> +     .configure = rave_sp_wdt_rdu_configure,
> >> +     .restart   = rave_sp_wdt_rdu_restart,
> >> +};
> >> +
> >> +static const struct of_device_id rave_sp_wdt_variants[] = {
> >> +     { .compatible = COMPATIBLE_RAVE_SP_NIU,  .data = &rave_sp_wdt_legacy },
> >> +     { .compatible = COMPATIBLE_RAVE_SP_MEZZ, .data = &rave_sp_wdt_legacy },
> >> +     { .compatible = COMPATIBLE_RAVE_SP_ESB,  .data = &rave_sp_wdt_legacy },
> >> +     { .compatible = COMPATIBLE_RAVE_SP_RDU1, .data = &rave_sp_wdt_rdu    },
> >> +     { .compatible = COMPATIBLE_RAVE_SP_RDU2, .data = &rave_sp_wdt_rdu    },
> >> +     { /* sentinel */ }
> >> +};
> >> +
> >> +static int rave_sp_wdt_probe(struct platform_device *pdev)
> >> +{
> >> +     struct device *dev = &pdev->dev;
> >> +     const struct of_device_id *id;
> >> +     struct watchdog_device *wdd;
> >> +     struct rave_sp_wdt *sp_wd;
> >> +     struct nvmem_cell *cell;
> >> +     __le16 timeout = 0;
> >> +     int ret;
> >> +
> >> +     id = of_match_device(rave_sp_wdt_variants, dev->parent);
> >> +     if (WARN_ON(!id))
> >> +             return -ENODEV;
> >> +
> >> +     sp_wd = devm_kzalloc(dev, sizeof(*sp_wd), GFP_KERNEL);
> >> +     if (!sp_wd)
> >> +             return -ENOMEM;
> >> +
> >> +     sp_wd->variant = id->data;
> >> +     sp_wd->sp      = dev_get_drvdata(dev->parent);
> >> +
> >> +     if (WARN_ON(!sp_wd->sp))
> >> +             return -ENODEV;
> >> +
> > Not sure I understand the value of those tracebacks. Presumably the driver
> > is instantiated through its parent. Is there precedent that other drivers
> > in the same situation do this ?
> >
> 
> No precedent. I was just being paranoid. Will remove in v9.
> 
> Thanks,
> Andrey Smirnov
