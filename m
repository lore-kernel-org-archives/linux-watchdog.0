Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51535 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbdC2QXw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 12:23:52 -0400
Date: Wed, 29 Mar 2017 09:23:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, kernel@pengutronix.de,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: orion: make license info match the file header
Message-ID: <20170329162348.GA12249@roeck-us.net>
References: <20170329153424.20809-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170329153424.20809-1-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 05:34:24PM +0200, Uwe Kleine-K=F6nig wrote:
> The header says: This file is licensed under the terms of the GNU
> General Public License version 2. The right identifier for
> MODULE_LICENSE is "GPL v2" then.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/orion_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.=
c
> index 39be4dd8035e..83af7d6cc37c 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -651,5 +651,5 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (d=
efault=3D"
>  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> =20
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:orion_wdt");
> --=20
> 2.11.0
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
