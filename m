Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:48464 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab3KZANA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Nov 2013 19:13:00 -0500
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tomasz Figa <t.figa@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, "cpgs ." <cpgs@samsung.com>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V9 2/3] watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu register
Date: Tue, 26 Nov 2013 01:12:57 +0100
Message-ID: <2152635.sFpuVi4ATm@flatron>
In-Reply-To: <CAD=FV=W+PNhUY+KC6DoMqRuEQFsgdffP466x=VTdGR-3L8ibFQ@mail.gmail.com>
References: <1384768189-2839-1-git-send-email-l.krishna@samsung.com> <1384768189-2839-3-git-send-email-l.krishna@samsung.com> <CAD=FV=W+PNhUY+KC6DoMqRuEQFsgdffP466x=VTdGR-3L8ibFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 25 of November 2013 14:44:01 Doug Anderson wrote:
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

That would mean adding extra tabs in lines above to align them with the
longest drv_data field.

AFAIK we're observing a trend of moving away from such field alignment,
so IMHO it would be better to keep this as is in this version and just
send a separate patch removing the alignment of remaining fields.

> 
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

Jumping away just to a single return statement isn't really a good idea.
If there is nothing to do, returning right away seems less confusing IMHO
(and saves you one line of code per each such error case as a side
effect).

A separate patch could be possibly made to clean-up remaining error cases
and remove the err label.

As for all the remaining points, I agree with Doug.

Best regards,
Tomasz

