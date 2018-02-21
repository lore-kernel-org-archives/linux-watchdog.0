Return-Path: <horms@verge.net.au>
Return-path: <horms@verge.net.au>
Date: Wed, 21 Feb 2018 17:22:12 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] watchdog: renesas_wdt: Blacklist early R-Car Gen2 SoCs
Message-ID: <20180221162211.gzpmtqsx7hv4nicw@verge.net.au>
References: <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519227784-27117-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519227784-27117-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Feb 21, 2018 at 04:43:04PM +0100, Geert Uytterhoeven wrote:
> On early revisions of some R-Car Gen2 SoCs, and depending on SMP
> configuration, the system may fail to restart on watchdog time-out, and
> lock up instead.
> 
> Specifically:
>   - On R-Car H2 ES1.0 and M2-W ES1.0, watchdog restart fails unless
>     only the first CPU core is in use (using e.g. the "maxcpus=1" kernel
>     commandline option).
>   - On R-Car V2H ES1.1, watchdog restart fails unless SMP is disabled
>     completely (using CONFIG_SMP=n during build configuration, or using
>     the "nosmp" or "maxcpus=0" kernel commandline options).
> 
> Prevent using the watchdog in impacted cases by blacklisting the
> affected SoCs, using the minimum known working revisions (ES2.0 on R-Car
> H2, and ES3.0 on M2-W), and taking the actual SMP software configuration
> into account.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To be folded into Fabrizio Castro's "watchdog: renesas_wdt: Add R-Car
> Gen2 support".
> 
> Note that I cannot use IS_ENABLED(CONFIG_SMP), as setup_max_cpus does
> not exist for CONFIG_SMP=n.

Thanks, I was going to ask about that.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


> Any reports on R-Car M2-W ES2.0 and V2H ES2.0+ are welcomed!
> 
> As the failure is due to an integration issue, and the watchdog itself
> is working fine, an alternative solution would be to move the check to
> the code that installs the reset trigger ("soc: renesas: rcar-rst:
> Enable watchdog as reset trigger for Gen2").
> However, doing so would mean that:
>   1. The user could enable and seemingly use the watchdog, but watchdog
>      timeout would not restart the system,
>   2. The same check should be done before installing the new reset
>      vector ("ARM: shmobile: rcar-gen2: Add watchdog support"), too,
>      else onlining CPU0 would fail once the watchdog has timed out.
> ---
>  drivers/watchdog/renesas_wdt.c | 43 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 0f88614797c36022..4c8e8d2600a922a5 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -16,6 +16,8 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/smp.h>
> +#include <linux/sys_soc.h>
>  #include <linux/watchdog.h>
>  
>  #define RWTCNT		0
> @@ -131,6 +133,44 @@ static const struct watchdog_ops rwdt_ops = {
>  	.restart = rwdt_restart,
>  };
>  
> +#if defined(CONFIG_ARCH_RCAR_GEN2) && defined(CONFIG_SMP)
> +/*
> + * Watchdog-reset integration is broken on early revisions of R-Car Gen2 SoCs
> + */
> +static const struct soc_device_attribute rwdt_quirks_match[] = {
> +	{
> +		.soc_id = "r8a7790",
> +		.revision = "ES1.*",
> +		.data = (void *)1,	/* needs single CPU */
> +	}, {
> +		.soc_id = "r8a7791",
> +		.revision = "ES[12].*",
> +		.data = (void *)1,	/* needs single CPU */
> +	}, {
> +		.soc_id = "r8a7792",
> +		.revision = "*",
> +		.data = (void *)0,	/* needs SMP disabled */
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +static bool rwdt_blacklisted(struct device *dev)
> +{
> +	const struct soc_device_attribute *attr;
> +
> +	attr = soc_device_match(rwdt_quirks_match);
> +	if (attr && setup_max_cpus > (uintptr_t)attr->data) {
> +		dev_info(dev, "Watchdog blacklisted on %s %s\n", attr->soc_id,
> +			 attr->revision);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +#else /* !CONFIG_ARCH_RCAR_GEN2 || !CONFIG_SMP */
> +static inline bool rwdt_blacklisted(struct device *dev) { return false; }
> +#endif /* !CONFIG_ARCH_RCAR_GEN2 || !CONFIG_SMP */
> +
>  static int rwdt_probe(struct platform_device *pdev)
>  {
>  	struct rwdt_priv *priv;
> @@ -139,6 +179,9 @@ static int rwdt_probe(struct platform_device *pdev)
>  	unsigned long clks_per_sec;
>  	int ret, i;
>  
> +	if (rwdt_blacklisted(&pdev->dev))
> +		return -ENODEV;
> +
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> -- 
> 2.7.4
> 
