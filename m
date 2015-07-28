Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48301 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbbG2Gof (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 02:44:35 -0400
Subject: Re: [PATCH 3/5] iTCO_wdt: Add support for TCO on Intel Sunrisepoint
From: Jean Delvare <jdelvare@suse.de>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
In-Reply-To: <1438004292-16382-4-git-send-email-matt@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
	 <1438004292-16382-4-git-send-email-matt@codeblueprint.co.uk>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2015 19:03:41 +0200
Message-ID: <1438103021.24962.46.camel@chaos.site>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Matt,

Le Monday 27 July 2015 =C3=A0 14:38 +0100, Matt Fleming a =C3=A9crit :
> From: Matt Fleming <matt.fleming@intel.com>
>=20
> The revision of the watchdog hardware in Sunrisepoint necessitates a =
new
> "version" inside the TCO watchdog driver because some of the register
> layouts have changed.
>=20
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> ---
>  drivers/watchdog/iTCO_wdt.c | 58 ++++++++++++++++++++++++++---------=
----------
>  1 file changed, 34 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.=
c
> index 9a6e70976f64..17dfbc51b85a 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> (...)=20
> @@ -503,7 +510,10 @@ static int iTCO_wdt_probe(struct platform_device=
 *dev)
>  		pdata->name, pdata->iTCO_version, (u64)TCOBASE);
> =20
>  	/* Clear out the (probably old) status */
> -	if (iTCO_wdt_private.iTCO_version =3D=3D 3) {
> +	if (iTCO_wdt_private.iTCO_version =3D=3D 4) {
> +		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
> +		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
> +	} else if (iTCO_wdt_private.iTCO_version =3D=3D 3) {
>  		outl(0x20008, TCO1_STS);
>  	} else {
>  		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */

The "version =3D=3D 4" branch is a subset of the "else" branch, so you =
could
merge both with a conditional. If you prefer not to, then it probably
makes sense to change the whole block to a switch/case construct.

--=20
Jean Delvare
SUSE L3 Support

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
