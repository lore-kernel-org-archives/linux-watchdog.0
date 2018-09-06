Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33829 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeIFRY2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Sep 2018 13:24:28 -0400
MIME-Version: 1.0
References: <20180905173743.47938-1-chris.brandt@renesas.com>
 <CAMuHMdUK7OSYwE85F-1Pw4gQfDR9JJ5-_cPCk=BRiV5pzt=DCw@mail.gmail.com> <TY1PR01MB15628F6B1EE72F7CCB4307938A010@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB15628F6B1EE72F7CCB4307938A010@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Sep 2018 14:48:54 +0200
Message-ID: <CAMuHMdWkXUSJugDodigjo3kBS7quLuG4NjRvuP-+rGtY1B4Meg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: rza_wdt: Extend clock sources for RZ/A2
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Chris,

On Thu, Sep 6, 2018 at 2:44 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Thursday, September 06, 2018, Geert Uytterhoeven wrote:
> > > +       if (of_device_is_compatible(np, "renesas,r7s9210-wdt"))
> > > +               priv->ext_cks = true;
> >
> > That's not the proper way to support multiple devices.
> > Please add an entry for "renesas,r7s9210-wdt" to rza_wdt_of_match[].
> > "renesas,r7s9210-wdt" must be documented in the DT bindings.
> >
> > I suggest storing cks in rza_wdt_of_match[].data, and retrieving it with
> > of_device_get_match_data() in your probe function, so you can use that to
> > differentiate,
>
> OK, I will change to that.
>
> > and get rid of the ext_cks flag.
>
> I still need to keep track if it's a RZ/A1 or RZ/A2 (ext_cks) for
> functions outside of probe (rza_wdt_calc_timeout).

You can check if priv->cks > 7?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
