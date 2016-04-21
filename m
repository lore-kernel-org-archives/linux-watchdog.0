Return-path: <linux@rempel-privat.de>
Subject: Re: watchdoug group ping
To: Guenter Roeck <linux@roeck-us.net>,
 "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel@de.bosch.com>,
 linux-watchdog@vger.kernel.org, "Dirk.Behme" <Dirk.Behme@de.bosch.com>
References: <57172B7C.4060407@de.bosch.com> <5718E924.2030103@roeck-us.net>
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <57193739.7010603@rempel-privat.de>
Date: Thu, 21 Apr 2016 22:25:29 +0200
MIME-Version: 1.0
In-Reply-To: <5718E924.2030103@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4BCpLAhgKReTOVji3VRutorFIj8H4nkk5"
List-ID: <linux-watchdog@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4BCpLAhgKReTOVji3VRutorFIj8H4nkk5
Content-Type: multipart/mixed; boundary="nl36lmiNReg1xOd1hVTNmNhIBVqCp39vd"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Guenter Roeck <linux@roeck-us.net>,
 "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel@de.bosch.com>,
 linux-watchdog@vger.kernel.org, "Dirk.Behme" <Dirk.Behme@de.bosch.com>
Message-ID: <57193739.7010603@rempel-privat.de>
Subject: Re: watchdoug group ping
References: <57172B7C.4060407@de.bosch.com> <5718E924.2030103@roeck-us.net>
In-Reply-To: <5718E924.2030103@roeck-us.net>

--nl36lmiNReg1xOd1hVTNmNhIBVqCp39vd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 21.04.2016 um 16:52 schrieb Guenter Roeck:
> On 04/20/2016 12:10 AM, fixed-term.Oleksij.Rempel wrote:
>> Hallo all,
>>
>> my target is to provide pretimout support for devices which do not hav=
e
>> this functionality.
>>
>> Pre-requirement is this patchset (i contacted the author to rebase it
>> against latest watchdog core branch):
>> https://www.mail-archive.com/linux-watchdog@vger.kernel.org/msg02394.h=
tml
>>
>> The idea is to use different watchdogs/timers or what ever as one grou=
p
>> - one virtual device.
>> One driver will be responsible for reseting the system, other for
>> generating an interrupt on pre-timout.
>> It can be also useful for systems which require redundant watchdogs -
>> two or more watchdog pinged over one /dev/watchdog
>>
>> I assume i would need to create a master virtual watchdog driver to
>> bypass/broadcast all pings to child devices.
>>
>> Do you have some ideas or suggestions?
>>
> Seems to add a lot of complexity. It might be much simpler to add suppo=
rt
> for a 'soft' pretimeout in such situations, ie a timer which fires at t=
he
> correct interval and results in a reset. It might even be possible to u=
se
> the new internal heartbeat function for this purpose.

yes, you have right. it is simple and cleaner generic way.
i like it :)


--=20
Regards,
Oleksij


--nl36lmiNReg1xOd1hVTNmNhIBVqCp39vd--

--4BCpLAhgKReTOVji3VRutorFIj8H4nkk5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlcZN0MACgkQHwImuRkmbWnVTgD+OSpbKgD5mnIeUUeW3ekCfXFP
RcWSO3Y5KnpzMyArDHAA/iQsBLWJBfXUdST8oDQnhZZ2uDWwX/kRDAE0Zb7ZJh+Y
=uaYU
-----END PGP SIGNATURE-----

--4BCpLAhgKReTOVji3VRutorFIj8H4nkk5--
