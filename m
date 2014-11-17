Return-path: <James.Hogan@imgtec.com>
Date: Mon, 17 Nov 2014 21:21:55 +0000
From: James Hogan <james.hogan@imgtec.com>
To: Andrew Bresticker <abrestic@chromium.org>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>, "wim@iguana.be"
	<wim@iguana.be>, "linux@roeck-us.net" <linux@roeck-us.net>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>, James Hartley <james.hartley@imgtec.com>,
	"Jude Abraham" <jude.abraham@imgtec.com>, Arul Ramasamy
	<arul.ramasamy@imgtec.com>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
Message-ID: <20141117212155.GG1739@jhogan-linux.le.imgtec.org>
References: <1416237194-12033-1-git-send-email-naidu.tellapati@imgtec.com>
 <1416237194-12033-2-git-send-email-naidu.tellapati@imgtec.com>
 <CAL1qeaG1xXXmasLiaM14A+RshnqewnHsuQvxb76CNnwiuAXn_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAL1qeaG1xXXmasLiaM14A+RshnqewnHsuQvxb76CNnwiuAXn_A@mail.gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Nov 17, 2014 at 11:47:51AM -0800, Andrew Bresticker wrote:
> On Mon, Nov 17, 2014 at 7:13 AM,  <naidu.tellapati@imgtec.com> wrote:
> > From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> >
> > This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
> >
> > Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
> > Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> 
> A couple comments below, but otherwise this is looking good.
> 
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> 
> > @@ -1235,6 +1235,16 @@ config BCM_KONA_WDT_DEBUG
> >
> >           If in doubt, say 'N'.
> >
> > +config IMGPDC_WDT
> > +       tristate "Imagination Technologies PDC Watchdog Timer"
> > +       depends on HAS_IOMEM
> 
> We probably don't want to make this visible for everyone with
> HAS_IOMEM, so perhaps MIPS || (HAS_IOMEM && COMPILE_TEST)?  Do we want
> to make this available for META as well?

yeh, can I suggest something like this:
	depends on HAS_IOMEM
	depends on METAG || MIPS || COMPILE_TEST
More intuitive/scalable to have them separate IMO, since technically it
needs HAS_IOMEM regardless of platform (even if the listed platforms are
guaranteed to select HAS_IOMEM).

> 
> > --- /dev/null
> > +++ b/drivers/watchdog/imgpdc_wdt.c
> 
> > +#ifdef CONFIG_COMMON_CLK
> > +#define to_pdc_wdt(_nb) container_of(_nb, struct pdc_wdt_dev, clk_nb)
> > +
> > +static int img_pdc_wdt_clk_notify(struct notifier_block *nb,
> > +                                 unsigned long action, void *data)
> > +{
> > +       struct pdc_wdt_dev *wdt = to_pdc_wdt(nb);
> > +
> > +       switch (action) {
> > +       case POST_RATE_CHANGE:
> > +               if (wdt->clk_rate == data->new_rate)
> > +                       return NOTIFY_OK;
> > +
> > +               /* We use the clock rate to calculate the max timeout */
> > +               if (data->new_rate < 1 ||
> > +                   data->new_rate > PDC_MAX_WD_CLK_RATE) {
> > +                       dev_err(wdt->dev, "invalid clock rate\n");
> > +                       return NOTIFY_BAD;
> > +               }
> > +               wdt->clk_rate = data->new_rate;
> > +               if (order_base_2(wdt->clk_rate) == 0)
> > +                       wdt->min_delay = 0;
> > +               else
> > +                       wdt->min_delay = order_base_2(wdt->clk_rate) - 1;
> > +
> > +               wdt->wdt_dev.max_timeout =
> > +                               (1 << (PDC_WD_MAX_DELAY - wdt->min_delay));
> > +               ret = watchdog_init_timeout(&wdt->wdt_dev, timeout, wdt->dev);
> > +               if (ret < 0)
> > +                       wdt->wdt_dev.timeout = wdt->wdt_dev.max_timeout;
> > +
> > +               pdc_wdt_stop(&wdt->wdt_dev);
> > +               pdc_wdt_set_timeout(&wdt->wdt_dev, wdt->wdt_dev.timeout);
> > +               pdc_wdt_start(&wdt->wdt_dev);
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +       return NOTIFY_OK;
> > +}
> > +#endif
> 
> Do we really expect the watchdog clock to change out from under us?  I
> think we can just get the rate in probe() and set the timeout bounds
> based on that - no one outside the watchdog driver should be messing
> with the watchdog clock, right?  I know the samsung driver does
> something similar to this, but I believe that's because the watchdog
> clock is derived from the CPU clock.

I agree (sorry if I implied wdt needed to be dynamic as well as reading
the [probably constant] rate before).

Note, dynamic changes did happen on TZ1090, but only just before suspend
(since the hardware would change the rate regardless of what software
did when the power actually went down, so it at least allowed drivers to
put their workarounds in place). I presume watchdog timers aren't meant
to be active during suspend though, in which case even for TZ1090 it
probably doesn't need to expect changes.

Cheers
James
