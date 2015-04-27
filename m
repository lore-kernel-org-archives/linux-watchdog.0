Return-path: <anholt@eliezer.anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to the WDT driver.
In-Reply-To: <20150427160517.GA11074@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <1429902534-2348-2-git-send-email-eric@anholt.net> <20150427160432.GD5701@roeck-us.net> <20150427160517.GA11074@roeck-us.net>
Date: Mon, 27 Apr 2015 16:12:53 -0700
Message-ID: <877fsx9nd6.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-watchdog@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Guenter Roeck <linux@roeck-us.net> writes:

> On Mon, Apr 27, 2015 at 09:04:32AM -0700, Guenter Roeck wrote:
>> On Fri, Apr 24, 2015 at 12:08:54PM -0700, Eric Anholt wrote:
>> > Since the WDT is what's used to drive restart and power off, it makes
>> > more sense to keep it there, where the regs are already mapped and
>> > definitions for them provided.  Note that this means you may need to
>> > add CONFIG_BCM2835_WDT to retain functionality of your kernel.
>> >=20
>> > Signed-off-by: Eric Anholt <eric@anholt.net>
>> > Cc: linux-watchdog@vger.kernel.org
>>=20
>> The patch will require a rebase to v4.0-rc1.
>>=20
> s/4.0/4.1/

It will?  It seems to work fine, and the diff's the same.  Is there some
new thing you were expecting in a rebase?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVPsJ1AAoJELXWKTbR/J7oHywQALj4ZLKM6q2qLyA0tZ5Wtr5/
vXvhzR/4Ab654UEkhJ4AM6SZD7VmO+we5i7xRyr2EBJFgv1HU5drJrmhqkW9jkq+
FomplgFTTw4FsXmla85RHJK73dkGlwmr+pcjuyyM8nCqwsjIJB1oyiUPaZQHFTv0
dxM+2xe7kYSVjeTTzENWy8EHJZwzwNiN33cxngQA/AvDGYXyECtHJLjfYAOjI4jV
AK7QnzZ7RBt7DmSf6VxKKRaEoAbB/L9AvFXwVv0FMqFr1dIwIedTqsxqmwBEy1I+
EdR3p/wfIob667rkmaMxYpvDRF1PRlB1cmPccDDIHwa4Ue4alVODH/BWx5gBSIEb
gDs/mCUmPurIb9gPer7Ezj77wc44kFtJiVto/woHbmOCuIa44X4D3OjXyX3S/Ve4
r2MC0yEDj6JzmzrLFnSD1zKna3m+f0fvitjkHBKHTYRwvfhTJp55OEukkCPycuXJ
i7skiASSskWPLENpiDegMve/6CNEOiC6ky6r25BKlm/smYn3qIesuDFIkGAYWG2p
7xlXeTPD7lFw2vaitsXKKgjTjEegzVdMBGm+pFFsrCEwGFoZ6/XMAoEJm4ryvz/h
XDTWrq12e+Mh8ge9Fsl6YIHgQ/CkXC3OaPZOsHj3rcxaXoEdu3vw7NgXOdtGp6GZ
xN+1qkI35Mu8t4Mr6bsO
=dz7s
-----END PGP SIGNATURE-----
--=-=-=--
