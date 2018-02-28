Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43566 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932745AbeB1TY3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Feb 2018 14:24:29 -0500
MIME-Version: 1.0
In-Reply-To: <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com> <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2018 20:24:27 +0100
Message-ID: <CAMuHMdXKHzpi9evmTOt58DaZzA3dHmMJsAqPNi0+j9Bv1QBbdQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabrizio,

On Mon, Feb 12, 2018 at 6:44 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Due to commits:
> * "ARM: shmobile: Add watchdog support",
> * "ARM: shmobile: rcar-gen2: Add watchdog support", and
> * "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
> we now have everything we needed for the watchdog to work on Gen2 and
> RZ/G1.
>
> This commit adds "renesas,rcar-gen2-wdt" as compatible string for R-Car
> Gen2 and RZ/G1, and since on those platforms the rwdt clock needs to be
> always ON, when suspending to RAM we need to explicitly disable the
> counting by clearing TME from RWTCSRA.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks for your patch!

I verified this works on R-Car Gen2, so
Reviewed-and-Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Still, more comments below...

> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -203,13 +203,29 @@ static int rwdt_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -/*
> - * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
> - * to work there, one also needs a RESET (RST) driver which does not exist yet
> - * due to HW issues. This needs to be solved before adding compatibles here.
> - */
> +static int __maybe_unused rwdt_suspend(struct device *dev)
> +{
> +       struct rwdt_priv *priv = dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&priv->wdev))
> +               rwdt_write(priv, priv->cks, RWTCSRA);
> +       return 0;
> +}
> +
> +static int __maybe_unused rwdt_resume(struct device *dev)
> +{
> +       struct rwdt_priv *priv = dev_get_drvdata(dev);
> +
> +       if (watchdog_active(&priv->wdev))
> +               rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);

Writing to this register is not sufficient on R-Car Gen3, where PSCI
suspend powers down the whole SoC.  Hence all WDT register content is lost,
causing the watchdog timeout never to trigger.
Note that this issue is pre-existing, and not caused by your patch.

This can be fixed by replacing the RWTCSRA register writes in the
suspend/resume handlers by calls to rwdt_stop() resp. rwdt_start(), like is
done in the BSP in commit e406980763f18f38 ("watchdog: renesas-wdt: Support
the suspend/resume"). Note that this would cause a small change in behavior
on R-Car Gen2, where the timeout would be reset on resume, instead of
continuing where stopped before. I don't think that hurts, though.

Since I was always a bit uncomfortable with this patch doing two things at
once (1. suspend/resume, 2. "renesas,rcar-gen2-wdt" matching), I think it
would be better to take the patch from the BSP first, and add support for
"renesas,rcar-gen2-wdt" in a subsequent patch.

Does the above make sense?
Do you agree?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
