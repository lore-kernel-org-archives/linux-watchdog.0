Return-path: <linux@rempel-privat.de>
Subject: Re: [PATCH v2] watchdog: add Alphascale asm9260-wdt driver
To: Rob Herring <robh@kernel.org>
References: <20151027023132.GA1270@roeck-us.net>
 <1446714416-22587-1-git-send-email-linux@rempel-privat.de>
 <1446714416-22587-2-git-send-email-linux@rempel-privat.de>
 <20151105204301.GA15806@rob-hp-laptop>
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net, wim@iguana.be,
 devicetree@vger.kernel.org
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <5652BC30.7060803@rempel-privat.de>
Date: Mon, 23 Nov 2015 08:11:44 +0100
MIME-Version: 1.0
In-Reply-To: <20151105204301.GA15806@rob-hp-laptop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lFa7tXsXghSG4CaU7wjUssOMJPeGWieHL"
List-ID: <linux-watchdog@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lFa7tXsXghSG4CaU7wjUssOMJPeGWieHL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

thank you for review!

Am 05.11.2015 um 21:43 schrieb Rob Herring:
> On Thu, Nov 05, 2015 at 10:06:56AM +0100, Oleksij Rempel wrote:
>> Add WD support for Alphascale asm9260 SoC. This driver
>> provide support for different function modes:
>> - HW mode to trigger SoC reset on timeout
>> - SW mode do soft reset if needed
>> - DEBUG mode
>>
>> Optional support for stopping watchdog. If reset binding are not provi=
ded
>> this driver will work in nowayout mode.
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> ---
>>  .../bindings/watchdog/alphascale-asm9260.txt       |  39 ++
>=20
> It is preferred that bindings are a separate patch.
>=20
>>  drivers/watchdog/Kconfig                           |   9 +
>>  drivers/watchdog/Makefile                          |   1 +
>>  drivers/watchdog/asm9260_wdt.c                     | 415 ++++++++++++=
+++++++++
>>  4 files changed, 464 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/alphasc=
ale-asm9260.txt
>>  create mode 100644 drivers/watchdog/asm9260_wdt.c
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm=
9260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.=
txt
>> new file mode 100644
>> index 0000000..6e54d1f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.tx=
t
>> @@ -0,0 +1,39 @@
>> +Alphascale asm9260 Watchdog timer
>> +
>> +Required properties:
>> +
>> +- compatible : should be "alphascale,asm9260-wdt".
>> +- reg : Specifies base physical address and size of the registers.
>> +- clocks : the clocks feeding the watchdog timer. See clock-bindings.=
txt
>> +- clock-names : should be set to
>> +	"mod" - source for tick counter.
>> +	"ahb" - ahb gate.
>> +
>> +Optional properties:
>> +- resets : phandle pointing to the system reset controller with corre=
ct
>> +	reset line index for watchdog controller reset. This propertie is
>=20
> s/propertie/property/
>=20
>> +	required if you need to disable "nowayout" and it neened only with
>> +	CONFIG_WATCHDOG_NOWAYOUT=3Dn.
>=20
> The DT cannot depend on certain kernel configs.
>=20
>> +	Without reseting this WD controller, it is not possible to stop
>=20
> s/reseting/resetting/
>=20
>> +	counter.
>> +- reset-names : should be set to "wdt_rst" if "resets" is used.
>> +- timeout-sec : shall contain the default watchdog timeout in seconds=
,
>> +	if unset, the default timeout is 30 seconds.
>> +- alphascale,mode : tree modes are supported
>=20
> s/tree/three/
>=20
>> +	"hw" - hw reset (defaul).
>=20
> s/defaul/default/
>=20
>> +	"sw" - sw reset.
>> +	"debug" - no action is taken.
>=20
> Seems like this should be a generic wdog property.
>=20

what do you mean?
Using "mode" instead of "alphascale,mode" and implement it in WD framewor=
k?

--=20
Regards,
Oleksij


--lFa7tXsXghSG4CaU7wjUssOMJPeGWieHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlZSvDkACgkQHwImuRkmbWlk7QD/bCRb497q4D90qQfthjw768eP
laqfadXqOXSpdrhGOuMA/RaWcwDjgNy80kEvNO3lSdAKW/PyHL4nr7HN2blRO3UE
=Yrth
-----END PGP SIGNATURE-----

--lFa7tXsXghSG4CaU7wjUssOMJPeGWieHL--
