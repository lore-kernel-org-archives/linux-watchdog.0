Return-Path: <wsa@the-dreams.de>
Return-path: <wsa@the-dreams.de>
Date: Tue, 27 Feb 2018 14:00:58 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH] watchdog: renesas_wdt: adapt timer setup to recommended
 procedure
Message-ID: <20180227130058.pmgo33zjvbxwmlad@ninjato>
References: <20180226214905.24516-1-wsa+renesas@sang-engineering.com>
 <20180226223853.GC5924@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wdcknwr5tcfgindy"
Content-Disposition: inline
In-Reply-To: <20180226223853.GC5924@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--wdcknwr5tcfgindy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > -	rwdt_write(priv, 0, RWTCSRB);
> > -	rwdt_write(priv, priv->cks, RWTCSRA);
>=20
> Isn't this done implicitly with the above already ?
> After all, priv->cks won't have RWTCSRA_TME set.

Yes. The request came from a group doing some (safety?) audit who didn't
like the implicit handling which might change if the code in probe()
might change somewhen. And the datasheet explicitly says to disable the
timer first before doing anything with the clock dividers. Given that, I
can agree to this change, too.


--wdcknwr5tcfgindy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqVVokACgkQFA3kzBSg
KbY68A//Wvm0bGfPGu1bO144VJTqBEuuInR34ZyC60UnJpm8Fubjrsz9K3TaZkac
AJDmwUr9z5rrfPmammk482ZkSuGAU9Db+g/QxKfr5Tl9/qTgvaSeuJNa467jytLc
tpa9jT4Va8wmweS2qojCXElofLtWVBZ6a4yGlzYA6ek+hMZt+J1I5JOi/JDWt6IF
G0kpoQjpNJk7lLIELv0Heyf/tZ8//xw6/K0uovHf5CTRRfjMQLaLBEb8ez0R8lpC
gvgT+FCGqNjYSEIUtqiE8mUvEL7Wv87CzkvC85GcaT4EeprgPnikN2NqfYmNuYEe
Jnv1TFuYQzkSije0mE/NjQNCd7o/uD7/pck4a3UbT5BCBwRLsueOqsFrz2wvQQ8P
1hQW6wdqixg//l+7e2BtcKrPnp7nuRnfmliKH3PE+5b0g5Pch+P3+fT+Lg6Uudss
3TTPEe5WopGmrFPaNPYaGjxzIDDGZyjadqP0WvddrFCbKx0Zhuzvx/GeH4ZsUKZM
5dV8JZeAh0H+pbVcWLLx/wFAAnhKQbAb805ckcTO9vdOVqDaGQjhww9ObeX5XzVV
p1NlTc/ZrrIvDOUDwNByjteSgXtMmH2Le6q84XUuuHF26CFQWCwCcka6m0Vt3kxz
NxUWhtGfWi8055Ua4l5tAFodUP/qPa5DQTR0mMOCnXWH7ppWPeU=
=bEGr
-----END PGP SIGNATURE-----

--wdcknwr5tcfgindy--
