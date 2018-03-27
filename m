Return-Path: <marcus.folkesson@gmail.com>
Return-path: <marcus.folkesson@gmail.com>
Date: Tue, 27 Mar 2018 13:17:14 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: core: add option to make timeouts read-only
Message-ID: <20180327111616.GA5286@gmail.com>
References: <20180327080941.29235-1-marcus.folkesson@gmail.com>
 <20180327080941.29235-2-marcus.folkesson@gmail.com>
 <2e013403-7922-3309-3d17-0a9b757faa9c@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <2e013403-7922-3309-3d17-0a9b757faa9c@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 03:37:04AM -0700, Guenter Roeck wrote:
> On 03/27/2018 01:09 AM, Marcus Folkesson wrote:
> > Some systems may not allow applications to configure the watchdog
> > timer at all. This restriction is not limited to stop the watchdog,
> > but also change timeouts as well.
> >=20
> > This adds a kernel parameter to disable the ability to change the
> > watchdog timouts from userspace.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>=20
> I don't believe that this would be a watchdog-only problem. Those users p=
robably

It is not, and I agree that the whole requirement is a bit fuzzy.
The requesters reference is a small system with a dedicaded MCU, and tries =
to
apply the same requirements on a Linux system without really understand
what it means.

> want lots of other things read-only. If they don't, and if this is really=
 a watchdog
> specific request, I don't think they know what they are talking about. Be=
sides,
> one can bypass it by unloading/reloading the drivers, so I don't really g=
et the
> point.
>=20
> Are the requesters of this feature aware that, with the permissions neces=
sary
> to change a watchdog timeout, it is possible to do lots of things, such a=
s,
> say, reboot the system ? Or cause a crash ? Is that less critical ?

It is not possible to login to these systems. The requirement is, what I
can tell, only to restrict applications (which could be external)
to modify the timeout. Reboots and systems crashes seems to be okay.

Strain out a gnat but swallow a camel, I know.

>=20
> I would _really_ want to see a more detailed case made than "some users w=
ant it"
> before agreeing to a change like this.

I guess my only case is "some users want it" for now.

The fact that I have seen such a formulated requirement in two
independent projects made me submit it upstreams.

If I overlook the paranoid requirement, I think it could be useful to
guarantee that the timeout set by bootloader (bootargs) or devicetree is
the value that is used and not overridden.

But again, it is something that "some users may want".

>=20
> Guenter
>=20

Best regards
Marcus Folkesson

> > ---
> >   drivers/watchdog/Kconfig        |  9 +++++++++
> >   drivers/watchdog/watchdog_dev.c | 12 ++++++++++--
> >   2 files changed, 19 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index aff773bcebdb..bcba48b5c88b 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -46,6 +46,15 @@ config WATCHDOG_NOWAYOUT
> >   	  get killed. If you say Y here, the watchdog cannot be stopped once
> >   	  it has been started.
> > +config WATCHDOG_TIMEOUT_READONLY
> > +	bool "Make timeouts read-only from userspace"
> > +	help
> > +	  Say Y here if you want the watchdog timeout/pretimeout to be read-o=
nly
> > +	  from userspace. This requires that the timeout is configured before
> > +	  userspace takes over.
> > +
> > +	  Say N if you are unsure.
> > +
> >   config WATCHDOG_HANDLE_BOOT_ENABLED
> >   	bool "Update boot-enabled watchdog until userspace takes over"
> >   	default y
> > diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdo=
g_dev.c
> > index ffbdc4642ea5..6064806a2a8d 100644
> > --- a/drivers/watchdog/watchdog_dev.c
> > +++ b/drivers/watchdog/watchdog_dev.c
> > @@ -87,6 +87,9 @@ static struct kthread_worker *watchdog_kworker;
> >   static bool handle_boot_enabled =3D
> >   	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
> > +static bool timeout_is_readonly =3D
> > +	IS_ENABLED(CONFIG_WATCHDOG_TIMEOUT_READONLY);
> > +
> >   static inline bool watchdog_need_worker(struct watchdog_device *wdd)
> >   {
> >   	/* All variables in milli-seconds */
> > @@ -359,7 +362,7 @@ static int watchdog_set_timeout(struct watchdog_dev=
ice *wdd,
> >   {
> >   	int err =3D 0;
> > -	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
> > +	if (!(wdd->info->options & WDIOF_SETTIMEOUT) || timeout_is_readonly)
> >   		return -EOPNOTSUPP;
> >   	if (watchdog_timeout_invalid(wdd, timeout))
> > @@ -390,7 +393,7 @@ static int watchdog_set_pretimeout(struct watchdog_=
device *wdd,
> >   {
> >   	int err =3D 0;
> > -	if (!(wdd->info->options & WDIOF_PRETIMEOUT))
> > +	if (!(wdd->info->options & WDIOF_PRETIMEOUT) || timeout_is_readonly)
> >   		return -EOPNOTSUPP;
> >   	if (watchdog_pretimeout_invalid(wdd, timeout))
> > @@ -1181,3 +1184,8 @@ module_param(handle_boot_enabled, bool, 0444);
> >   MODULE_PARM_DESC(handle_boot_enabled,
> >   	"Watchdog core auto-updates boot enabled watchdogs before userspace =
takes over (default=3D"
> >   	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")"=
);
> > +
> > +module_param(timeout_is_readonly, bool, 0444);
> > +MODULE_PARM_DESC(timeout_is_readonly,
> > +	"Watchdog timeouts is readonly from userspace (default=3D"
> > +	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_TIMEOUT_READONLY)) ")");
> >=20
>=20

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlq6KDUACgkQiIBOb1ld
UjIpBRAAzrZlfTKHHGp4MJUgYlaKv1G9PAuDUVwTSeVXWrVDcyhibbv/93DxRl7F
pBBhcskECgNSG5aZLyxJMJa5rH/zWL3WyU7XBEPhRkREYMn/Hr9u8ljFwZH7iABm
NhzdnvfXx6pE/Yjq9uyCm621PmUwpuV2GFWwOHppg9o3JmXKoXri3D6mlPBOEl33
1Qys17/zaExG0i4cPo1BwqLKyWZb6/RpFNbaPkUczuLXVMLxR/eAX4yUhGZ8Pq2T
m6EnxK/2GPundt1mnWt4ICjGmxi7dck4t4sSEIdWqlOPgM2+G3hPPQRWNVDQPUTL
PjEg34jfAIadT8fmAFyKFYQcD122HvTr8su5ck77EGvZveYBsTZcqFSg84U3e+D3
IygnIoXIhJEM7ZyA9Ml2njBP5dRMqj6gqY0h3qZseZrouQdIyiy+T+jMgnbugvP4
/9oYw1GH2xwT+ibnHrc0Dy7MbiPyYwb1mSLY+OdNQODXhuOar3PNK87nx8t3bGT3
gn6+Ufh3E/KuvJ8VN1s59BXZ2+rr9hkMzFuehKZ4s9ZPJKHI7n+sbLAjJ7dvD9K6
lx+ihTEmUjItoMLQ+d79NmfF4FLcJkhG36vUf1TEJZGZEn5KemSwN1H+tWMecv77
Yt1o3OpK53rVKyGbcLkTw1GTnOHXWoh4f/ZPP/Ije4pEIPMfVa8=
=Pvfj
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
