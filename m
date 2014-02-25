Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60819 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752810AbaBYPJt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Feb 2014 10:09:49 -0500
Date: Tue, 25 Feb 2014 12:09:48 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, olof@lixom.net,
	festevam@gmail.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: orion_wdt: Use %pa to print 'phys_addr_t'
Message-ID: <20140225150947.GA22740@localhost>
References: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
 <20140224203352.GA21204@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140224203352.GA21204@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Jason,

On Mon, Feb 24, 2014 at 09:33:52PM +0100, Wim Van Sebroeck wrote:
> > When building an ARM multi_v7_defconfig with LPAE option selected we =
get the
> > following build warning:
> >=20
> > drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects argu=
ment of type 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wfor=
mat=3D]
> >=20
> > Fix it by using %pa to print 'phys_addr_t'.
> >=20
> > Reported-by: Olof's autobuilder <build@lixom.net>
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> >  drivers/watchdog/orion_wdt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wd=
t.c
> > index 15321aa..6f9b4c6 100644
> > --- a/drivers/watchdog/orion_wdt.c
> > +++ b/drivers/watchdog/orion_wdt.c
> > @@ -269,7 +269,7 @@ static void __iomem *orion_wdt_ioremap_rstout(str=
uct platform_device *pdev,
> > =20
> >  	rstout =3D internal_regs + ORION_RSTOUT_MASK_OFFSET;
> > =20
> > -	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg 0x%x\n", rstout=
);
> > +	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rstout=
);
> >  	return devm_ioremap(&pdev->dev, rstout, 0x4);
> >  }
> > =20
> > --=20
> > 1.8.1.2
> >=20
> >=20
>=20
> Acked-by me also, but can this also go via the mvebu tree (since the pa=
tch that introduces this is also there=C3=A0?
>=20

Can you pull this too? It's been acked by Wim and me.

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
