Return-path: <linux@rempel-privat.de>
Subject: Re: [PATCH] watchdog: add Alphascale asm9260-wdt driver
To: Guenter Roeck <linux@roeck-us.net>
References: <1442568212-15509-1-git-send-email-linux@rempel-privat.de>
 <20151027023132.GA1270@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <5631C8A9.3050602@rempel-privat.de>
Date: Thu, 29 Oct 2015 08:20:09 +0100
MIME-Version: 1.0
In-Reply-To: <20151027023132.GA1270@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9aUN5sJvk7AXCT1HfegU2nFJoAuEW5aqn"
List-ID: <linux-watchdog@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9aUN5sJvk7AXCT1HfegU2nFJoAuEW5aqn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

thank you for your time.


Am 27.10.2015 um 03:31 schrieb Guenter Roeck:
> On Fri, Sep 18, 2015 at 11:23:32AM +0200, Oleksij Rempel wrote:
>> Add WD support for Alphascale asm9260 SoC. This driver
>> provide support for different function modes:
>> - HW mode to trigger SoC reset on timeout
>> - SW mode do soft reset if needed
>> - DEBUG mode
>>
>> Optional support for stopping watchdog. If reset binding are not provi=
ded
>> this driver will work in nowayout mode.
>=20
> Why ?

Because this controller can't be stopped. Only way to stop it is to
reset it from reset controller, which is out of scope of this driver.
On other side i can make reset binding as required...

>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> ---
>>  .../bindings/watchdog/alphascale-asm9260.txt       |  38 ++
>>  drivers/watchdog/Kconfig                           |   9 +
>>  drivers/watchdog/Makefile                          |   1 +
>>  drivers/watchdog/asm9260_wdt.c                     | 405 ++++++++++++=
+++++++++
>>  4 files changed, 453 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/alphasc=
ale-asm9260.txt
>>  create mode 100644 drivers/watchdog/asm9260_wdt.c
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm=
9260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.=
txt
>> new file mode 100644
>> index 0000000..cbe388b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.tx=
t
>> @@ -0,0 +1,38 @@
>> +Alphascale asm9260 Watchdog timer
>> +
>> +Required properties:
>> +
>> +- compatible : should be "alphascale,asm9260-wdt".
>> +- reg : Specifies base physical address and size of the registers.
>> +- clocks : the clock feeding the watchdog timer.
>=20
> There are two -> clocks.
>=20
>> +	Needed if platform uses clocks. See clock-bindings.txt
>=20
> The rest of the code suggests that the clocks are mandatory.
> probe fails if asm9260_wdt_get_dt_clks() returns an error,
> and the clock frequency would be 0.
>=20
>> +- clock-names : should be set to
>> +	"mod" - source for tick counter.
>> +	"ahb" - ahb gate.
>> +
>> +Optional properties:
>> +- resets : phandle pointing to the system reset controller with corre=
ct
>> +	reset line index for watchdog controller reset. This propertie is
>> +	required if you need to disable "nowayout" and it works only with
>> +	CONFIG_WATCHDOG_NOWAYOUT=3Dn.
>> +- reset-names : should be set to "wdt_rst" if "resets" is used.
>> +- timeout-sec : shall contain the default watchdog timeout in seconds=
,
>> +	if unset, the default timeout is 30 seconds.
>> +- alphascale,mode : tree modes are supported
>> +	"hw" - hw reset (defaul).
>> +	"sw" - sw reset.
>> +	"debug" - no action is taken.
>> +
>> +Example:
>> +
>> +watchdog0: watchdog@80048000 {
>> +	compatible =3D "alphascale,asm9260-wdt";
>> +	reg =3D <0x80048000 0x10>;
>> +	clocks =3D <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
>> +	clock-names =3D "mod", "ahb";
>> +	interrupts =3D <55>;
>> +	resets =3D <&rst WDT_RESET>;
>> +	reset-names =3D "wdt_rst";
>> +	timeout-sec =3D <30>;
>> +	alphascale,mode =3D "hw"
>=20
> Seems to miss a ';'.
>=20
> Did you get any feedback from dt maintainers on those bindings ?

No, i'll CC updated patch to devicetree list.

Thank you for other comments, i'll take care of it.

--=20
Regards,
Oleksij


--9aUN5sJvk7AXCT1HfegU2nFJoAuEW5aqn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EAREIAAYFAlYxyK4ACgkQHwImuRkmbWmCZAD/VDUlJ/BGNtDbzILKXxFvytao
Bx0Q09i2J8fh659kfJcA+MzsAnKomhOvAwU+LqebPREW1HQ0SJ2ODZ7fFEXlGY0=
=sUxC
-----END PGP SIGNATURE-----

--9aUN5sJvk7AXCT1HfegU2nFJoAuEW5aqn--
