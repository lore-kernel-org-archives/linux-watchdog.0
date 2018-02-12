Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46368 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeBLTYS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Feb 2018 14:24:18 -0500
Date: Mon, 12 Feb 2018 11:24:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
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
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: Re: [PATCH v5 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
Message-ID: <20180212192415.GA22927@roeck-us.net>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 12, 2018 at 05:44:21PM +0000, Fabrizio Castro wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v4->v5:
> * various improvements suggested by Wolfram
> 
>  drivers/watchdog/renesas_wdt.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 831ef83..e972b7b 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -203,13 +203,29 @@ static int rwdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -/*
> - * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
> - * to work there, one also needs a RESET (RST) driver which does not exist yet
> - * due to HW issues. This needs to be solved before adding compatibles here.
> - */
> +static int __maybe_unused rwdt_suspend(struct device *dev)
> +{
> +	struct rwdt_priv *priv = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&priv->wdev))
> +		rwdt_write(priv, priv->cks, RWTCSRA);
> +	return 0;
> +}
> +
> +static int __maybe_unused rwdt_resume(struct device *dev)
> +{
> +	struct rwdt_priv *priv = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&priv->wdev))
> +		rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(rwdt_pm_ops, rwdt_suspend, rwdt_resume);
> +
>  static const struct of_device_id rwdt_ids[] = {
>  	{ .compatible = "renesas,rcar-gen3-wdt", },
> +	{ .compatible = "renesas,rcar-gen2-wdt", },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rwdt_ids);
> @@ -218,6 +234,7 @@ static struct platform_driver rwdt_driver = {
>  	.driver = {
>  		.name = "renesas_wdt",
>  		.of_match_table = rwdt_ids,
> +		.pm = &rwdt_pm_ops,
>  	},
>  	.probe = rwdt_probe,
>  	.remove = rwdt_remove,
> -- 
> 2.7.4
> 
