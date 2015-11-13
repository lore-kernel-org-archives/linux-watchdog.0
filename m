Return-path: <mru@mansr.com>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,  linux-kernel@vger.kernel.org,  linux-watchdog@vger.kernel.org
Subject: Re: [RESEND][PATCH] watchdog: add support for Sigma Designs SMP86xx
References: <1447420459-5301-1-git-send-email-mans@mansr.com>
	<56461155.80808@roeck-us.net> <yw1x37w9lu26.fsf@unicorn.mansr.com>
	<5646240C.5070105@roeck-us.net>
Date: Fri, 13 Nov 2015 18:02:35 +0000
In-Reply-To: <5646240C.5070105@roeck-us.net> (Guenter Roeck's message of "Fri,
	13 Nov 2015 09:55:24 -0800")
Message-ID: <yw1xpozdkcas.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck <linux@roeck-us.net> writes:

>>>> +config TANGOX_WDT
>>>> +	tristate "SMP86xx watchdog"
>>>> +	select WATCHDOG_CORE
>>>> +	depends on ARCH_TANGOX
>>>> +	help
>>>> +	  Watchdog driver for Sigma Designs SMP86xx.
>>>
>>> Not really; it is for SMP8642, and we don't know if other (later ?) chi=
ps
>>> will be supported by the same driver. You should be explicit here. More=
 chips
>>> can be added later (that would be needed for the devicetree bindings an=
yway)
>>> as they are tested.
>>
>> I have tested it on SMP8642 and SMP8759.  The documentation for SMP8654
>> agrees.
>>
>
> We should have that information somewhere - maybe in the driver header.
> It is very useful to know which hardware this was tested with and which
> hardware is supposed to work.

OK, I'll add that info somewhere.

>>>> +static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
>>>> +				  unsigned int new_timeout)
>>>> +{
>>>> +	struct tangox_wdt_device *dev =3D watchdog_get_drvdata(wdt);
>>>> +
>>>> +	wdt->timeout =3D new_timeout;
>>>> +	dev->timeout =3D 1 + new_timeout * clk_get_rate(dev->clk);
>>>
>>> Why "1 +" ?
>>
>> The counter counts down from the loaded value and asserts the reset pin
>> when it reaches 1.  Setting it to zero disables the watchdog.
>
> You might want to explain that somewhere. Maybe use a define, explain
> it there, and use the define here and below.

Will do.

>>>> +static const struct of_device_id tangox_wdt_dt_ids[] =3D {
>>>> +	{ .compatible =3D "sigma,smp8642-wdt" },
>>>
>>> So this is really for smp8642 only, not for any other chips in the seri=
es ?
>>
>> It's for about a dozen SMP86xx, SMP87xx, and SMP89xx chips.  Should I
>> list them all?  I don't even know where to find a comprehensive list of
>> device numbers.
>>
> I thought so, but I am not a devicetree expert, and I see some "xx" in
> existing devicetree bindings. Something to ask when you submit the
> bindings to the devicetree mailing list. Either case, I think it would
> be either something like "sigma,smp86xx-wdt" or a list of all of them,
> but not "sigma,smp8642-wdt" to be used for all chips.

The general advice is to not use wildcards in DT bindings since the next
chip matching the pattern might not be compatible at all.  New chips
known to be compatible with an old one can specify both the exact chip
and the older one such that existing drivers will work automatically.
If at some point they are found not to be compatible after all (hardware
bugs, perhaps) a fixed driver will work with existing device trees.

Thanks for the review.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
