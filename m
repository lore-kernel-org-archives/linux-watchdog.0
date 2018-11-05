Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40655 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKETLP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 5 Nov 2018 14:11:15 -0500
MIME-Version: 1.0
References: <1541186471-2998-1-git-send-email-fabrizio.castro@bp.renesas.com> <20181102194808.GA17913@roeck-us.net>
In-Reply-To: <20181102194808.GA17913@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Nov 2018 10:52:09 +0100
Message-ID: <CAMuHMdUYELHZ=jFyGbjq0ErYPkegKpLYL-hi5qJVt57N70ETOA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: renesas_wdt: Fix typos
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 2, 2018 at 8:48 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Nov 02, 2018 at 07:21:11PM +0000, Fabrizio Castro wrote:
>
> Do not use "," but ";" to separate instructions.

+1

Thanks, my eyes had a hard time finding out what had been changed ;-)

> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> > ---
> >  drivers/watchdog/renesas_wdt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> > index 0d74c3e..b570962 100644
> > --- a/drivers/watchdog/renesas_wdt.c
> > +++ b/drivers/watchdog/renesas_wdt.c
> > @@ -220,8 +220,8 @@ static int rwdt_probe(struct platform_device *pdev)
> >               goto out_pm_disable;
> >       }
> >
> > -     priv->wdev.info = &rwdt_ident,
> > -     priv->wdev.ops = &rwdt_ops,
> > +     priv->wdev.info = &rwdt_ident;
> > +     priv->wdev.ops = &rwdt_ops;
> >       priv->wdev.parent = &pdev->dev;
> >       priv->wdev.min_timeout = 1;
> >       priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
