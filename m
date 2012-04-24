Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41865 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab2DXJ1l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Apr 2012 05:27:41 -0400
Message-ID: <4F9671D8.4080308@arm.com>
Date: Tue, 24 Apr 2012 10:26:48 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@st.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	"spear-devel@list.st.com" <spear-devel@list.st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <Pawel.Moll@arm.com>
Subject: Re: [PATCH V3 2/2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
References: <31b0b89e21e6a234cb904761a1d0e5106405da82.1335246446.git.viresh.kumar@st.com> <27dea103ccf6da5b7376c837d9a95dc7a9ed3be3.1335246446.git.viresh.kumar@st.com>
In-Reply-To: <27dea103ccf6da5b7376c837d9a95dc7a9ed3be3.1335246446.git.viresh.kumar@st.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 24/04/12 06:50, Viresh Kumar wrote:
> This patch adds Device tree probing support for ARM Mpcore watchdog. It=
s binding
> were already documented in Documentation/devicetree/bindings/arm/twd.tx=
t.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
> V2->V3:
> - Nothing. Just resend it.

I'm sorry, but I really have to ask: What is the point of adding DT
support to this driver when it is obvious that it is already broken?

As mentioned yesterday, interrupt request doesn't use the right API,
which makes it very unlikely that the probe function will succeed.

Furthermore, I cannot see anything in this driver that ensures the
userspace ioctl() will end-up kicking the watchdog on the right CPU.

So if you really care about this driver, please have a look at the above
issues. Otherwise this is only pointless churn.

Thanks,

	M.

>  drivers/watchdog/mpcore_wdt.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wd=
t.c
> index 13197c7..3690af3 100644
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
> @@ -424,6 +425,16 @@ static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mp=
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
> @@ -432,6 +443,7 @@ static struct platform_driver mpcore_wdt_driver =3D=
 {
>  		.owner	=3D THIS_MODULE,
>  		.name	=3D "mpcore_wdt",
>  		.pm	=3D &mpcore_wdt_dev_pm_ops,
> +		.of_match_table =3D of_match_ptr(mpcore_wdt_id_table),
>  	},
>  };
> =20


--=20
Jazz is not dead. It just smells funny...

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
