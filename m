Return-path: <HartleyS@visionengravers.com>
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wim Van
 Sebroeck" <wim@iguana.be>
Subject: RE: [PATCH 1/2] watchdog: ep93xx_wdt: cleanup and let the core handle
 the heartbeat
Date: Mon, 30 Jan 2017 19:09:55 +0000
Message-ID: <SN1PR0101MB1565196AC721B7FD3247E581D04B0@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20170130165548.40965-1-hsweeten@visionengravers.com>
 <20170130165548.40965-2-hsweeten@visionengravers.com>
 <20170130185529.GA11199@roeck-us.net>
In-Reply-To: <20170130185529.GA11199@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On Monday, January 30, 2017 11:55 AM, Guenter Roeck wrote:
> On Mon, Jan 30, 2017 at 09:55:47AM -0700, H Hartley Sweeten wrote:
>> Cleanup this driver and remove the 200ms heartbeat timer. The core now
>> has the ability to handle the heartbeat.
>>=20
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: Guenter Roeck <linux@roeck-us.net>

Hi Guenter,

I wasn't sure this patch was going to get delivered correctly. I got an "Un=
deliverable"
bounce due to possible spoofing. I am trying to figure out why right now.

Anyway...

<snip>

>> -#define WDT_VERSION	"0.4"
>> -
>> -/* default timeout (secs) */
>> -#define WDT_TIMEOUT 30
>> -
>
> Personally I like those constants, even if used only once (I know, it is =
a good
> candidate for bikeshedding). Two reasons: 1) It is already there, and 2) =
It
> helps seeing the default without having to dig into the code.

I assume the WDT_VERSION can go away...

As far as the WDT_TIMEOUT, I have no problem leaving it. I was just trying =
to remove
some cruft.

>>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
>>  module_param(nowayout, bool, 0);
>>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
>> =20
>> -static unsigned int timeout =3D WDT_TIMEOUT;
>> -module_param(timeout, uint, 0);
>> -MODULE_PARM_DESC(timeout,
>> -	"Watchdog timeout in seconds. (1<=3Dtimeout<=3D3600, default=3D"
>> -				__MODULE_STRING(WDT_TIMEOUT) ")");
>> -
>
> Are you sure you want to take away the means to set the timeout with
> a module parameter ? You could easily retain the module parameter
> and call watchdog_init_timeout(wdd, timeout, dev). The parameter should
> then be initialized with 0, though, to have the watchdog core take the
> timeout from devicetree if provided.

Again, I have no problem leaving this. I personally don't use it but someon=
e else
might. I'm not sure if the ep93xx will ever get converted to devicetree but=
 I
might figure it one eventually.

<snip>

>> +	watchdog_set_drvdata(wdd, priv);
>> =20
>> -	setup_timer(&timer, ep93xx_wdt_timer_ping, 1);
>> +	ret =3D watchdog_register_device(wdd);
>
> Looks like a perfect candidate for devm_watchdog_register_device().

I just saw your patches that do this. I will update this patch to use it.

Thanks,
Hartley
