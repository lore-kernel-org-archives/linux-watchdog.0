Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17078 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752653AbaBYQHh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Feb 2014 11:07:37 -0500
Date: Tue, 25 Feb 2014 11:07:30 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, olof@lixom.net,
	festevam@gmail.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: orion_wdt: Use %pa to print 'phys_addr_t'
Message-ID: <20140225160729.GK1010@titan.lakedaemon.net>
References: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
 <20140224203352.GA21204@spo001.leaseweb.com>
 <20140225150947.GA22740@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20140225150947.GA22740@localhost>
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 25, 2014 at 12:09:48PM -0300, Ezequiel Garcia wrote:
> Jason,
>=20
> On Mon, Feb 24, 2014 at 09:33:52PM +0100, Wim Van Sebroeck wrote:
> > > When building an ARM multi_v7_defconfig with LPAE option selected=
 we get the
> > > following build warning:
> > >=20
> > > drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects =
argument of type 'unsigned int', but argument 4 has type 'phys_addr_t' =
[-Wformat=3D]
> > >=20
> > > Fix it by using %pa to print 'phys_addr_t'.
> > >=20
> > > Reported-by: Olof's autobuilder <build@lixom.net>
> > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > > ---
> > >  drivers/watchdog/orion_wdt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orio=
n_wdt.c
> > > index 15321aa..6f9b4c6 100644
> > > --- a/drivers/watchdog/orion_wdt.c
> > > +++ b/drivers/watchdog/orion_wdt.c
> > > @@ -269,7 +269,7 @@ static void __iomem *orion_wdt_ioremap_rstout=
(struct platform_device *pdev,
> > > =20
> > >  	rstout =3D internal_regs + ORION_RSTOUT_MASK_OFFSET;
> > > =20
> > > -	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg 0x%x\n", rs=
tout);
> > > +	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rs=
tout);
> > >  	return devm_ioremap(&pdev->dev, rstout, 0x4);
> > >  }
> > > =20
> > > --=20
> > > 1.8.1.2
> > >=20
> > >=20
> >=20
> > Acked-by me also, but can this also go via the mvebu tree (since th=
e patch that introduces this is also there=E0?
> >=20
>=20
> Can you pull this too? It's been acked by Wim and me.

Yep, I'll add it onto the stack.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
