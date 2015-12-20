Return-path: <tomas.winkler@intel.com>
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Wim Van Sebroeck <wim@iguana.be>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next 4/7] watchdog: mei_wdt: add status debugfs entry
Date: Sun, 20 Dec 2015 09:44:05 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B540EE5A6@hasmsx108.ger.corp.intel.com>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
 <1450363780-30008-5-git-send-email-tomas.winkler@intel.com>
 <56743795.6090700@roeck-us.net>
In-Reply-To: <56743795.6090700@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>


> On 12/17/2015 06:49 AM, Tomas Winkler wrote:
> > Add entry for dumping current watchdog internal state
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >   drivers/watchdog/mei_wdt.c | 84
> ++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 84 insertions(+)
> >
> > diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> > index 3c97deb70d90..a3f1c1613c32 100644
> > --- a/drivers/watchdog/mei_wdt.c
> > +++ b/drivers/watchdog/mei_wdt.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/watchdog.h>
> > +#include <linux/debugfs.h>
> >
> >   #include <linux/uuid.h>
> >   #include <linux/mei_cl_bus.h>
> > @@ -54,6 +55,19 @@ enum mei_wdt_state {
> >   	MEI_WDT_STOPPING,
> >   };
> >
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +static const char *mei_wdt_state_str(enum mei_wdt_state state)
> > +{
> > +	switch (state) {
> > +	case MEI_WDT_IDLE: return "IDLE";
> > +	case MEI_WDT_START: return "START";
> > +	case MEI_WDT_RUNNING: return "RUNNING";
> > +	case MEI_WDT_STOPPING: return "STOPPING";
> > +	default: return "unknown";
>=20
> Doesn't this cause checkpatch warnings ?
It doesn't and also checkpatch.pl  is just a help tool.=20
>=20
> > +	}
> > +}
> > +#endif /* CONFIG_DEBUG_FS */
> > +
>=20
> Can you move this conditional code into the other #ifdef block below ?

I'm removing the ifdef in the following patch so this is just for this path=
 to not to spill warning the compilation w/o CONFIG_DEBUG_FS set.

	.start       =3D mei_wdt_ops_start,
> > @@ -348,6 +428,8 @@ static int mei_wdt_probe(struct mei_cl_device *clde=
v,
> >   	if (ret)
> >   		goto err_disable;
> >
> > +	dbgfs_register(wdt);
> > +
> >   	return 0;
> >
> >   err_disable:
> > @@ -367,6 +449,8 @@ static int mei_wdt_remove(struct mei_cl_device *cld=
ev)
> >
> >   	kref_put(&wdt->refcnt, mei_wdt_release);
> >
> > +	dbgfs_deregister(wdt);
> > +
>=20
> This should probably come before the call to kref_put() since it uses wdt=
.

Good catch, will resend.
Tomas

=20
