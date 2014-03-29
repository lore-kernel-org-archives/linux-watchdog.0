Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:61846 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbaC2Nvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 29 Mar 2014 09:51:35 -0400
MIME-Version: 1.0
In-Reply-To: <1396100017.585010881@f331.i.mail.ru>
References: <CACna6rwRzw1fo2_DyV3T4fa4+cA3=LTcFHRpRsfZWwR2ugQn_w@mail.gmail.com>
	<1396096185.560264234@f368.i.mail.ru>
	<5336C7B8.90707@hauke-m.de>
	<1396100017.585010881@f331.i.mail.ru>
Date: Sat, 29 Mar 2014 14:51:34 +0100
Message-ID: <CACna6rw5eryfe_yFzUs4oTv697LudngogmdOJNK-P8Qq12fJLQ@mail.gmail.com>
Subject: Re: Extending wdt-gpio to be used on non-of (no DT) platforms
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>,
	linux-watchdog@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>, m.adam--linux@adamis.de
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2014-03-29 14:33 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> Sat, 29 Mar 2014 14:16:40 +0100 =D0=BE=D1=82 Hauke Mehrtens <hauke@ha=
uke-m.de>:
>> The Huawei E970, the only device with a bcm47xx SoC which uses this =
gpio
>> watchdog I know of, needs the gpio driver very early. It is not poss=
ible
>> to deactivate the watchdogs, so it has to get trigged very early in =
the
>
> Why it cannot be deactivated?
> The driver has been designed for ADM70x ICs, where watchdog is
> deactivated by set GPIO to tristate.

I'm not sure how to achieve tri-state with Broadcom SoC. Our code is in=
:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/bcma/driver_gpio.c

We have bcma_chipco_gpio_control that sets if GPIO is controlled by
ChipCommon (part of the SoC, one of many cores).
Maybe setting GPIO to be *not* controlled by ChipCommon will make it tr=
i-state?

Any other ideas?

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
