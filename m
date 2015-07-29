Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36782 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbG2Pcc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 11:32:32 -0400
Received: by wicgb10 with SMTP id gb10so206076579wic.1
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2015 08:32:31 -0700 (PDT)
Date: Wed, 29 Jul 2015 16:32:26 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150729153226.GB9319@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <72454140.319490.1438109162683.JavaMail.zimbra@xes-inc.com>
 <20150729073841.GF2284@x1>
 <2115196252.256986.1438181571315.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <2115196252.256986.1438181571315.JavaMail.zimbra@xes-inc.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 29 Jul 2015, Aaron Sierra wrote:

> > From: "Lee Jones" <lee.jones@linaro.org>
> > Sent: Wednesday, July 29, 2015 2:38:41 AM
> >=20
> > On Tue, 28 Jul 2015, Aaron Sierra wrote:
> >=20
> > > > > > > @@ -933,7 +956,7 @@ gpe0_done:
> > > > > > >  	lpc_chipset_info[priv->chipset].use_gpio =3D ret;
> > > > > > >  	lpc_ich_enable_gpio_space(dev);
> > > > > > > =20
> > > > > > > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
> > > > > > > +	lpc_ich_finalize_gpio_cell(dev);
> > > > > > >  	ret =3D mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > > > > > >  			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
> > > > > > > =20
> > > > > > > @@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct=
 pci_dev
> > > > > > > *dev)
> > > > > > >  		res->end =3D base_addr + ACPIBASE_PMC_END;
> > > > > > >  	}
> > > > > > > =20
> > > > > > > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
> > > > > > > +	ret =3D lpc_ich_finalize_wdt_cell(dev);
> > > > > > > +	if (ret)
> > > > > > > +		goto wdt_done;
> > > > > > > +
> > > > > > >  	ret =3D mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > > > > > >  			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);
> > > > > >=20
> > > > > > Why do you have an mfd_add_devices() call for each device?
> > > > > =20
> > > > > Good question. This call has been present since March 2012 wh=
en support
> > > > > was first added for iTCO_wdt in commit 887c8ec7219f ("watchdo=
g: Convert
> > > > > iTCO_wdt driver to mfd model").
> > > > >=20
> > > > > There's no good reason that I can see. Aaron?
> > >=20
> > > I chose to call mfd_add_devices() in each device init function
> > > because I thought it was the easiest way to avoid registering an
> > > incomplete/invalid MFD cell should an error occur during init.
> > >=20
> > > That way device registration wouldn't be an all-or-nothing affair=
=2E
> > >=20
> > > Doesn't mfd_add_devices() bail out after the first unsuccessful
> > > mfd to platform device translation?
> >=20
> > Right, as it should.
> >=20
> > Under what circumstance would an error occur and you'd wish to carr=
y
> > on registering devices?
>=20
> Lee,
>=20
> The two devices that this driver is responsible for are conceptually
> independent; they simply are lumped together in one PCI device. No
> failure while preparing resources for the watchdog device should
> prevent the GPIO device from being registered.

This makes me think that perhaps this isn't an MFD at all then?

Perhaps I should invest some time to looking into that.

> The most common real world circumstance that I experience is when a
> BIOS reserves resources associated with the GPIO device, thus
> preventing the GPIO resources (ICH_RES_GPE0 and/or ICH_RES_GPIO) from
> being fully prepared.
>=20
> I have not experienced issues with the watchdog device, but a similar
> issue would exist if the RCBA were disabled in a "v2" device.
>=20
> It seems like a dangerous change to simply attempt to register both
> of these devices with a single call, when one or both of them could
> be incomplete.
>=20
> Perhaps your real issue with this driver structure is that these
> cells are elements of a single lpc_ich_cells array for no clear
> reason. If each had a dedicated mfd_cell variable, would that be
> more acceptable to you?
>=20
> -static struct mfd_cell lpc_ich_cells[] =3D {
> +static struct mfd_cell lpc_ich_wdt_cell =3D {
> ...
> +static struct mfd_cell lpc_ich_gpio_cell =3D {
>=20
> That would eliminate the need for the lpc_cells enum, too.

Yes, that would make more sense.  Also consider using mfd_add_device()
instead of mfd_add_devices(), as you are only attempting registration
for a single device.

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
