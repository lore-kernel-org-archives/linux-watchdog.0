Return-Path: <paul@crapouillou.net>
Return-path: <paul@crapouillou.net>
Date: Thu, 28 Dec 2017 21:22:18 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/7] watchdog: jz4740: Use devm_* functions
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>,
	devicetree@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Message-Id: <1514492538.6093.1@smtp.crapouillou.net>
In-Reply-To: <994187b3-113c-88ef-8ebd-cd57d0c833a0@roeck-us.net>
References: <20171228162939.3928-1-paul@crapouillou.net>
	<20171228162939.3928-3-paul@crapouillou.net>
	<9778afd4-5841-0d48-cde3-c02872623a5f@roeck-us.net>
	<1514491167.6093.0@smtp.crapouillou.net>
	<994187b3-113c-88ef-8ebd-cd57d0c833a0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>



Le jeu. 28 d=E9c. 2017 =E0 21:19, Guenter Roeck <linux@roeck-us.net> a=20
=E9crit :
> On 12/28/2017 11:59 AM, Paul Cercueil wrote:
>> Hi Guenter,
>>=20
>> Le jeu. 28 d=E9c. 2017 =E0 18:48, Guenter Roeck <linux@roeck-us.net> a=20
>> =E9crit :
>>> On 12/28/2017 08:29 AM, Paul Cercueil wrote:
>>>> - Use devm_clk_get instead of clk_get
>>>> - Use devm_watchdog_register_device instead of=20
>>>> watchdog_register_device
>>>>=20
>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>> ---
>>>>   drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
>>>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>>>=20
>>>> diff --git a/drivers/watchdog/jz4740_wdt.c=20
>>>> b/drivers/watchdog/jz4740_wdt.c
>>>> index 6955deb100ef..92d6ca8ceb49 100644
>>>> --- a/drivers/watchdog/jz4740_wdt.c
>>>> +++ b/drivers/watchdog/jz4740_wdt.c
>>>> @@ -178,40 +178,29 @@ static int jz4740_wdt_probe(struct=20
>>>> platform_device *pdev)
>>>>   =7F      res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>       drvdata->base =3D devm_ioremap_resource(&pdev->dev, res);
>>>> -    if (IS_ERR(drvdata->base)) {
>>>> -        ret =3D PTR_ERR(drvdata->base);
>>>> -        goto err_out;
>>>> -    }
>>>> +    if (IS_ERR(drvdata->base))
>>>> +        return PTR_ERR(drvdata->base);
>>>>   =7F-    drvdata->rtc_clk =3D clk_get(&pdev->dev, "rtc");
>>>> +    drvdata->rtc_clk =3D devm_clk_get(&pdev->dev, "rtc");
>>>>       if (IS_ERR(drvdata->rtc_clk)) {
>>>>           dev_err(&pdev->dev, "cannot find RTC clock\n");
>>>> -        ret =3D PTR_ERR(drvdata->rtc_clk);
>>>> -        goto err_out;
>>>> +        return PTR_ERR(drvdata->rtc_clk);
>>>>       }
>>>>   =7F-    ret =3D watchdog_register_device(&drvdata->wdt);
>>>> +    ret =3D devm_watchdog_register_device(&pdev->dev,=20
>>>> &drvdata->wdt);
>>>>       if (ret < 0)
>>>> -        goto err_disable_clk;
>>>> +        return ret;
>>>>   =7F      platform_set_drvdata(pdev, drvdata);
>>>> -    return 0;
>>>>   =7F-err_disable_clk:
>>>> -    clk_put(drvdata->rtc_clk);
>>>> -err_out:
>>>> -    return ret;
>>>> +    return 0;
>>>>   }
>>>>   =7F  static int jz4740_wdt_remove(struct platform_device *pdev)
>>>>   {
>>>>       struct jz4740_wdt_drvdata *drvdata =3D=20
>>>> platform_get_drvdata(pdev);
>>>>   =7F-    jz4740_wdt_stop(&drvdata->wdt);
>>>> -    watchdog_unregister_device(&drvdata->wdt);
>>>> -    clk_put(drvdata->rtc_clk);
>>>> -
>>>> -    return 0;
>>>> +    return jz4740_wdt_stop(&drvdata->wdt);
>>>=20
>>> If the watchdog is running, the module can not be unloaded. Even if=20
>>> that wasn't
>>> the case, this defeats both WDIOF_MAGICCLOSE and=20
>>> watchdog_set_nowayout().
>>> Are you sure this is what you want ? If so, please call
>>> watchdog_stop_on_unregister() before registration; this clarifies=20
>>> that this
>>> is what you want, and you can drop the remove function.
>>>=20
>>> Thanks,
>>> Guenter
>>=20
>> This patch does not change the behaviour. We always used that driver=20
>> built-in; what
>> should the behaviour be when unloading the module? Keep the watchdog=20
>> hardware running
>> if configured for 'nowayout'?
>>=20
>=20
> One can still unload the driver. If you are fine with=20
> bypassing/dfeating nowayout
> and WDIOF_MAGICCLOSE, may I ask why those are enabled in the first=20
> place ?
>=20

Who knows? That code is very old :)
I'm fine with removing the remove() function completely, if you think=20
it makes more sense.

Thanks,
-Paul
=
