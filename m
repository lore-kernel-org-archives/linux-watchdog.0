Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:64001 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaLRRUU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Dec 2014 12:20:20 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so4403275obc.0
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Dec 2014 09:20:19 -0800 (PST)
Date: Thu, 18 Dec 2014 17:20:12 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	arnd@arndb.de, David Paris <david.paris@st.com>
Subject: Re: [PATCH 6/8] watchdog: st_wdt: Add new driver for ST's LPC
 Watchdog
Message-ID: <20141218172012.GC4525@x1>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <1418834727-1602-7-git-send-email-lee.jones@linaro.org>
 <20141217180251.GA29914@roeck-us.net>
 <20141218082652.GP13885@x1>
 <20141218160014.GA16015@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141218160014.GA16015@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Dec 2014, Guenter Roeck wrote:

> On Thu, Dec 18, 2014 at 08:26:52AM +0000, Lee Jones wrote:
> > On Wed, 17 Dec 2014, Guenter Roeck wrote:
> > > On Wed, Dec 17, 2014 at 04:45:25PM +0000, Lee Jones wrote:
> > > > Signed-off-by: David Paris <david.paris@st.com>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > >=20
> > > Hi Lee and David,
> > >=20
> > > I still have a couple of comments below. Sorry I didn't catch those=
 earlier.
> > >=20
> > > Thanks,
> > > Guenter
> > >=20
> > > > ---
> > > >  drivers/watchdog/Kconfig  |  13 ++
> > > >  drivers/watchdog/Makefile |   1 +
> > > >  drivers/watchdog/st_wdt.c | 323 ++++++++++++++++++++++++++++++++=
++++++++++++++
> > > >  3 files changed, 337 insertions(+)
> > > >  create mode 100644 drivers/watchdog/st_wdt.c
> >=20
> > Chopping all the crud.
> >=20
> > [...]
> >=20
> > > > +static struct of_device_id st_wdog_match[] =3D {
> > > > +	{
> > > > +		.compatible =3D "st,stih407-lpc",
> > > > +		.data =3D (void *)&stih407_syscfg,
> > >=20
> > > Nitpick: typecast to and from void * is not necessary.
> >=20
> > Actually that's not true, but it is superfluous in this case.
> >=20
> Point taken. Would you agree to a more detailed "typecasting a pointer
> to and from void * is not necessary" ?

Sure, why not? ;)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
