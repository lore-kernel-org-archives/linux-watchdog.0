Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:61338 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727Ab3KZMbY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Nov 2013 07:31:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W+PNhUY+KC6DoMqRuEQFsgdffP466x=VTdGR-3L8ibFQ@mail.gmail.com>
References: <1384768189-2839-1-git-send-email-l.krishna@samsung.com>
 <1384768189-2839-3-git-send-email-l.krishna@samsung.com> <CAD=FV=W+PNhUY+KC6DoMqRuEQFsgdffP466x=VTdGR-3L8ibFQ@mail.gmail.com>
From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 26 Nov 2013 18:01:02 +0530
Message-ID: <CAL1wa8eAUKkDA41A-9HTc+=iPbGFrkQUXPMtkNFbH4Y9y-b0tA@mail.gmail.com>
Subject: Re: [PATCH V9 2/3] watchdog: s3c2410_wdt: use syscon regmap interface
 to configure pmu register
To: Doug Anderson <dianders@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, "cpgs ." <cpgs@samsung.com>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Doug,

Thanks for reviewing the patch series.

On Tue, Nov 26, 2013 at 4:14 AM, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi Leela Krishna,
>
> On Mon, Nov 18, 2013 at 1:49 AM, Leela Krishna Amudala
> <l.krishna@samsung.com> wrote:
> > Add device tree support for exynos5250 and 5420 SoCs and use syscon regmap interface
> > to configure AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST registers of PMU
> > to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
> >
> > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> > ---
> >  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 ++-
> >  drivers/watchdog/Kconfig                           |    1 +
> >  drivers/watchdog/s3c2410_wdt.c                     |  145 ++++++++++++++++++--
> >  3 files changed, 157 insertions(+), 10 deletions(-)
>
> ...
>
> > +struct s3c2410_wdt_variant {
> > +       int disable_reg;
> > +       int mask_reset_reg;
> > +       int mask_bit;
> > +       u32 quirks;
> > +};
>
> Ideally you could add descriptions.  I added them in a patch based on
> yours <https://chromium-review.googlesource.com/#/c/177935/1/drivers/watchdog/s3c2410_wdt.c>,
> but since yours hasn't landed perhaps you can do it directly?
>
> /**
>  * struct s3c2410_wdt_variant - Per-variant config data
>  *
>  * @disable_reg: Offset in pmureg for the register that disables the watchdog
>  * timer reset functionality.
>  * @mask_reset_reg: Offset in pmureg for the register that masks the watchdog
>  * timer reset functionality.
>  * @mask_bit: Bit number for the watchdog timer in the disable register and the
>  * mask reset register.
>  * @quirks: A bitfield of quirks.
>  */
>

Okay, Added the above descriptions

> > +
> >  struct s3c2410_wdt {
> >         struct device           *dev;
> >         struct clk              *clock;
> > @@ -94,7 +107,49 @@ struct s3c2410_wdt {
> >         unsigned long           wtdat_save;
> >         struct watchdog_device  wdt_device;
> >         struct notifier_block   freq_transition;
> > +       struct s3c2410_wdt_variant *drv_data;
> > +       struct regmap *pmureg;
>
> Total nit, but everything else in this structure is tab aligned and
> your new elements are not.
>

Me and Tomasz had a discussion about it and he replied for this comment

> >  static int s3c2410wdt_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev;
> > @@ -354,6 +443,16 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >         spin_lock_init(&wdt->lock);
> >         wdt->wdt_device = s3c2410_wdd;
> >
> > +       wdt->drv_data = get_wdt_drv_data(pdev);
> > +       if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> > +               wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +                                                       "samsung,syscon-phandle");
> > +               if (IS_ERR(wdt->pmureg)) {
> > +                       dev_err(dev, "syscon regmap lookup failed.\n");
> > +                       return PTR_ERR(wdt->pmureg);
>
> nit: this function appears to never call "return" directly.  You'll
> match other error handling better if you do:
>
> ret = PTR_ERR(wdt->pmureg);
> goto err;
>
> (if someone else has already said they don't like that, just ignore me).
>

Will consider Tomasz suggestion for this

> > +               }
> > +       }
> > +
> >         wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >         if (wdt_irq == NULL) {
> >                 dev_err(dev, "no irq resource specified\n");
> > @@ -444,6 +543,14 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >                  (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
> >                  (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
> >
> > +       if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> > +               ret = s3c2410wdt_mask_and_disable_reset(wdt, false);
> > +               if (ret < 0) {
> > +                       dev_err(wdt->dev, "failed to update pmu register");
> > +                       goto err_cpufreq;
> > +               }
> > +       }
>
> There are a few minor problems here:
>
> 1. You're putting a potential failure condition _after_ printing that
> the watchdog is enabled.  You should put your code above the
> "dev_info".
>

Yes moved it like below

static int s3c2410wdt_probe(struct platform_device *pdev)
{

[snip]

if (tmr_atboot && started == 0) {
                dev_info(dev, "starting watchdog timer\n");
                s3c2410wdt_start(&wdt->wdt_device);
}
[snip]


> 2. Error handling doesn't seem quite right.  If you fail here you'll
> be returning an error but you might have started the watchdog already.
>  Perhaps you should be moving the "mask_and_disable" up a little and
> then you an undo it if needed?
>

Above mentioned comment will take care of this

> 3. I think it would be fine to put the "dev_err" directly in the
> s3c2410wdt_mask_and_disable_reset() as per Guenter, but still return
> the error code.  You'll still use the error code here, right?
>

Yes, used dev_err and moved it into s3c2410wdt_mask_and_disable_reset()
and removed the dev_err message in the if (ret < 0) check

> > +
> >         return 0;
> >
> >   err_cpufreq:
> > @@ -459,8 +566,15 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >
> >  static int s3c2410wdt_remove(struct platform_device *dev)
> >  {
> > +       int ret;
> >         struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
> >
> > +       if (wdt->drv_data->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> > +               ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
>
> This function does return an error.  Why not pass the error on
> through?  The system wouldn't be in such a stellar state, but if
> regmap is failing it's probably pretty bad anyway...
>
>

Yes, returning the error here and doing the same in other functions also
like suspend and resume

Will post the next version tomorrow

Best Wishes,
Leela Krishna.

>
> Nothing here is terrible and I wouldn't be upset if you landed these
> as-is, but since it seems that Guenter is requesting a spin.  Perhaps
> you could address my comments, too?
>
>
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
