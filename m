Return-path: <tomas.winkler@intel.com>
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wim Van Sebroeck
	<wim@iguana.be>, "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next, v4, 5/7] watchdog: mei_wdt: register wd device
 only if required
Date: Sun, 17 Jan 2016 20:54:58 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B54139E08@hasmsx108.ger.corp.intel.com>
References: <1452206967-1144-6-git-send-email-tomas.winkler@intel.com>
 <20160117171308.GA10264@roeck-us.net>
In-Reply-To: <20160117171308.GA10264@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>



> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Sunday, January 17, 2016 19:13
> To: Winkler, Tomas
> Cc: Greg Kroah-Hartman; Wim Van Sebroeck; Usyskin, Alexander; linux-
> watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [char-misc-next, v4, 5/7] watchdog: mei_wdt: register wd dev=
ice only
> if required
>=20
> Hi Tomas,
>=20
> On Fri, Jan 08, 2016 at 12:49:25AM +0200, Winkler, Tomas wrote:
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > For Intel Broadwell and newer platforms, the ME device can inform
> > the host whether the watchdog functionality is activated or not.
> > If the watchdog functionality is not activated then the watchdog interf=
ace
> > can be not registered and eliminate unnecessary pings and hence lower t=
he
> > power consumption by avoiding waking up the device.
> > The feature can be deactivated also without reboot
> > in that case the watchdog device should be unregistered at runtime.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> > V2: rework unregistration
> > V3: rebase; implement unregistraion also at runtime
> > V4: Rebase the code over patchset : "watchdog: Replace driver based
> refcounting"
> >
> >  drivers/watchdog/mei_wdt.c | 196
> ++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 187 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> > index e7e3f144f2b0..85b27fc5d4ec 100644
> > --- a/drivers/watchdog/mei_wdt.c
> > +++ b/drivers/watchdog/mei_wdt.c
> >
> [ ... ]
>=20
> > +static void mei_wdt_unregister_work(struct work_struct *work)
> > +{
> > +	struct mei_wdt *wdt =3D container_of(work, struct mei_wdt, unregister=
);
> > +
> > +	mei_wdt_unregister(wdt);
> > +}
>=20
> Registration is synchronous, unregistration is asynchronous.
>=20
> Assuming that is on purpose, I think it warrants an explanation.
>=20
The unregistration is detected on response from the  ping, which is run und=
er same mutex as unregistration.
Tomas
