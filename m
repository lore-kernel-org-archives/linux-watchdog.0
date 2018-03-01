Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36530 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161487AbeCAUSW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 15:18:22 -0500
MIME-Version: 1.0
In-Reply-To: <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com> <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Mar 2018 21:18:20 +0100
Message-ID: <CAMuHMdW-_MgFSh5aKGiMVyvc2-nvJXCPGCgQOCGfg9yqA708qw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] watchdog: renesas_wdt: Add suspend/resume support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabrizio,

On Thu, Mar 1, 2018 at 7:17 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> On R-Car Gen2 and RZ/G1 the watchdog IP clock needs to be always ON,
> on R-Car Gen3 we power the IP down during suspend.
>
> This commit adds suspend/resume support, so that the watchdog counting
> "pauses" during suspend on all of the SoCs compatible with this driver
> and on those we are now adding support for (R-Car Gen2 and RZ/G1).
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
> v6->v7:
> * backup and restore register RWTCNT instead of using rwdt_get_timeleft and
>   rwdt_set_timeleft

Thanks for the update (v6 and v7)!

>
>  drivers/watchdog/renesas_wdt.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 831ef83..024d54e 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -49,6 +49,7 @@ struct rwdt_priv {
>         void __iomem *base;
>         struct watchdog_device wdev;
>         unsigned long clk_rate;
> +       u16 time_left;
>         u8 cks;
>  };
>
> @@ -203,6 +204,30 @@ static int rwdt_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int __maybe_unused rwdt_suspend(struct device *dev)
> +{
> +       struct rwdt_priv *priv = dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&priv->wdev)) {
> +               priv->time_left = readw(priv->base + RWTCNT);
> +               rwdt_stop(&priv->wdev);
> +       }
> +       return 0;
> +}
> +
> +static int __maybe_unused rwdt_resume(struct device *dev)
> +{
> +       struct rwdt_priv *priv = dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&priv->wdev)) {
> +               rwdt_start(&priv->wdev);
> +               rwdt_write(priv, priv->time_left, RWTCNT);

Upon given it more thought, I'm a bit worried about restoring the
original time left.
In my experiments, it may take a few seconds before userspace fully resumes.
If time_left was a small value, the system may reboot before userspace has
a chance to send its next ping.
This was with NFS root, so heavily impacted by the delays introduced by the
PHY link getting up again.

So just using rwdt_stop()/rwdt_start() may be the safest option.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
