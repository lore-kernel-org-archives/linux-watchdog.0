Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42088 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752831AbaBQXnH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Feb 2014 18:43:07 -0500
Date: Mon, 17 Feb 2014 20:42:57 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 11/18] watchdog: orion: Add per-compatible watchdog
 start implementation
Message-ID: <20140217234256.GA28783@localhost>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392073237-2554-12-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140217210822.GC7862@titan.lakedaemon.net>
 <20140217211113.GD7862@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140217211113.GD7862@titan.lakedaemon.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 17, 2014 at 04:11:13PM -0500, Jason Cooper wrote:
> On Mon, Feb 17, 2014 at 04:08:22PM -0500, Jason Cooper wrote:
> > On Mon, Feb 10, 2014 at 08:00:30PM -0300, Ezequiel Garcia wrote:
> > > To handle differences between SoCs this commit adds per-compatibl=
e
> > > string start() function for the watchdog kick-off. This is prepar=
ation
> > > work and makes no functionality changes to the current driver.
> > >=20
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com=
>
> > > Tested-by: Willy Tarreau <w@1wt.eu>
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.co=
m>
> > > ---
> > >  drivers/watchdog/orion_wdt.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orio=
n_wdt.c
> > > index b48fd08..3925297 100644
> > > --- a/drivers/watchdog/orion_wdt.c
> > > +++ b/drivers/watchdog/orion_wdt.c
> > > @@ -50,6 +50,7 @@ struct orion_watchdog_data {
> > >  	int rstout_enable_bit;
> >=20
> >=20
> > >  	int (*clock_init)(struct platform_device *,
> > >  			  struct orion_watchdog *);
> >=20
> > this...
> >=20
> > > +	int (*start)(struct watchdog_device *);
> > >  };
> > > =20
> > >  struct orion_watchdog {
> > ...
> > > @@ -193,6 +202,7 @@ static const struct orion_watchdog_data orion=
_data =3D {
> > >  	.wdt_enable_bit =3D BIT(4),
> > >  	.wdt_counter_offset =3D 0x24,
> >=20
> >=20
> > >  	.clock_init =3D orion_wdt_clock_init,
> >=20
> > and this...
> >=20
> > > +	.start =3D orion_start,
> > >  };
> >=20
> > cause a failure to apply the patch.  I hand-jammed it (attached), p=
lease
> > let me know what is going on here (missed dep?)
>=20
> disregard.  I missed patch 10.  It helps.  :)
>=20

Phhheeew... my heart stopped for a minute ;-)
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
