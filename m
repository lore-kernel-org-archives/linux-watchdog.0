Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59316 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752539AbaBXTva (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 14:51:30 -0500
Date: Mon, 24 Feb 2014 20:51:27 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: scottwood@freescale.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] watchdog: mpc8xxx_wdt: MPC8xx is HW enabled
Message-ID: <20140224195127.GA20712@spo001.leaseweb.com>
References: <20131130154540.E83D743E15@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20131130154540.E83D743E15@localhost.localdomain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Christophe,

> MPC8xx watchdog is enabled at startup by HW.
> If the bootloader disables it, it cannot be reenabled.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> diff -ur a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_=
wdt.c
> --- a/drivers/watchdog/mpc8xxx_wdt.c	2013-05-11 22:57:46.000000000 +0=
200
> +++ b/drivers/watchdog/mpc8xxx_wdt.c	2013-08-08 02:12:15.000000000 +0=
200
> @@ -273,6 +310,7 @@
>  		.compatible =3D "fsl,mpc823-wdt",
>  		.data =3D &(struct mpc8xxx_wdt_type) {
>  			.prescaler =3D 0x800,
> +			.hw_enabled =3D true,
>  		},
>  	},
>  	{},
>=20
> ---
> Ce courrier =E9lectronique ne contient aucun virus ou logiciel malvei=
llant parce que la protection avast! Antivirus est active.
> http://www.avast.com
>=20

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
