Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:57826 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbaC2NQt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 29 Mar 2014 09:16:49 -0400
Message-ID: <5336C7B8.90707@hauke-m.de>
Date: Sat, 29 Mar 2014 14:16:40 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Alexander Shiyan <shc_work@mail.ru>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC: devicetree@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>,
	linux-watchdog@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>, m.adam--linux@adamis.de
Subject: Re: Extending wdt-gpio to be used on non-of (no DT) platforms
References: <CACna6rwRzw1fo2_DyV3T4fa4+cA3=LTcFHRpRsfZWwR2ugQn_w@mail.gmail.com> <1396096185.560264234@f368.i.mail.ru>
In-Reply-To: <1396096185.560264234@f368.i.mail.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/29/2014 01:29 PM, Alexander Shiyan wrote:
> Sat, 29 Mar 2014 12:54:40 +0100 =D0=BE=D1=82 Rafa=C5=82 Mi=C5=82ecki =
<zajec5@gmail.com>:
>> Hi guys,
>>
>> I've noticed gpio_wdt was added to the kernel to support some device=
s
>> based on devicetree.
>> We used to have our own (not mainlined) gpio_wdt in OpenWrt project:
>> http://git.openwrt.org/?p=3Dopenwrt.git;a=3Dblob;f=3Dtarget/linux/ge=
neric/patches-3.10/990-gpio_wdt.patch;hb=3DHEAD
>>
>> The main difference is that the mainlined one uses OF, while OpenWrt=
's
>> one uses plain platform API (with struct gpio_wdt_platform_data).
>>
>> I wanted to bring a topic of mainlining OpenWrt's solution. We
>> definitely need that and at the same time our device(s) don't use OF=
 /
>> DT.
>>
>> Do you think we should extend wdt-gpio to handle that? Or do you thi=
nk
>> this driver is so small, it's not worth it and we should submit a
>> separated one?
>>
>> Apart from API being used, one other difference I see is OpenWrt
>> supports different values for "first tick" and "interval". But that
>> could be easily handled.
>=20
> In fact, this driver can be extended to non-DT support without adding
> any platform_data headers. This can be implemented by convert driver
> to using descriptor-based GPIO functions (gpiod_{}).
> HW timeout value in this case can be taken with module_param().

The Huawei E970, the only device with a bcm47xx SoC which uses this gpi=
o
watchdog I know of, needs the gpio driver very early. It is not possibl=
e
to deactivate the watchdogs, so it has to get trigged very early in the
boot process. Module load time is too late. I think wdt-gpio should be
extended to support the old platform device interface with a own
platform_data header.

I added Mathias Adam, the author of the patch in OpenWrt.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
