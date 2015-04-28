Return-path: <anholt@eliezer.anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to the WDT driver.
In-Reply-To: <553EE4EC.1000403@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <1429902534-2348-2-git-send-email-eric@anholt.net> <20150427160432.GD5701@roeck-us.net> <20150427160517.GA11074@roeck-us.net> <877fsx9nd6.fsf@eliezer.anholt.net> <553EE4EC.1000403@roeck-us.net>
Date: Tue, 28 Apr 2015 12:38:32 -0700
Message-ID: <877fsw6o1z.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-watchdog@vger.kernel.org>

--=-=-=
Content-Type: text/plain

Guenter Roeck <linux@roeck-us.net> writes:

> On 04/27/2015 04:12 PM, Eric Anholt wrote:
>> Guenter Roeck <linux@roeck-us.net> writes:
>>
>>> On Mon, Apr 27, 2015 at 09:04:32AM -0700, Guenter Roeck wrote:
>>>> On Fri, Apr 24, 2015 at 12:08:54PM -0700, Eric Anholt wrote:
>>>>> Since the WDT is what's used to drive restart and power off, it makes
>>>>> more sense to keep it there, where the regs are already mapped and
>>>>> definitions for them provided.  Note that this means you may need to
>>>>> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
>>>>>
>>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>>> Cc: linux-watchdog@vger.kernel.org
>>>>
>>>> The patch will require a rebase to v4.0-rc1.
>>>>
>>> s/4.0/4.1/
>>
>> It will?  It seems to work fine, and the diff's the same.  Is there some
>> new thing you were expecting in a rebase?
>>
> All I can say is that it didn't apply for me. Maybe someone else has more luck.

If you were trying to apply it to stock 4.1-rc1, it would fail.  It was
based on the for-rpi-next tree, since that's where I assume it would go
in through.

If you'd like to take it through your tree I could send you that one,
but it'll mean conflicts for someone to resolve later.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVP+G4AAoJELXWKTbR/J7ofOAP/jLogrEkBUS88XF9UzopRsn9
PrZ3c1G6ODC0uDORi41NQh/SbPtk7+R2f9Elhnn8I2l0SQ0477xr0WzcUN9K9QZc
Wn75wuPTHiWmy7yff+zqA/6LmID0hQ1XIoR5SPc5hLBWCQ9ZAHgtxTEfy1p+T9V/
R/+WLtSadrnVkI6uZEVIh28GzPFdt/M1k58Db2nliDApq5wjveV+jZHGl7P/vRWD
5d0lWIEHUhnEvtOyPN23m5lO9wwTbQXQOX1xMfCEHjSAhEgvS4+R3jpJJ/a+oqwv
8VNTsw0a1SZurEfAVJvrIn4OHgObLuDPN7Jn2nV2pGP/H65cP7Cvksw/otXnUqIr
taBa8X+iWWtk08IY+cLA9XN6EM1KcLk3wTMnjPukw9yOI8H1wA0pK6rbPB087dDR
2/LKK9Bfa/Pabfybf/IEbLxfX9STC71lPTbBrAMvc5foDMxzwfYM5+ZRUncHv/pV
UX2z04W44NlxVEn3t132D89HEZAEdJEFIYRhHUavxkhQEhL7miiPx768LNs2Ke8A
j7qfPp5lmPDfJNTBjs2/mtU3REJnHL34Dunt2YLnXSW9I+ExawGqf9qinxp8/9ww
R8pGcpKiHFmm/7Dnk9XIJVXRXtB96h6cqefoBntXhK9M+45VQzHak/YlpLbqC031
axCXjPP+m5FIqHAlvBV5
=uED6
-----END PGP SIGNATURE-----
--=-=-=--
