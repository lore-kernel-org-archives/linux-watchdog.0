Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58125 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935324AbeE2QKO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 May 2018 12:10:14 -0400
Date: Tue, 29 May 2018 09:10:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?utf-8?B?0JrQvtGH0LXRgtC60L7QsiDQnNCw0LrRgdC40Lw=?=
        <fido_max@inbox.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: orion_wdt: add wdt status init for
 handle_boot_enabled
Message-ID: <20180529161012.GA2162@roeck-us.net>
References: <1527596458.557657346@f479.i.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1527596458.557657346@f479.i.mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 29, 2018 at 03:20:58PM +0300, =D0=9A=D0=BE=D1=87=D0=B5=D1=82=D0=
=BA=D0=BE=D0=B2 =D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC wrote:
> This patch add init of wdt.status for CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED
>=20
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
> --- a/drivers/watchdog/orion_wdt.c.orig	2018-04-19 09:54:12.000000000 +03=
00
> +++ b/drivers/watchdog/orion_wdt.c	2018-05-29 15:00:29.560000000 +0300
> @@ -581,6 +581,8 @@ static int orion_wdt_probe(struct platfo
>  	 */
>  	if (!orion_wdt_enabled(&dev->wdt))
>  		orion_wdt_stop(&dev->wdt);
> +	else
> +		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
> =20
>  	/* Request the IRQ only after the watchdog is disabled */
>  	irq =3D platform_get_irq(pdev, 0);N?????r??y????b?X??=C7=A7v?^?)=DE=BA{=
=2En?+????{???\?? ?{ay?=1D=CA=87=DA=99?,j=07??f???h???z?=1E?w???=0C???j:+v?=
??w?j?m????=07????zZ+?????=DD=A2j"??!

Corrupted patch.

Guenter
