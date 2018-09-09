Return-Path: <hauke@hauke-m.de>
Return-path: <hauke@hauke-m.de>
Subject: Re: [v2,1/3] wdt: lantiq: update register names to better match spec
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org, john@phrozen.org,
 dev@kresin.me
References: <20180902113233.29113-2-hauke@hauke-m.de>
 <20180903230915.GA30065@roeck-us.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <421d178d-4102-56fa-e348-af7c6b92ba87@hauke-m.de>
Date: Sun, 9 Sep 2018 23:04:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180903230915.GA30065@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rdzmbqOojy3o8lDgmtqE1BkGXFin96kUa"
List-ID: <linux-watchdog@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rdzmbqOojy3o8lDgmtqE1BkGXFin96kUa
Content-Type: multipart/mixed; boundary="k2kUvMUawPWhaX2bCushvfW7hTbXz48AQ";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org, john@phrozen.org,
 dev@kresin.me
Message-ID: <421d178d-4102-56fa-e348-af7c6b92ba87@hauke-m.de>
Subject: Re: [v2,1/3] wdt: lantiq: update register names to better match spec
References: <20180902113233.29113-2-hauke@hauke-m.de>
 <20180903230915.GA30065@roeck-us.net>
In-Reply-To: <20180903230915.GA30065@roeck-us.net>

--k2kUvMUawPWhaX2bCushvfW7hTbXz48AQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/04/2018 01:09 AM, Guenter Roeck wrote:
> On Sun, Sep 02, 2018 at 01:32:31PM +0200, Hauke Mehrtens wrote:
>> Some of the names of the bits were confusing to me.
>> Now the bits share the same prefix as the register they are set on.
>>
>=20
> Plus you changed the description. Overall I find the new defines
> more confusing than the old ones, especially the changed meaning.
> Can you point me to a reference manual ?

Ok I will update the commit message.

Some of the defines had wrong comments in this driver.

>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  drivers/watchdog/lantiq_wdt.c | 32 ++++++++++++++++----------------
>>  1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_w=
dt.c
>> index 7f43cefa0eae..e5937be09bd4 100644
>> --- a/drivers/watchdog/lantiq_wdt.c
>> +++ b/drivers/watchdog/lantiq_wdt.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/module.h>
>>  #include <linux/fs.h>
>>  #include <linux/miscdevice.h>
>> +#include <linux/bitops.h>
>>  #include <linux/watchdog.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/uaccess.h>
>> @@ -40,18 +41,17 @@
>>   * essentially the following two magic passwords need to be written t=
o allow
>>   * IO access to the WDT core
>>   */
>> -#define LTQ_WDT_PW1		0x00BE0000
>> -#define LTQ_WDT_PW2		0x00DC0000
>> +#define LTQ_WDT_CR_PW1		0x00BE0000
>> +#define LTQ_WDT_CR_PW2		0x00DC0000
>> =20
>> -#define LTQ_WDT_CR		0x0	/* watchdog control register */
>> -#define LTQ_WDT_SR		0x8	/* watchdog status register */
>> +#define LTQ_WDT_CR		0x0		/* watchdog control register */
>> +#define  LTQ_WDT_CR_GEN		BIT(31)		/* enable bit */
>> +#define  LTQ_WDT_CR_PWL		(0x3 << 26)	/* Pre-warning limit set to 1/16=
 of max WDT period */
>=20
> Old was "turn on power"

I do not know why someone commented this as "turn on power", this is the
Pre warnings limit register (26:25) for all SoCs I am aware of.

>> +#define  LTQ_WDT_CR_CLKDIV	(0x3 << 24)	/* set clock divider to 0x4000=
0 */
>=20
> Old was: "turn on clock and set divider to 0x40000". Note that the comm=
ent
> itself does not really add much value, except that it suggests that one=
> of the bits may _not_ really set a clock mask.

This sets only the clock divider, all possible 4 values for these two
bits are valid dividers. For Linux with multi second watchdog timeouts
only the biggest diver makes sense.

