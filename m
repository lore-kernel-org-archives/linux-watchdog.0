Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35640 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIESZF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Sep 2018 14:25:05 -0400
MIME-Version: 1.0
References: <20180829074241.1943-1-wsa+renesas@sang-engineering.com>
 <20180829074241.1943-2-wsa+renesas@sang-engineering.com> <20180829205535.GA30332@anatevka.americas.hpqcorp.net>
In-Reply-To: <20180829205535.GA30332@anatevka.americas.hpqcorp.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Sep 2018 15:54:32 +0200
Message-ID: <CAMuHMdVZ_TPLFqj1fkdW6uPm_urDYHKk9Rp8hXd_9gm-0CXcuA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] watchdog: core: add mechanism to prevent
 removing if NOWAYOUT
To: Jerry.Hoemann@hpe.com
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jerry,

On Wed, Aug 29, 2018 at 10:55 PM Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> On Wed, Aug 29, 2018 at 09:42:38AM +0200, Wolfram Sang wrote:
> > To prevent removing if NOWAYOUT, we invalidate the .remove function and
> > suppress the bind/unbind attributes in sysfs. These are driver
> > capabilities, so we need to set it up at runtime during init. To avoid
> > boilerplate, introduce module_watchdog_driver() similar to
> > module_driver(). On top of that, we then build
> > module_watchdog_platform_driver(). Others may follow, if needed.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  include/linux/watchdog.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> > index 44985c4a1e86..c8ecbc53c807 100644
> > --- a/include/linux/watchdog.h
> > +++ b/include/linux/watchdog.h
> > @@ -216,4 +216,21 @@ extern void watchdog_unregister_device(struct watchdog_device *);
> >  /* devres register variant */
> >  int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
> >
> > +#define module_watchdog_driver(__driver, __register, __unregister, __nowayout, ...) \
> > +static int __init __driver##_init(void) \
> > +{ \
> > +     __driver.driver.suppress_bind_attrs = !!(__nowayout); \
> > +     return __register(&(__driver)  ##__VA_ARGS__); \
> > +} \
>
> Sorry, I'm not familiar w/ this level of detail of the driver interface.
>
> Is the intent of the proposed changes to prevent the unload of
> a module if it was loaded with the "nowayout" parameter?
>
> If so, I thought the WD "nowayout" semantic was only supposed to be in effect
> after /dev/watchdog was opened.  The proposed change looks like it makes the
> "nowayout" semantic take effect before /dev/watchdog is opened.

Thanks, that's IMHO a very valid point.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
