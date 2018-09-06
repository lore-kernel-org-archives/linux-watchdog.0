Return-Path: <geert.uytterhoeven@gmail.com>
Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180905173743.47938-1-chris.brandt@renesas.com>
In-Reply-To: <20180905173743.47938-1-chris.brandt@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Sep 2018 12:07:06 +0200
Message-ID: <CAMuHMdUK7OSYwE85F-1Pw4gQfDR9JJ5-_cPCk=BRiV5pzt=DCw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: rza_wdt: Extend clock sources for RZ/A2
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hi Chris,

On Wed, Sep 5, 2018 at 7:40 PM Chris Brandt <chris.brandt@renesas.com> wrote:
> The RZ/A2 watchdog timer extends the clock source options in order to give
> you longer timeout options.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

> --- a/drivers/watchdog/rza_wdt.c
> +++ b/drivers/watchdog/rza_wdt.c
> @@ -38,8 +38,37 @@ struct rza_wdt {
>         struct watchdog_device wdev;
>         void __iomem *base;
>         struct clk *clk;
> +       bool ext_cks;
> +       u8 count;
> +       u8 cks;
> +       u8 timeout;
>  };
>
> +static void rza_wdt_calc_timeout(struct rza_wdt *priv, int timeout)
> +{
> +       int rate = clk_get_rate(priv->clk);
> +       u16 counter;
> +
> +       if (priv->ext_cks) {
> +               /* Add the 1 to deal with the inevitable fraction */
> +               counter = ((timeout * rate) /  4194304) + 1;

"timeout * rate" may overflow
DIV_ROUND_UP()?

> +               if (counter > 255)
> +                       counter = 0;
> +
> +               priv->cks = 0xF;
> +               priv->count = 256 - counter;
> +       } else {
> +               /* Start timer with longest timeout */
> +               priv->cks = 7;
> +               priv->count = 0;
> +       }
> +
> +       priv->timeout = timeout;
> +
> +       pr_debug("%s: timeout set to %d (WTCNT=%d)\n", __func__,

%u for unsigned.

> +                timeout, priv->count);
> +}

> @@ -150,20 +184,29 @@ static int rza_wdt_probe(struct platform_device *pdev)
>                 return -ENOENT;
>         }
>
> -       /* Assume slowest clock rate possible (CKS=7) */
> -       rate /= 16384;
> +       if (of_device_is_compatible(np, "renesas,r7s9210-wdt"))
> +               priv->ext_cks = true;

That's not the proper way to support multiple devices.
Please add an entry for "renesas,r7s9210-wdt" to rza_wdt_of_match[].
"renesas,r7s9210-wdt" must be documented in the DT bindings.

I suggest storing cks in rza_wdt_of_match[].data, and retrieving it with
of_device_get_match_data() in your probe function, so you can use that to
differentiate, and get rid of the ext_cks flag.

BTW, is the RZ/A2 WDT compatible with the RZ/A1 WDT, i.e. does it work
with the unmodified driver? If not, "renesas,rza-wdt" must not be used as a
fallback.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
