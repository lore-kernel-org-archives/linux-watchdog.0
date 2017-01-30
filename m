Return-path: <HartleyS@visionengravers.com>
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mika
 Westerberg" <mika.westerberg@iki.fi>, Wim Van Sebroeck <wim@iguana.be>
Subject: RE: [PATCH 2/2] watchdog: ts72xx_wdt: convert driver to watchdog core
Date: Mon, 30 Jan 2017 19:17:54 +0000
Message-ID: <SN1PR0101MB156521AF843C0D92F61D20A2D04B0@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20170130165548.40965-1-hsweeten@visionengravers.com>
 <20170130165548.40965-3-hsweeten@visionengravers.com>
 <20170130190138.GB11199@roeck-us.net>
In-Reply-To: <20170130190138.GB11199@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On Monday, January 30, 2017 12:02 PM, Guenter Roeck wrote:
> On Mon, Jan 30, 2017 at 09:55:48AM -0700, H Hartley Sweeten wrote:
>> Cleanup this driver and convert it to use the watchdog framework API.
>>=20
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Mika Westerberg <mika.westerberg@iki.fi>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  drivers/watchdog/ts72xx_wdt.c | 447 +++++++++--------------------------=
-------
>>  1 file changed, 93 insertions(+), 354 deletions(-)

<snip>

>> -#define TS72XX_WDT_DEFAULT_TIMEOUT	8
>> -
>> -static int timeout =3D TS72XX_WDT_DEFAULT_TIMEOUT;
>> -module_param(timeout, int, 0);
>> -MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. "
>> -			  "(1 <=3D timeout <=3D 8, default=3D"
>> -			  __MODULE_STRING(TS72XX_WDT_DEFAULT_TIMEOUT)
>> -			  ")");
>
> Same question as with patch #1 - are you sure you want to take this away =
?

Again, not a problem leaving it in.

> You might just drop the limits instead (also see below).

<snip>

>> +	wdd->min_timeout =3D 1;
>> +	wdd->max_timeout =3D 8;
>
> With such a low maximum timeout, it might make sense to use the core
> to be able to support larger timeouts.

Agree. I'll update and test this for the next version.

>> +	wdd->timeout =3D 8;
>> +	wdd->parent =3D &pdev->dev;
>> =20
>> -	/* make sure that the watchdog is disabled */
>> -	ts72xx_wdt_stop(wdt);
>
> Are you sure this is no longer needed ? If there is a means to detect if =
the
> watchdog is running, it might make sense to set the WDOG_HW_RUNNING flag =
instead
> if it is running and let the core handle the ping until the watchdog devi=
ce
> is opened.

A patch to make sure this watchdog is disabled early during the kernel unco=
mpress
will soon be applied. Arnd Bergmann has it in his todo folder:

[PATCH] ARM: ep93xx: Disable TS-72xx watchdog before uncompressing

The bootloader currently enables the watchdog for 8 seconds and it needs to=
 be
disabled just in case the uncompress takes longer.

I don't have a problem leaving it in here it's just not necessary.

>> +	watchdog_set_nowayout(wdd, nowayout);
>> =20
>> -	error =3D misc_register(&ts72xx_wdt_miscdev);
>> -	if (error) {
>> -		dev_err(&pdev->dev, "failed to register miscdev\n");
>> -		return error;
>> -	}
>> +	watchdog_set_drvdata(wdd, priv);
>> +
>> +	ret =3D watchdog_register_device(wdd);
>
> devm_watchdog_register_device() ?

I'll update this.

Thanks,
Hartley
