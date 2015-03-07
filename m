Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [212.85.155.42] ([212.85.155.42]:41895 "EHLO
	atreides.gradator.net" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbbCGLrK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Mar 2015 06:47:10 -0500
Date: Sat, 7 Mar 2015 12:46:08 +0100
From: Sylvain Rochet <gradator@gradator.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Mike Turquette <mturquette@linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Slaby <jslaby@suse.cz>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Message-ID: <20150307114608.GA30011@gradator.net>
References: <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
 <20150307091846.GN23367@worktop.ger.corp.intel.com>
 <20150307102056.GA28436@gradator.net>
 <20150307103939.GA17964@amd>
 <20150307110645.GW3989@piout.net>
 <20150307112932.GA1372@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20150307112932.GA1372@amd>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Mar 07, 2015 at 12:29:33PM +0100, Pavel Machek wrote:
> On Sat 2015-03-07 12:06:45, Alexandre Belloni wrote:
> > On 07/03/2015 at 11:39:39 +0100, Pavel Machek wrote :
> > > > The Atmel watchdog can't be stopped once it's started. This is actu=
ally=20
> > > > very useful so we can reset if suspend or resume failed, the only=
=20
> > > > drawback is that you have to wake up from time to time (e.g. by usi=
ng=20
> > > > the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.
> > >=20
> > > Yeah. So you do "echo mem > /sys/power/state", and few seconds/minutes
> > > after watchdog kills the system. But you did not ask for dead system,
> > > you asked for suspend.
> > >=20
> > > And while that behaviour is useful for you, I don't think it is
> > > exactly useful behaviour, nor it is the behaviour user would expect.
> > >=20
> >=20
> > I think you misunderstood, that is exactly the expected behaviour. This
> > is hardware defined. Once the watchdog is started, nobody can stop it.
> > Trying to change the mode register will result in a reset of the
> > SoC.
>=20
> Well, it boils down to "what is stronger". Desire to suspend the
> system, or desire to reboot the system.
>=20
> It is "echo mem > state", not "echo reboot > state".

Maybe we should warn the watchdog is enabled and the system is going to=20
reboot if nothing woke-up the system before the watchdog expire, but the=20
maximum watchdog is 16s so it can't get unnoticed during development, I=20
am confident embedded engineers are smart enough to understand what is=20
happening without a displayed warning :-)


> > It is documented in the datasheet and any user wanting another behaviour
> > is out of luck.
>=20
> Actaully, your platform should just refuse to enter suspend-to-RAM
> when hw watchdog is enabled.

Yeah that's what I said, hardware watchdog or suspend: chose one or use=20
the software watchdog instead or "hack" around the way I am doing ;-)


Sylvain

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlT65QAACgkQDFub3qtEsS8O0ACfR46nrt7tdgk+tEtgoUM2nDkr
B8AAn1YNZvOiEnAxkPdxMaUqAu2Lh1+u
=IEKt
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
