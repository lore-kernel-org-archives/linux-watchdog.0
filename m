Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35803 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdA1R1P (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 28 Jan 2017 12:27:15 -0500
Subject: Re: [PATCH] watchdog: constify watchdog_ops structures
To: Bhumika Goyal <bhumirks@gmail.com>
References: <1485589277-6824-1-git-send-email-bhumirks@gmail.com>
 <36f01795-aca8-72fc-8a83-26e92e2dee71@roeck-us.net>
 <CAOH+1jGTZdq1=VVQU9rkDgcHv-cxh8in3s+9hBE5hgRyQvpY9g@mail.gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, wim@iguana.be,
        Florian Fainelli <f.fainelli@gmail.com>, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        baruch@tkos.co.il, kgene@kernel.org, krzk@kernel.org,
        javier@osg.samsung.com, baohua@kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ac6e5b62-1189-a2a9-e50b-149acdbe7050@roeck-us.net>
Date: Sat, 28 Jan 2017 09:24:34 -0800
MIME-Version: 1.0
In-Reply-To: <CAOH+1jGTZdq1=VVQU9rkDgcHv-cxh8in3s+9hBE5hgRyQvpY9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/28/2017 07:30 AM, Bhumika Goyal wrote:
> On Sat, Jan 28, 2017 at 8:57 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 01/27/2017 11:41 PM, Bhumika Goyal wrote:
>>>
>>> Declare watchdog_ops structures as const as they are only stored in the
>>> ops field of a watchdog_device structure. This field is of type const, so
>>> watchdog_ops structures having this property can be made const too.
>>> Done using Coccinelle:
>>>
>>
>> I have a very similar patch from you already in my queue, one that was acked
>> and
>> reviewed by several people. Is this one different or are you just resending
>> ?
>>
>
> This is a different one. That patch was for watchdog_info structures
> and this one is for watchdog_ops.
>

Ah, slight but significant difference. Thanks for the clarification.

> Thanks,
> Bhumika
>
>> Guenter
>>
>>
>>> @r disable optional_qualifier@
>>> identifier x;
>>> position p;
>>> @@
>>> static struct watchdog_ops x@p={...};
>>>
>>> @ok@
>>> struct watchdog_device w;
>>> identifier r.x;
>>> position p;
>>> @@
>>> w.ops=&x@p;
>>>
>>> @bad@
>>> position p != {r.p,ok.p};
>>> identifier r.x;
>>> @@
>>> x@p
>>>
>>> @depends on !bad disable optional_qualifier@
>>> identifier r.x;
>>> @@
>>> +const
>>> struct watchdog_ops x;
>>>
>>> File size details before and after patching.
>>> First line of every .o file shows the file size before patching
>>> and second line shows the size after patching.
>>>
>>>    text    data     bss     dec     hex filename
>>>
>>>    1340     544       0    1884     75c drivers/watchdog/bcm_kona_wdt.o
>>>    1436     440       0    1876     754 drivers/watchdog/bcm_kona_wdt.o
>>>
>>>    1176     544       4    1724     6bc drivers/watchdog/digicolor_wdt.o
>>>    1272     440       4    1716     6b4 drivers/watchdog/digicolor_wdt.o
>>>
>>>     925     580      89    1594     63a drivers/watchdog/ep93xx_wdt.o
>>>    1021     476      89    1586     632 drivers/watchdog/ep93xx_wdt.o
>>>
>>>    4932     288      17    5237    1475 drivers/watchdog/s3c2410_wdt.o
>>>    5028     192      17    5237    1475 drivers/watchdog/s3c2410_wdt.o
>>>
>>>    1977     292       1    2270     8de drivers/watchdog/sama5d4_wdt.o
>>>    2073     196       1    2270     8de drivers/watchdog/sama5d4_wdt.o
>>>
>>>    1375     484       1    1860     744 drivers/watchdog/sirfsoc_wdt.o
>>>    1471     380       1    1852     73c drivers/watchdog/sirfsoc_wdt.o
>>>
>>> Size remains the same for the files drivers/watchdog/diag288_wdt.o
>>> drivers/watchdog/asm9260_wdt.o and drivers/watchdog/atlas7_wdt.o
>>>
>>> The following .o files did not compile:
>>> drivers/watchdog/sun4v_wdt.o, drivers/watchdog/sbsa_gwdt.o,
>>> drivers/watchdog/rt2880_wdt.o, drivers/watchdog/booke_wdt.o
>>> drivers/watchdog/mt7621_wdt.o

This is a bit misleading. "were not compiled" would have been more appropriate.
Either case, they all build fine.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>>>
>>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>>> ---
>>>  drivers/watchdog/asm9260_wdt.c   | 2 +-
>>>  drivers/watchdog/atlas7_wdt.c    | 2 +-
>>>  drivers/watchdog/bcm_kona_wdt.c  | 2 +-
>>>  drivers/watchdog/booke_wdt.c     | 2 +-
>>>  drivers/watchdog/diag288_wdt.c   | 2 +-
>>>  drivers/watchdog/digicolor_wdt.c | 2 +-
>>>  drivers/watchdog/ep93xx_wdt.c    | 2 +-
>>>  drivers/watchdog/mt7621_wdt.c    | 2 +-
>>>  drivers/watchdog/rt2880_wdt.c    | 2 +-
>>>  drivers/watchdog/s3c2410_wdt.c   | 2 +-
>>>  drivers/watchdog/sama5d4_wdt.c   | 2 +-
>>>  drivers/watchdog/sbsa_gwdt.c     | 2 +-
>>>  drivers/watchdog/sirfsoc_wdt.c   | 2 +-
>>>  drivers/watchdog/sun4v_wdt.c     | 2 +-
>>>  14 files changed, 14 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/asm9260_wdt.c
>>> b/drivers/watchdog/asm9260_wdt.c
>>> index d0b59ba..233dfa9 100644
>>> --- a/drivers/watchdog/asm9260_wdt.c
>>> +++ b/drivers/watchdog/asm9260_wdt.c
>>> @@ -189,7 +189,7 @@ static const struct watchdog_info asm9260_wdt_ident =
>>> {
>>>         .identity         =     "Alphascale asm9260 Watchdog",
>>>  };
>>>
>>> -static struct watchdog_ops asm9260_wdt_ops = {
>>> +static const struct watchdog_ops asm9260_wdt_ops = {
>>>         .owner          = THIS_MODULE,
>>>         .start          = asm9260_wdt_enable,
>>>         .stop           = asm9260_wdt_disable,
>>> diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
>>> index ed80734..4abdcab 100644
>>> --- a/drivers/watchdog/atlas7_wdt.c
>>> +++ b/drivers/watchdog/atlas7_wdt.c
>>> @@ -105,7 +105,7 @@ static const struct watchdog_info atlas7_wdt_ident = {
>>>         .identity = "atlas7 Watchdog",
>>>  };
>>>
>>> -static struct watchdog_ops atlas7_wdt_ops = {
>>> +static const struct watchdog_ops atlas7_wdt_ops = {
>>>         .owner = THIS_MODULE,
>>>         .start = atlas7_wdt_enable,
>>>         .stop = atlas7_wdt_disable,
>>> diff --git a/drivers/watchdog/bcm_kona_wdt.c
>>> b/drivers/watchdog/bcm_kona_wdt.c
>>> index e0c9842..80cdd16 100644
>>> --- a/drivers/watchdog/bcm_kona_wdt.c
>>> +++ b/drivers/watchdog/bcm_kona_wdt.c
>>> @@ -266,7 +266,7 @@ static int bcm_kona_wdt_stop(struct watchdog_device
>>> *wdog)
>>>                                             SECWDOG_SRSTEN_MASK, 0);
>>>  }
>>>
>>> -static struct watchdog_ops bcm_kona_wdt_ops = {
>>> +static const struct watchdog_ops bcm_kona_wdt_ops = {
>>>         .owner =        THIS_MODULE,
>>>         .start =        bcm_kona_wdt_start,
>>>         .stop =         bcm_kona_wdt_stop,
>>> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
>>> index 04da4b6..4925034 100644
>>> --- a/drivers/watchdog/booke_wdt.c
>>> +++ b/drivers/watchdog/booke_wdt.c
>>> @@ -197,7 +197,7 @@ static struct watchdog_info booke_wdt_info = {
>>>         .identity = "PowerPC Book-E Watchdog",
>>>  };
>>>
>>> -static struct watchdog_ops booke_wdt_ops = {
>>> +static const struct watchdog_ops booke_wdt_ops = {
>>>         .owner = THIS_MODULE,
>>>         .start = booke_wdt_start,
>>>         .stop = booke_wdt_stop,
>>> diff --git a/drivers/watchdog/diag288_wdt.c
>>> b/drivers/watchdog/diag288_wdt.c
>>> index 861d3d3..6f59108 100644
>>> --- a/drivers/watchdog/diag288_wdt.c
>>> +++ b/drivers/watchdog/diag288_wdt.c
>>> @@ -205,7 +205,7 @@ static int wdt_set_timeout(struct watchdog_device *
>>> dev, unsigned int new_to)
>>>         return wdt_ping(dev);
>>>  }
>>>
>>> -static struct watchdog_ops wdt_ops = {
>>> +static const struct watchdog_ops wdt_ops = {
>>>         .owner = THIS_MODULE,
>>>         .start = wdt_start,
>>>         .stop = wdt_stop,
>>> diff --git a/drivers/watchdog/digicolor_wdt.c
>>> b/drivers/watchdog/digicolor_wdt.c
>>> index 77df772..817d3f9 100644
>>> --- a/drivers/watchdog/digicolor_wdt.c
>>> +++ b/drivers/watchdog/digicolor_wdt.c
>>> @@ -96,7 +96,7 @@ static unsigned int dc_wdt_get_timeleft(struct
>>> watchdog_device *wdog)
>>>         return count / clk_get_rate(wdt->clk);
>>>  }
>>>
>>> -static struct watchdog_ops dc_wdt_ops = {
>>> +static const struct watchdog_ops dc_wdt_ops = {
>>>         .owner          = THIS_MODULE,
>>>         .start          = dc_wdt_start,
>>>         .stop           = dc_wdt_stop,
>>> diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
>>> index 0a4d7cc..8a6e1a7 100644
>>> --- a/drivers/watchdog/ep93xx_wdt.c
>>> +++ b/drivers/watchdog/ep93xx_wdt.c
>>> @@ -99,7 +99,7 @@ static const struct watchdog_info ep93xx_wdt_ident = {
>>>         .identity       = "EP93xx Watchdog",
>>>  };
>>>
>>> -static struct watchdog_ops ep93xx_wdt_ops = {
>>> +static const struct watchdog_ops ep93xx_wdt_ops = {
>>>         .owner          = THIS_MODULE,
>>>         .start          = ep93xx_wdt_start,
>>>         .stop           = ep93xx_wdt_stop,
>>> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
>>> index d5735c1..cb3651ae 100644
>>> --- a/drivers/watchdog/mt7621_wdt.c
>>> +++ b/drivers/watchdog/mt7621_wdt.c
>>> @@ -110,7 +110,7 @@ static struct watchdog_info mt7621_wdt_info = {
>>>         .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>>> WDIOF_MAGICCLOSE,
>>>  };
>>>
>>> -static struct watchdog_ops mt7621_wdt_ops = {
>>> +static const struct watchdog_ops mt7621_wdt_ops = {
>>>         .owner = THIS_MODULE,
>>>         .start = mt7621_wdt_start,
>>>         .stop = mt7621_wdt_stop,
>>> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
>>> index 14b4fd4..b2b472f 100644
>>> --- a/drivers/watchdog/rt2880_wdt.c
>>> +++ b/drivers/watchdog/rt2880_wdt.c
>>> @@ -124,7 +124,7 @@ static struct watchdog_info rt288x_wdt_info = {
>>>         .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>>> WDIOF_MAGICCLOSE,
>>>  };
>>>
>>> -static struct watchdog_ops rt288x_wdt_ops = {
>>> +static const struct watchdog_ops rt288x_wdt_ops = {
>>>         .owner = THIS_MODULE,
>>>         .start = rt288x_wdt_start,
>>>         .stop = rt288x_wdt_stop,
>>> diff --git a/drivers/watchdog/s3c2410_wdt.c
>>> b/drivers/watchdog/s3c2410_wdt.c
>>> index 59e9576..d48ba25 100644
>>> --- a/drivers/watchdog/s3c2410_wdt.c
>>> +++ b/drivers/watchdog/s3c2410_wdt.c
>>> @@ -394,7 +394,7 @@ static const struct watchdog_info s3c2410_wdt_ident =
>>> {
>>>         .identity         =     "S3C2410 Watchdog",
>>>  };
>>>
>>> -static struct watchdog_ops s3c2410wdt_ops = {
>>> +static const struct watchdog_ops s3c2410wdt_ops = {
>>>         .owner = THIS_MODULE,
>>>         .start = s3c2410wdt_start,
>>>         .stop = s3c2410wdt_stop,
>>> diff --git a/drivers/watchdog/sama5d4_wdt.c
>>> b/drivers/watchdog/sama5d4_wdt.c
>>> index a49634c..dc4c76b 100644
>>> --- a/drivers/watchdog/sama5d4_wdt.c
>>> +++ b/drivers/watchdog/sama5d4_wdt.c
>>> @@ -107,7 +107,7 @@ static const struct watchdog_info sama5d4_wdt_info = {
>>>         .identity = "Atmel SAMA5D4 Watchdog",
>>>  };
>>>
>>> -static struct watchdog_ops sama5d4_wdt_ops = {
>>> +static const struct watchdog_ops sama5d4_wdt_ops = {
>>>         .owner = THIS_MODULE,
>>>         .start = sama5d4_wdt_start,
>>>         .stop = sama5d4_wdt_stop,
>>> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
>>> index ce0c38b..c0d1d3b 100644
>>> --- a/drivers/watchdog/sbsa_gwdt.c
>>> +++ b/drivers/watchdog/sbsa_gwdt.c
>>> @@ -215,7 +215,7 @@ static struct watchdog_info sbsa_gwdt_info = {
>>>                           WDIOF_CARDRESET,
>>>  };
>>>
>>> -static struct watchdog_ops sbsa_gwdt_ops = {
>>> +static const struct watchdog_ops sbsa_gwdt_ops = {
>>>         .owner          = THIS_MODULE,
>>>         .start          = sbsa_gwdt_start,
>>>         .stop           = sbsa_gwdt_stop,
>>> diff --git a/drivers/watchdog/sirfsoc_wdt.c
>>> b/drivers/watchdog/sirfsoc_wdt.c
>>> index 3050a00..4eea351 100644
>>> --- a/drivers/watchdog/sirfsoc_wdt.c
>>> +++ b/drivers/watchdog/sirfsoc_wdt.c
>>> @@ -127,7 +127,7 @@ static const struct watchdog_info sirfsoc_wdt_ident =
>>> {
>>>         .identity         =     "SiRFSOC Watchdog",
>>>  };
>>>
>>> -static struct watchdog_ops sirfsoc_wdt_ops = {
>>> +static const struct watchdog_ops sirfsoc_wdt_ops = {
>>>         .owner = THIS_MODULE,
>>>         .start = sirfsoc_wdt_enable,
>>>         .stop = sirfsoc_wdt_disable,
>>> diff --git a/drivers/watchdog/sun4v_wdt.c b/drivers/watchdog/sun4v_wdt.c
>>> index 1467fe5..0090797 100644
>>> --- a/drivers/watchdog/sun4v_wdt.c
>>> +++ b/drivers/watchdog/sun4v_wdt.c
>>> @@ -77,7 +77,7 @@ static const struct watchdog_info sun4v_wdt_ident = {
>>>         .firmware_version = 0,
>>>  };
>>>
>>> -static struct watchdog_ops sun4v_wdt_ops = {
>>> +static const struct watchdog_ops sun4v_wdt_ops = {
>>>         .owner =        THIS_MODULE,
>>>         .start =        sun4v_wdt_ping,
>>>         .stop =         sun4v_wdt_stop,
>>>
>>
>

