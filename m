Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47157 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab2DWIhE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 04:37:04 -0400
Message-ID: <4F9514AA.10403@arm.com>
Date: Mon, 23 Apr 2012 09:36:58 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.linux@gmail.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	"spear-devel@list.st.com" <spear-devel@list.st.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM mpcore
 watchdog
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com> <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
In-Reply-To: <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 21/04/12 12:41, Viresh Kumar wrote:
> This patch adds Device tree probing support for ARM Mpcore watchdog. It=
s binding
> were already documented in Documentation/devicetree/bindings/arm/twd.tx=
t.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
> V1->V2:
> - Reuse earlier bindings defined in twd.txt
>=20
>  drivers/watchdog/mpcore_wdt.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wd=
t.c
> index 7c00455..98df379 100644
> --- a/drivers/watchdog/mpcore_wdt.c
> +++ b/drivers/watchdog/mpcore_wdt.c
> @@ -27,6 +27,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/reboot.h>
> @@ -402,6 +403,16 @@ static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mp=
core_wdt_suspend,
>  /* work with hotplug and coldplug */
>  MODULE_ALIAS("platform:mpcore_wdt");
> =20
> +#ifdef CONFIG_OF
> +static const struct of_device_id mpcore_wdt_id_table[] =3D {
> +	{ .compatible =3D "arm,cortex-a9-twd-wdt" },
> +	{ .compatible =3D "arm,cortex-a5-twd-wdt" },
> +	{ .compatible =3D "arm,arm11mp-twd-wdt" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mpcore_wdt_id_table);
> +#endif
> +
>  static struct platform_driver mpcore_wdt_driver =3D {
>  	.probe		=3D mpcore_wdt_probe,
>  	.remove		=3D __devexit_p(mpcore_wdt_remove),
> @@ -410,6 +421,7 @@ static struct platform_driver mpcore_wdt_driver =3D=
 {
>  		.owner	=3D THIS_MODULE,
>  		.name	=3D "mpcore_wdt",
>  		.pm	=3D &mpcore_wdt_dev_pm_ops,
> +		.of_match_table =3D of_match_ptr(mpcore_wdt_id_table),
>  	},
>  };
> =20

Irk! Have you actually tested this?

The DT binding indicates:
- reg : Specify the base address and the size of the TWD watchdog
        register window.

while all the offsets in smp_twd.h are expressed in bytes from the TWD
*timer* base. So you have to either fix these offsets (which breaks
potential users of the non-DT version of the driver), or correct the
base when using DT.

	M.
--=20
Jazz is not dead. It just smells funny...

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
