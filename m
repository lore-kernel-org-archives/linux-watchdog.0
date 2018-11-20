Return-Path: <eric@anholt.net>
Return-path: <eric@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 0/8] BCM2835 PM driver
In-Reply-To: <1299453058.112996.1542736171394@email.ionos.de>
References: <20181120172000.15102-1-eric@anholt.net> <1299453058.112996.1542736171394@email.ionos.de>
Date: Tue, 20 Nov 2018 13:34:03 -0800
Message-ID: <87o9aj77sk.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-watchdog@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 20. November 2018 um 18:19 geschrie=
ben:
>>=20
>>=20
>> This series moves the BCM2835 WDT driver that controls a fraction of
>> the PM block out to soc/ and adds most of the rest of its
>> functionality.  My motivation has been to have V3D be functional
>> without firmware calls, probably improve its interactivity (since
>> we'll be able to power on/off without RPC to the firmware that may be
>> busy with other tasks), and (in a patch not submitted in this series)
>> extend its binding to use the reset controller instead of trying to
>> reset by toggling its power domain.
>>=20
>> I've tested V3D with a few hours of running a V3D test, sleep(1) (to
>> trigger PM domain off); running a GPU hang job (to trigger reset);
>> sleep(1).  The non-hanging success-case job always passed, and dmesg
>> had no complaints from bcm2835-pm.  The other power domains are not
>> tested, but I've done my best.
>>=20
>> This series will probably also be of interest to the
>> https://github.com/christinaa/rpi-open-firmware project for enabling USB.
>>=20
>
> apologize to give you my feedback after you send out the series.
>
> I know you won't be happy about it, but i think we need a little more
> complex but future proof solution for this power driver. According to
> the register definition of the PM block, we have multiple functions
> here (power domains, watchdog, pads/pinctrl, ...). Since this is
> common for ARM SoCs there is a subsystem called mfd (multi function
> device) [1] to abstract all resources of the IP block.
>
> This has the advantage that we don't need a monolithic driver which
> takes care of all functions.

I consider your "advantage" to be a disadvantage.  By forcing the split,
you end up having more driver files to manage, more platform devices,
and more error-prone code to get the resources from the parent down into
the client.  It feels like writing software for the sake of writing
software, rather than solving a concrete problem.

My original series:

 10 files changed, 951 insertions(+), 273 deletions(-)

The MFD series:

 12 files changed, 882 insertions(+), 25 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlv0fcsACgkQtdYpNtH8
nuhtnA/9Gb7dE1/tAPnRIwQSyv9Tmo2ZshqHyZLW6c6vfC0BFKOUT84RzXbFYJZG
QlNJHW3e1I3OjqRvDkt8MqilpmG8n7vJxQFpPvWzeXYynNRR6WGwlzClNwtkX70c
BFmEqfuKZ7WzorUkcLvmBSShH/EbRyz+BPzhpLl6N/3/iv5lJBLSRc0Djg9+FUSN
TEiYLA/RgzfQozowv69Q46F40RmEpcoR4FH7TJQqmodaMn79A7Ti/4nhJdrayTir
hHF0476vZTkSktRaL6Tv6RKOCCQNUSlDpfu2zG6dMhtTuPJjSdHLgjRtSnEE1cLP
y1Fqp13spoZdzQgUc9u1Ka5Unm9LmKjdPNM+oBlsXstGhziZSklNL65nKvd9TESk
BPtRmPtdN05gLcEJ9wpLc0KsoCHKdZKGuXZHoyalGZBDJ9HeHK/iP6zaXXTg2fqh
ulpMeht+aTMUAjs8wUisykDkjbw8J4FThyBMf4nlQF9TpD4HYw75+fP74HnS2X7e
OokRG80Ecap8cRVnsl+o69pZJwAhn1LSAsCGR9X8m2FC8YMF8pyDtCAvjQDAGYCZ
kPzrPv3uNi954baPkQcFYJiv2AtzWVbWT3vXwFSMDh8tuKQBgwkdmdxnKZ/qbJJQ
awlFooEpyKf9fp9J8TzjbprEyT+anEama+triXKopjae0jIjX2U=
=Rn7A
-----END PGP SIGNATURE-----
--=-=-=--
