Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36562 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbG1Lh0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 07:37:26 -0400
Received: by wicgb10 with SMTP id gb10so152375184wic.1
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 04:37:25 -0700 (PDT)
Date: Tue, 28 Jul 2015 12:37:21 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150728113721.GU14943@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150728110717.GH2492@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 28 Jul 2015, Matt Fleming wrote:

> On Tue, 28 Jul, at 10:46:43AM, Lee Jones wrote:
> > On Mon, 27 Jul 2015, Matt Fleming wrote:
> >=20
> > > From: Matt Fleming <matt.fleming@intel.com>
> > >=20
> > > Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible=
 across
> > > the SMBus, unlike previous generations of PCH/ICH where it was on=
 the
> > > LPC bus. Because it's on the SMBus, it doesn't make sense to pass=
 around
> > > a 'struct lpc_ich_info', and leaking the type of bus into the iTC=
O
> > > watchdog driver is kind of backwards anyway.
> > >=20
> > > This change introduces a new 'struct iTCO_wdt_platform_data' for =
use
> > > inside the iTCO watchdog driver and by the upcoming Intel Sunrise=
point
> > > code, which neatly avoids having to include lpc_ich headers in th=
e i801
> > > i2c driver.
> > >=20
> > > A simple translation layer is provided for converting from the ex=
isting
> > > 'struct lpc_ich_info' inside the lpc_ich mfd driver.
> > >=20
> > > Cc: Peter Tyser <ptyser@xes-inc.com>
> > > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Wim Van Sebroeck <wim@iguana.be>
> > > Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> > > ---
> > >  drivers/mfd/lpc_ich.c                  | 32 ++++++++++++++++++++=
+++++++++---
> > >  drivers/watchdog/Kconfig               |  2 +-
> > >  drivers/watchdog/iTCO_wdt.c            | 11 +++++------
> > >  include/linux/mfd/lpc_ich.h            |  6 ------
> > >  include/linux/platform_data/iTCO_wdt.h | 18 ++++++++++++++++++
> > >  5 files changed, 53 insertions(+), 16 deletions(-)
> > >  create mode 100644 include/linux/platform_data/iTCO_wdt.h
> > >=20
> > > diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> > > index 8de34398abc0..d190b74a6321 100644
> > > --- a/drivers/mfd/lpc_ich.c
> > > +++ b/drivers/mfd/lpc_ich.c
> > > @@ -66,6 +66,7 @@
> > >  #include <linux/pci.h>
> > >  #include <linux/mfd/core.h>
> > >  #include <linux/mfd/lpc_ich.h>
> > > +#include <linux/platform_data/iTCO_wdt.h>
> >=20
> > Lowercase please.
> =20
> Even though the driver is called iTCO_wdt? It seemed to me to be more
> confusing to start mixing cases rather than sticking with the ugly up=
per
> case. Especially since when you look in the iTCO_wdt driver all the
> function and type names are written that way.

The driver shouldn't be called that either.

You are the only one.  What makes iTCO 'special'?

$ ls drivers/watchdog/ | grep [A-Z]
 iTCO_vendor.h
 iTCO_vendor_support.c
 iTCO_wdt.c
 Kconfig
 Makefile

Mixed case names (filenames, variables, etc) are frowned upon and
shouldn't be allowed anywhere.  Please read Chapter 4 of
Documentation/CodingStyle.

> > >  #define ACPIBASE		0x40
> > >  #define ACPIBASE_GPE_OFF	0x28
> > > @@ -835,9 +836,31 @@ static void lpc_ich_enable_pmc_space(struct =
pci_dev *dev)
> > >  	priv->actrl_pbase_save =3D reg_save;
> > >  }
> > > =20
> > > -static void lpc_ich_finalize_cell(struct pci_dev *dev, struct mf=
d_cell *cell)
> > > +static int lpc_ich_finalize_wdt_cell(struct pci_dev *dev)
> > >  {
> > > +	struct iTCO_wdt_platform_data *pdata;
> >=20
> > Lowercase please.
> =20
> See above.

Likewise. ;)

> > >  	struct lpc_ich_priv *priv =3D pci_get_drvdata(dev);
> > > +	struct lpc_ich_info *info;
> > > +	struct mfd_cell *cell =3D &lpc_ich_cells[LPC_WDT];
> > > +
> > > +	pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> > > +	if (!pdata)
> > > +		return -ENOMEM;
> >=20
> > Where is this freed?
> >=20
> > Better to use devm_*
> =20
> Yeah, Guenter caught this too. devm_* would definitely be better.

Great.

> > > +	info =3D &lpc_chipset_info[priv->chipset];
> > > +
> > > +	pdata->iTCO_version =3D info->iTCO_version;
> >=20
> > Lowercase please.
>=20
> Hmm... but then this line will read,
>=20
> 	pdata->itco_version =3D info->iTCO_version;
>=20
> I'm not sure that's an improvement.

Please consider making all of the variable names conform to the
coding standards we normally abide by.  You can submit it either as
patch 1 of this set, or independently.

> > > +	strcpy(pdata->name, info->name);
> >=20
> > strncpy() is safer.
> =20
> OK, I'll update this. Though it's worth pointing out that the name[]
> declarations are of identical size in these two objects (but I guess
> that could change in the future).

Better to err on the side of caution.

> > > +	cell->platform_data =3D pdata;
> > > +	cell->pdata_size =3D sizeof(*pdata);
> > > +	return 0;
> > > +}
> > > +
> > > +static void lpc_ich_finalize_gpio_cell(struct pci_dev *dev)
> > > +{
> > > +	struct lpc_ich_priv *priv =3D pci_get_drvdata(dev);
> > > +	struct mfd_cell *cell =3D &lpc_ich_cells[LPC_GPIO];
> > > =20
> > >  	cell->platform_data =3D &lpc_chipset_info[priv->chipset];
> > >  	cell->pdata_size =3D sizeof(struct lpc_ich_info);
> >=20
> > It's pretty hard to tell from the patch without applying it, but wh=
at
> > are the actual similarities and differences between the two finalis=
e
> > functions?  They looks like they share enough lines for it to make
> > sense to have one function call and do different things in say a
> > switch statement, no?
> =20
> For LPC_WDT we dynamically allocate the platform data, and for LPC_GP=
IO
> we use the static lpc_chipsec_info array.
>=20
> I'm just personally not a fan of performing memory allocations from
> within switch statement bodies, which is why I implemented this as tw=
o
> separate finalize functions.

I'll assume this is okay, then take a look at the driver as a whole
once it's applied.

> > > @@ -933,7 +956,7 @@ gpe0_done:
> > >  	lpc_chipset_info[priv->chipset].use_gpio =3D ret;
> > >  	lpc_ich_enable_gpio_space(dev);
> > > =20
> > > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
> > > +	lpc_ich_finalize_gpio_cell(dev);
> > >  	ret =3D mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > >  			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
> > > =20
> > > @@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct pci_dev=
 *dev)
> > >  		res->end =3D base_addr + ACPIBASE_PMC_END;
> > >  	}
> > > =20
> > > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
> > > +	ret =3D lpc_ich_finalize_wdt_cell(dev);
> > > +	if (ret)
> > > +		goto wdt_done;
> > > +
> > >  	ret =3D mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > >  			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);
> >=20
> > Why do you have an mfd_add_devices() call for each device?
> =20
> Good question. This call has been present since March 2012 when suppo=
rt
> was first added for iTCO_wdt in commit 887c8ec7219f ("watchdog: Conve=
rt
> iTCO_wdt driver to mfd model").
>=20
> There's no good reason that I can see. Aaron?

Thanks for checking.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
