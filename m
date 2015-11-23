Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:62603 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220AbbKWJvw (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 04:51:52 -0500
Subject: Re: [PATCH v2] watchdog: add Alphascale asm9260-wdt driver
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
References: <20151027023132.GA1270@roeck-us.net>
 <1446714416-22587-1-git-send-email-linux@rempel-privat.de>
 <1446714416-22587-2-git-send-email-linux@rempel-privat.de>
 <20151105204301.GA15806@rob-hp-laptop> <5652BC30.7060803@rempel-privat.de>
 <5652BFA5.9010101@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	devicetree@vger.kernel.org
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <5652E1A7.2090108@rempel-privat.de>
Date: Mon, 23 Nov 2015 10:51:35 +0100
MIME-Version: 1.0
In-Reply-To: <5652BFA5.9010101@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lIevVQAstKCfBFoRqS98vk9CgJIvPke71"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lIevVQAstKCfBFoRqS98vk9CgJIvPke71
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 23.11.2015 um 08:26 schrieb Guenter Roeck:
> On 11/22/2015 11:11 PM, Oleksij Rempel wrote:
>> Hi,
>>
>> thank you for review!
>>
>> Am 05.11.2015 um 21:43 schrieb Rob Herring:
>>> On Thu, Nov 05, 2015 at 10:06:56AM +0100, Oleksij Rempel wrote:
>>>> Add WD support for Alphascale asm9260 SoC. This driver
>>>> provide support for different function modes:
>>>> - HW mode to trigger SoC reset on timeout
>>>> - SW mode do soft reset if needed
>>>> - DEBUG mode
>>>>
>>>> Optional support for stopping watchdog. If reset binding are not
>>>> provided
>>>> this driver will work in nowayout mode.
>>>>
>>>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>>>> ---
>>>>   .../bindings/watchdog/alphascale-asm9260.txt       |  39 ++
>>>
>>> It is preferred that bindings are a separate patch.
>>>
>>>>   drivers/watchdog/Kconfig                           |   9 +
>>>>   drivers/watchdog/Makefile                          |   1 +
>>>>   drivers/watchdog/asm9260_wdt.c                     | 415
>>>> +++++++++++++++++++++
>>>>   4 files changed, 464 insertions(+)
>>>>   create mode 100644
>>>> Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
>>>>   create mode 100644 drivers/watchdog/asm9260_wdt.c
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
>>>> b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
>>>> new file mode 100644
>>>> index 0000000..6e54d1f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.=
txt
>>>> @@ -0,0 +1,39 @@
>>>> +Alphascale asm9260 Watchdog timer
>>>> +
>>>> +Required properties:
>>>> +
>>>> +- compatible : should be "alphascale,asm9260-wdt".
>>>> +- reg : Specifies base physical address and size of the registers.
>>>> +- clocks : the clocks feeding the watchdog timer. See
>>>> clock-bindings.txt
>>>> +- clock-names : should be set to
>>>> +    "mod" - source for tick counter.
>>>> +    "ahb" - ahb gate.
>>>> +
>>>> +Optional properties:
>>>> +- resets : phandle pointing to the system reset controller with
>>>> correct
>>>> +    reset line index for watchdog controller reset. This propertie =
is
>>>
>>> s/propertie/property/
>>>
>>>> +    required if you need to disable "nowayout" and it neened only w=
ith
>>>> +    CONFIG_WATCHDOG_NOWAYOUT=3Dn.
>>>
>>> The DT cannot depend on certain kernel configs.
>>>
>>>> +    Without reseting this WD controller, it is not possible to stop=

>>>
>>> s/reseting/resetting/
>>>
>>>> +    counter.
>>>> +- reset-names : should be set to "wdt_rst" if "resets" is used.
>>>> +- timeout-sec : shall contain the default watchdog timeout in secon=
ds,
>>>> +    if unset, the default timeout is 30 seconds.
>>>> +- alphascale,mode : tree modes are supported
>>>
>>> s/tree/three/
>>>
>>>> +    "hw" - hw reset (defaul).
>>>
>>> s/defaul/default/
>>>
>>>> +    "sw" - sw reset.
>>>> +    "debug" - no action is taken.
>>>
>>> Seems like this should be a generic wdog property.
>>>
>>
>> what do you mean?
>> Using "mode" instead of "alphascale,mode" and implement it in WD
>> framework?
>>
>=20
> You should still read the property in the driver, even it if is made
> generic.
> The watchdog framework can't really use the information, most drivers d=
on't
> support selecting the mode. We can consider moving it into the framewor=
k
> if/when it benefits other drivers.
>=20
> On a side note, I would suggest "software" and "hardware" instead of sw=

> / hw,
> but that is just a personal preference.

Ok, then i will leave it for now as is. If "mode" will be introduced, it
can brake compatibility. Using "alphascale,mode" feels save :)

--=20
Regards,
Oleksij


--lIevVQAstKCfBFoRqS98vk9CgJIvPke71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlZS4awACgkQHwImuRkmbWmPBQD/baZpTmdlQWmYU+x8Glno/mEU
+LsLacUCQdz7CZz1DkcA/iAGeDpWdHBBpM5uxUGBLfxfuFYXtn9e04mhEUYrQ8cn
=tm5L
-----END PGP SIGNATURE-----

--lIevVQAstKCfBFoRqS98vk9CgJIvPke71--
