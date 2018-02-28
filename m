Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:7133 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933205AbeB1Rs3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Feb 2018 12:48:29 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "Ramesh Shanmugasundaram" <ramesh.shanmugasundaram@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] watchdog: renesas_wdt: Blacklist early R-Car Gen2 SoCs
Date: Wed, 28 Feb 2018 17:48:21 +0000
Message-ID: <TY1PR06MB0895E67A16076B203FDF27E9C0C70@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519227784-27117-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1519227784-27117-1-git-send-email-geert+renesas@glider.be>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Subject: [PATCH] watchdog: renesas_wdt: Blacklist early R-Car Gen2 SoCs
>
> On early revisions of some R-Car Gen2 SoCs, and depending on SMP
> configuration, the system may fail to restart on watchdog time-out, and
> lock up instead.
>
> Specifically:
>   - On R-Car H2 ES1.0 and M2-W ES1.0, watchdog restart fails unless
>     only the first CPU core is in use (using e.g. the "maxcpus=3D1" kerne=
l
>     commandline option).
>   - On R-Car V2H ES1.1, watchdog restart fails unless SMP is disabled
>     completely (using CONFIG_SMP=3Dn during build configuration, or using
>     the "nosmp" or "maxcpus=3D0" kernel commandline options).
>
> Prevent using the watchdog in impacted cases by blacklisting the
> affected SoCs, using the minimum known working revisions (ES2.0 on R-Car
> H2, and ES3.0 on M2-W), and taking the actual SMP software configuration
> into account.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

> ---
> To be folded into Fabrizio Castro's "watchdog: renesas_wdt: Add R-Car
> Gen2 support".
>
> Note that I cannot use IS_ENABLED(CONFIG_SMP), as setup_max_cpus does
> not exist for CONFIG_SMP=3Dn.
>
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
>  drivers/watchdog/renesas_wdt.c | 43 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wd=
t.c
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
>  #define RWTCNT0
> @@ -131,6 +133,44 @@ static const struct watchdog_ops rwdt_ops =3D {
>  .restart =3D rwdt_restart,
>  };
>
> +#if defined(CONFIG_ARCH_RCAR_GEN2) && defined(CONFIG_SMP)
> +/*
> + * Watchdog-reset integration is broken on early revisions of R-Car Gen2=
 SoCs
> + */
> +static const struct soc_device_attribute rwdt_quirks_match[] =3D {
> +{
> +.soc_id =3D "r8a7790",
> +.revision =3D "ES1.*",
> +.data =3D (void *)1,/* needs single CPU */
> +}, {
> +.soc_id =3D "r8a7791",
> +.revision =3D "ES[12].*",
> +.data =3D (void *)1,/* needs single CPU */
> +}, {
> +.soc_id =3D "r8a7792",
> +.revision =3D "*",
> +.data =3D (void *)0,/* needs SMP disabled */
> +},
> +{ /* sentinel */ }
> +};
> +
> +static bool rwdt_blacklisted(struct device *dev)
> +{
> +const struct soc_device_attribute *attr;
> +
> +attr =3D soc_device_match(rwdt_quirks_match);
> +if (attr && setup_max_cpus > (uintptr_t)attr->data) {
> +dev_info(dev, "Watchdog blacklisted on %s %s\n", attr->soc_id,
> + attr->revision);
> +return true;
> +}
> +
> +return false;
> +}
> +#else /* !CONFIG_ARCH_RCAR_GEN2 || !CONFIG_SMP */
> +static inline bool rwdt_blacklisted(struct device *dev) { return false; =
}
> +#endif /* !CONFIG_ARCH_RCAR_GEN2 || !CONFIG_SMP */
> +
>  static int rwdt_probe(struct platform_device *pdev)
>  {
>  struct rwdt_priv *priv;
> @@ -139,6 +179,9 @@ static int rwdt_probe(struct platform_device *pdev)
>  unsigned long clks_per_sec;
>  int ret, i;
>
> +if (rwdt_blacklisted(&pdev->dev))
> +return -ENODEV;
> +
>  priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  if (!priv)
>  return -ENOMEM;
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
