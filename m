Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35491 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdGRHAE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 18 Jul 2017 03:00:04 -0400
MIME-Version: 1.0
In-Reply-To: <20170717151230.12680-2-wsa+renesas@sang-engineering.com>
References: <20170717151230.12680-1-wsa+renesas@sang-engineering.com> <20170717151230.12680-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jul 2017 09:00:02 +0200
Message-ID: <CAMuHMdV+yAy+QmDWFn8a7U8F1F5NcoV5C-1e8LeCV-jKcQHnMA@mail.gmail.com>
Subject: Re: [PATCH 1/5] watchdog: renesas_wdt: avoid (theoretical) type overflow
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On Mon, Jul 17, 2017 at 5:12 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Because the smallest clock divider we can select is 1, 'clks_per_sec'
> must be the same type as 'rate'.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -112,8 +112,7 @@ static int rwdt_probe(struct platform_device *pdev)
>  {
>         struct rwdt_priv *priv;
>         struct resource *res;
> -       unsigned long rate;
> -       unsigned int clks_per_sec;
> +       unsigned long rate, clks_per_sec;

If you make this change, you should also update rwdt_priv.clks_per_sec
(yes I know it's removed in a later patch in this series).

>         int ret, i;
>
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
