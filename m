Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37030 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbG2Kpy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 06:45:54 -0400
Received: by wibud3 with SMTP id ud3so20140344wib.0
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2015 03:45:53 -0700 (PDT)
Date: Wed, 29 Jul 2015 11:45:50 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] iTCO_wdt: Add support for TCO on Intel Sunrisepoint
Message-ID: <20150729104550.GG2773@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-4-git-send-email-matt@codeblueprint.co.uk>
 <1438103021.24962.46.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1438103021.24962.46.camel@chaos.site>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 28 Jul, at 07:03:41PM, Jean Delvare wrote:
> Hi Matt,
>=20
> Le Monday 27 July 2015 =E0 14:38 +0100, Matt Fleming a =E9crit :
> > From: Matt Fleming <matt.fleming@intel.com>
> >=20
> > The revision of the watchdog hardware in Sunrisepoint necessitates =
a new
> > "version" inside the TCO watchdog driver because some of the regist=
er
> > layouts have changed.
> >=20
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> > ---
> >  drivers/watchdog/iTCO_wdt.c | 58 ++++++++++++++++++++++++++-------=
------------
> >  1 file changed, 34 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wd=
t.c
> > index 9a6e70976f64..17dfbc51b85a 100644
> > --- a/drivers/watchdog/iTCO_wdt.c
> > +++ b/drivers/watchdog/iTCO_wdt.c
> > (...)=20
> > @@ -503,7 +510,10 @@ static int iTCO_wdt_probe(struct platform_devi=
ce *dev)
> >  		pdata->name, pdata->iTCO_version, (u64)TCOBASE);
> > =20
> >  	/* Clear out the (probably old) status */
> > -	if (iTCO_wdt_private.iTCO_version =3D=3D 3) {
> > +	if (iTCO_wdt_private.iTCO_version =3D=3D 4) {
> > +		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
> > +		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
> > +	} else if (iTCO_wdt_private.iTCO_version =3D=3D 3) {
> >  		outl(0x20008, TCO1_STS);
> >  	} else {
> >  		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
>=20
> The "version =3D=3D 4" branch is a subset of the "else" branch, so yo=
u could
> merge both with a conditional. If you prefer not to, then it probably
> makes sense to change the whole block to a switch/case construct.

I think the switch/case construct is the right choice here. I'll make t=
he
update, thanks.

--=20
Matt Fleming, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