> So this doesn't just rename the defines, it also changes the meaning.
>=20
> Also, while some may feel differently, I do think we should stick with =
the
> 80-column limit as long as it exists and generates checkpatch warnings.=


I will add the comment above the line if if gets too long.

>> +#define  LTQ_WDT_CR_PW_MASK	GENMASK(23, 16)	/* Password field */
>> +#define  LTQ_WDT_CR_RELOAD_MASK	GENMASK(15, 0)	/* Reload value */
>> =20
>=20
> The mixed use of GENMASK() for some defines and shift for others is
> confusing.

I used the shifts when it is a value in a register and I used the
GENMASK when it is a MASK of a register.

It is not supported in this driver to change the pre timeout warning and
the clock divider and from the use cases I am aware of it also does not
make sense so I only the useful value is added here.

>> -#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
>> -#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
>> -#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
>> -						/* divider to 0x40000 */
>>  #define LTQ_WDT_DIVIDER		0x40000
>> -#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bi=
t */
>> =20
> I question if the change from LTQ_MAX_TIMEOUT to LTQ_WDT_CR_RELOAD_MASK=

> really adds value. Sure, the maximum value must fit into a mask, but it=

> is still a maximum value.

I need the same value as a max timeout value and I need it as a mask to
make sure all bits of the timeout are set to 0.

I can change this back to LTQ_MAX_TIMEOUT and use it also as a mask.

>>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
>> =20
>> @@ -68,26 +68,26 @@ ltq_wdt_enable(void)
>>  {
>>  	unsigned long int timeout =3D ltq_wdt_timeout *
>>  			(ltq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
>> -	if (timeout > LTQ_MAX_TIMEOUT)
>> -		timeout =3D LTQ_MAX_TIMEOUT;
>> +	if (timeout > LTQ_WDT_CR_RELOAD_MASK)
>> +		timeout =3D LTQ_WDT_CR_RELOAD_MASK;
>=20
> And this is less confusing than before ? Not to me. I find the new code=

> more confusing.

I agree.

>=20
>> =20
>>  	/* write the first password magic */
>> -	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
>> +	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
>>  	/* write the second magic plus the configuration and new timeout */
>> -	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV | -
>> LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR); +
>> ltq_w32(LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV | +
>> LTQ_WDT_CR_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR); }
>> =20
>>  static void ltq_wdt_disable(void) { /* write the first password magic=
 */ -
>>  ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR); +
>>  ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR); /* * write the=
 second
>>  password magic with no config * this turns the watchdog off */ -
>>  ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR); +
>>  ltq_w32(LTQ_WDT_CR_PW2, ltq_wdt_membase + LTQ_WDT_CR); }
>> =20
>>  static ssize_t



--k2kUvMUawPWhaX2bCushvfW7hTbXz48AQ--

--rdzmbqOojy3o8lDgmtqE1BkGXFin96kUa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluViuYACgkQ8bdnhZyy
68eP4QgAkA/C4VUlYi02Q9aOciB3dsoU9UDjMujcLI9p0abRmB+WWHleFlzT5g5k
F4LCKhwJveQ0fuUu1wvHnqrmNikovkfJOtkWNKlj/IG+U2+7oy1ELGun4WBxRTJy
uz6U+YirCk7ZCAyeVHN1jI1Fu1J5jThIOZYwja8HXJmggfojTf9F2JU7leyCaTAt
wdPcVZwIgd6R5KOfUN4fnfRzFCCm9jY2+6mUYTRobz0FCpuIaG4xy4gVD5D6NUO7
mma73YTKfuwBVGpAuspuLQViksSi/c8GkDgfyyYE1WXed5YZBBvbsR5bybk25xAF
14uSse84amicZ5z1PGfPAmlzpmjPWw==
=FihL
-----END PGP SIGNATURE-----

--rdzmbqOojy3o8lDgmtqE1BkGXFin96kUa--
