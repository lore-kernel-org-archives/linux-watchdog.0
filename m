Return-path: <wsa@the-dreams.de>
Date: Thu, 6 Aug 2015 23:08:17 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Lee Jones <lee.jones@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH v3 3/3] iTCO_wdt: Add support for TCO on Intel
 Sunrisepoint
Message-ID: <20150806210817.GB1523@katana>
References: <1438293541-26131-1-git-send-email-matt@codeblueprint.co.uk>
 <1438293541-26131-4-git-send-email-matt@codeblueprint.co.uk>
 <1438332064.29746.141.camel@linux.intel.com>
 <20150806120024.GG4332@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <20150806120024.GG4332@codeblueprint.co.uk>
List-ID: <linux-watchdog@vger.kernel.org>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 01:00:24PM +0100, Matt Fleming wrote:
> (Sorry for the delay in replying)
>=20
> On Fri, 31 Jul, at 11:41:04AM, Andy Shevchenko wrote:
> > > =20
> > > +	if (val32 & enable_bit)
> > > +		ret =3D -EIO;
> > > +
> > >  	return ret; /* returns: 0 =3D OK, -EIO =3D Error */
> >=20
> > What about removing ret at all?
> >=20
> > if (val32 & enable_bit)
> >  return -EIO;
> >=20
> > return 0;
> =20
> Yeah, good catch. I'll make this change.

I'd go for the ternary operator here.


--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVw8zBAAoJEBQN5MwUoCm2gAgQAJkpVWRO6RCQ4NFRdYbybRYq
CX5Ya8zvs61T/mnfxiuNl7CC83mNtDizkWTVmtH5wfmqcrd4D3tNwTMPs5i3zTQT
znuzkGwWcUkDHNGS07fNoO7jwWAb9cJaqfc4iGA9WC2UYnsNNCFHDFb0WNTqq1Ci
gYYeQInWBELMpD5m7/4mlwFiCL4D/q7sH0pNknPxWgHpU351+BbinIIy3+6OJgIU
vMwAvBCs4BYPjHYQ3mMTQ56Pr9aouXGyC1OJBMm6jU7p7QDutkqlGhIEh9amVQwH
WTb7570K8pN1Rn3+c09P0qmmCm1pOwrE8/93rrzsImMngOc9BhSAd2SFeDNujE+Z
FNESIS+QVIxP3d7wXMdECdrgQ3jTf9/pIq82vCaynJggdWAcd32KvuRC7WFuUZ/7
Ln7FChJXUIIGB3j/Cx/6C0Oq/6kdnLQC6e+adXAObort7ZOrgjp5ATscvl5sjvsU
QhsvRGz8l+H4i7t3WbE4+2ilDRrxZGojo1/QJr4YF1SYoHCkZOZnj9H+u5qrN8LN
2njeRca6EBUaRSuQYJ4pCAHwGbcl+89ABuzn2I1s0kAJx6ZYpE0QGWETRMZuKWbk
UJ7PKlcSRrXXhc3fDqW6mOg6XzRGJUC/y7Kic2yG7vkwCp3aPR7eLPDyePLWcKHy
N6VDaBrraDXfOsD8U8vk
=CY8Q
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
