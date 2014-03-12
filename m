Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60440 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752137AbaCLJUI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 05:20:08 -0400
Date: Wed, 12 Mar 2014 10:16:49 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
Message-ID: <20140312091649.GU2815@lukather>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140303104042.GU607@lukather>
 <20140311205405.GA10228@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PSXRUCbmiibGgnYg"
Content-Disposition: inline
In-Reply-To: <20140311205405.GA10228@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--PSXRUCbmiibGgnYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Tue, Mar 11, 2014 at 09:54:05PM +0100, Wim Van Sebroeck wrote:
> > On Fri, Feb 07, 2014 at 10:29:23PM +0100, Maxime Ripard wrote:
> > > Hi,
> > >=20
> > > This is the second version of the A10 watchdog compatible changes.
> > > The only difference with the v1 being that we're now droping the old
> > > compatibles, instead of keeping them, since the DT maintainers said i=
t was
> > > fine.
> > >=20
> > > Thanks,
> > > Maxime
> > >=20
> > > Maxime Ripard (3):
> > >   watchdog: sunxi: Change compatibles
> > >   ARM: sunxi: Add the new watchog compatibles to the reboot code
> > >   ARM: sunxi: dt: Update the watchdog compatibles
> >=20
> > Ping?
>=20
> I'm OK with the patches, but what is the preferred way to get them upstre=
am?
> via watchdog tree or via arch/soc tree?

Since it touches the machine restart code, I'd prefer to merge it
myself if it's ok?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--PSXRUCbmiibGgnYg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTICYBAAoJEBx+YmzsjxAgkMQP/RQrU/Q/WXlTV4iInQveaSBD
P7QgFRRs92UcaNt53Kp9Lm/eRmE7vhF0RzZ8oiHOW8dh7gwQcP4MVFDQYZZCqyIG
/4wabAb9dmUXF0tOdNqaiUIJm2iQZLPEDv92uEs+bfFOsSEbLunrfRPwhLbqUJWh
Lzgi1u4E6YbvhuYdXhpfKZUTk4n9q8JiqfcoKT6wKNKw0959iilPLjyWP3B+nWjp
KuX1HysVOVRJQ6bPfmsOU7i4Fdinl79U5+BtjSqXMCIO+ZyZ83kT/CawgO8p/ObX
v/b7hBg/E2s+UPOWtOL5hat3WxAFZvrV/38n3jnZcoAzDLyWBskHPrSzpfkwfdgI
WLHwrNqtTfPoTJmbjrw+7EqlqnP4fuIwgB32ZseTbJSuiBRDcjiuwbcMnoWbQi37
2Te74O08hf+mcdA1wB9YbUelCKmTLimMcA39gPVSGsc0/ehpe+W10vbQIfsDpbbW
Bzgq2QxRzbI0/KaXLi6hZzGtaIHddByfkOI+CSVqL7REJGv1t/TlU6x6u1EOUPw0
fo0tPNtN+20ZBk+EJqJYD0vj+QdGpgjn/VFBKBXeU1HsrfpDFq/bmkBWTD6MzdL6
sfzpd28iH9IacNrTRZ/9hMEkNrLh4EOY0H4P5SSEOAoFNxTqJXDNckcoaR5pOcUy
gCzJQ1Eue96Rn2oSeYeo
=V/bT
-----END PGP SIGNATURE-----

--PSXRUCbmiibGgnYg--
