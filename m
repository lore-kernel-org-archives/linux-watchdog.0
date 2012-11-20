Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34243 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2KTMvH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Nov 2012 07:51:07 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5841484oag.19
        for <linux-watchdog@vger.kernel.org>; Tue, 20 Nov 2012 04:51:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121119160643.GI22106@titan.lakedaemon.net>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
 <1353334243-16703-4-git-send-email-fabio.porcedda@gmail.com> <20121119160643.GI22106@titan.lakedaemon.net>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Tue, 20 Nov 2012 13:50:46 +0100
Message-ID: <CAHkwnC-2MXtNODnqjOvFuHt7ToqvMqeDjnqdGyGfMacKBWzoLw@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] watchdog: orion_wdt: add timeout-sec property binding
To: Jason Cooper <jason@lakedaemon.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 5:06 PM, Jason Cooper <jason@lakedaemon.net> wrot=
e:
> On Mon, Nov 19, 2012 at 03:10:38PM +0100, Fabio Porcedda wrote:
>> Only compile tested.
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> ---
>>  Documentation/devicetree/bindings/watchdog/marvel.txt | 5 +++++
>>  drivers/watchdog/orion_wdt.c                          | 8 +++-----
>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/D=
ocumentation/devicetree/bindings/watchdog/marvel.txt
>> index 0b2503a..5dc8d30 100644
>> --- a/Documentation/devicetree/bindings/watchdog/marvel.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
>> @@ -5,10 +5,15 @@ Required Properties:
>>  - Compatibility : "marvell,orion-wdt"
>>  - reg                : Address of the timer registers
>>
>> +Optional properties:
>> +
>> +- timeout-sec        : Contains the watchdog timeout in seconds
>> +
>>  Example:
>>
>>       wdt@20300 {
>>               compatible =3D "marvell,orion-wdt";
>>               reg =3D <0x20300 0x28>;
>> +             timeout-sec =3D <10>;
>>               status =3D "okay";
>>       };
>> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt=
.c
>> index c20f96b..446a3e9 100644
>> --- a/drivers/watchdog/orion_wdt.c
>> +++ b/drivers/watchdog/orion_wdt.c
>> @@ -162,12 +162,10 @@ static int __devinit orion_wdt_probe(struct plat=
form_device *pdev)
>>
>>       wdt_max_duration =3D WDT_MAX_CYCLE_COUNT / wdt_tclk;
>>
>> -     if ((heartbeat < 1) || (heartbeat > wdt_max_duration))
>> -             heartbeat =3D wdt_max_duration;
>> -
>> -     orion_wdt.timeout =3D heartbeat;
>>       orion_wdt.min_timeout =3D 1;
>> +     orion_wdt.timeout =3D wdt_max_duration;
>>       orion_wdt.max_timeout =3D wdt_max_duration;
>> +     watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
>
> Hi Fabio,
>
> There are many boards using pdata, !CONFIG_OF.  Have you compile-tested
> this without CONFIG_OF?

Hi Jason,

I've tested with and without the CONFIG_OF define.

The first time I=92ve used the kirkwood_defconfig without modifications,
the second time I=92ve enabled only the CONFIG_MACH_SHEEVAPLUG and
disabled USE_OF.

In both cases the orion_wdt driver compile without any warning.

Thanks for the review.

Best regards

> thx,
>
> Jason.
>
>>
>>       watchdog_set_nowayout(&orion_wdt, nowayout);
>>       ret =3D watchdog_register_device(&orion_wdt);
>> @@ -177,7 +175,7 @@ static int __devinit orion_wdt_probe(struct platfo=
rm_device *pdev)
>>       }
>>
>>       pr_info("Initial timeout %d sec%s\n",
>> -             heartbeat, nowayout ? ", nowayout" : "");
>> +             orion_wdt.timeout, nowayout ? ", nowayout" : "");
>>       return 0;
>>  }
>>
>> --
>> 1.8.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
Fabio Porcedda
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
