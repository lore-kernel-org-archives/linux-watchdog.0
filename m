Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35003 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbcBVSZa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 13:25:30 -0500
Received: by mail-ig0-f180.google.com with SMTP id hb3so82838568igb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Feb 2016 10:25:29 -0800 (PST)
Subject: Re: [PATCH v2 2/5] watchdog: pnx4008: add restart handler
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: Joachim Eastwood <manabian@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Roland Stigge <stigge@antcom.de>,
	Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <CAGhQ9Vz-6seRXQzcrfR-jS2GdYYac3ERz6wAiMZENq+ECHFzSw@mail.gmail.com>
References: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
	 <1456160143-26761-3-git-send-email-slemieux.tyco@gmail.com>
	 <CAGhQ9Vz-6seRXQzcrfR-jS2GdYYac3ERz6wAiMZENq+ECHFzSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Feb 2016 13:25:26 -0500
Message-ID: <1456165526.28348.9.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2016-02-22 at 19:03 +0100, Joachim Eastwood wrote:
> Hi Sylvain,
> 
> On 22 February 2016 at 17:55,  <slemieux.tyco@gmail.com> wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> >
> > Add restart handler capability to the driver;
> > the restart handler implementation was taken from
> > "mach-lpc32xx" ("lpc23xx_restart" function).
> 
> I think it would be better if you were to expand on "watchdog: core:
> add restart handler support" to give you the parameters you need to
> make the restart hook work for you. But that is up to watchdog
> maintainers to decide.

I prefer to do this as a separate patchset;
I will wait for the watchdog maintainer feedback on this.

> 
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > ---
> > Changes from v1 to v2:
> > - new patch in v2.
> >
> >  drivers/watchdog/pnx4008_wdt.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> > index 88264a2..4b01b2b 100644
> > --- a/drivers/watchdog/pnx4008_wdt.c
> > +++ b/drivers/watchdog/pnx4008_wdt.c
> > @@ -31,7 +31,10 @@
> >  #include <linux/slab.h>
> >  #include <linux/err.h>
> >  #include <linux/of.h>
> > +#include <linux/delay.h>
> > +#include <linux/reboot.h>
> >  #include <mach/hardware.h>
> > +#include <mach/platform.h>
> 
> What are you using from mach/platform.h?
This file is require for the define use to directly
access the clock register (see note below).
> 
> >
> >  /* WatchDog Timer - Chapter 23 Page 207 */
> >
> > @@ -77,6 +80,7 @@
> >
> >  static bool nowayout = WATCHDOG_NOWAYOUT;
> >  static unsigned int heartbeat = DEFAULT_HEARTBEAT;
> > +static struct notifier_block restart_handler;
> >
> >  static DEFINE_SPINLOCK(io_lock);
> >  static void __iomem    *wdt_base;
> > @@ -124,6 +128,27 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
> >         return 0;
> >  }
> >
> > +static void pnx4008_wdt_sys_reset(enum reboot_mode mode, const char *cmd)
> > +{
> > +       /* Make sure WDT clocks are enabled */
> > +       writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN, LPC32XX_CLKPWR_TIMER_CLK_CTRL);
> 
> Doesn't the watchdog driver already enable this clock in probe?
> Either way doing a direct write to LPC32XX_CLKPWR_TIMER_CLK_CTRL from
> here isn't very nice.
> 
I keep this from the "mach-lpc32xx" implementation, in case the call to
the "devm_clk_get" fail in the probe; the restart will still work.

I can remove it, and the platform.h include.
> 
> > +       /* Instant assert of RESETOUT_N with pulse length 1mS */
> > +       writel(13000, WDTIM_PULSE(wdt_base));
> > +       writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
> > +
> > +       /* Wait for watchdog to reset system */
> > +       mdelay(1000);
> > +}
> > +
> > +static int pnx4008_restart_handler(struct notifier_block *this,
> > +                                  unsigned long mode, void *cmd)
> > +{
> > +       pnx4008_wdt_sys_reset((enum reboot_mode)mode, cmd);
> 
> Why can you just the stuff from pnx4008_wdt_sys_reset() in this function?
> 
OK
> 
> > +
> > +       return NOTIFY_DONE;
> > +}
> > +
> >  static const struct watchdog_info pnx4008_wdt_ident = {
> >         .options = WDIOF_CARDRESET | WDIOF_MAGICCLOSE |
> >             WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> > @@ -157,6 +182,11 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
> >         if (IS_ERR(wdt_base))
> >                 return PTR_ERR(wdt_base);
> >
> > +       /* Register restart handler. */
> > +       restart_handler.notifier_call = pnx4008_restart_handler;
> > +       restart_handler.priority = 128;
> > +       ret = register_restart_handler(&restart_handler);
> 
> Checking return value would be a nice thing to do.
OK
> 
> You should also do a unregister_restart_handler() in driver remove hook.
Thanks for catching it.

I will wait, in case there is other feedback, and submit a revision 3
of the patchset.
> 
> 
> regards,
> Joachim Eastwood


