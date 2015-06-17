Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.55]:41941 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbbFQK64 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 06:58:56 -0400
Message-ID: <558152E7.9020606@tronnes.org>
Date: Wed, 17 Jun 2015 12:58:47 +0200
From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>
CC: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: bcm2835: Add poweroff code for the Raspberry
 Pi
References: <1434195541-28368-1-git-send-email-noralf@tronnes.org> <1434195541-28368-2-git-send-email-noralf@tronnes.org> <557F930E.8010002@wwwdotorg.org> <557FEECE.9060909@tronnes.org> <5580CD4B.70003@wwwdotorg.org>
In-Reply-To: <5580CD4B.70003@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Den 17.06.2015 03:28, skrev Stephen Warren:
> On 06/16/2015 03:39 AM, Noralf Tr=C3=B8nnes wrote:
>> Den 16.06.2015 05:07, skrev Stephen Warren:
>>> On 06/13/2015 05:39 AM, Noralf Tr=C3=B8nnes wrote:
>>>> This adds a new poweroff function to the watchdog driver for the
>>>> Raspberry Pi. Currently poweroff/halt results in a reboot.
>>>>
>>>> The Raspberry Pi firmware uses the RSTS register to know which
>>>> partiton to boot from. The partiton value is spread into bits
>>>> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
>>>> the firmware to indicate halt.
>>>>
>>>> The firmware made this change in 19 Aug 2013 and was matched
>>>> by the downstream commit:
>>>> Changes for new NOOBS multi partition booting from gsh
>>> I don't understand why we need a new compatible value here; why not
>>> simply modify the existing bcm2835_power_off() function. That is wr=
itten
>>> to do something that's interpreted by the RPi firmware, not somethi=
ng
>>> that the bcm2835 HW does.
>>>
>>> Admittedly the current name is a bit misleading, but fixing that sh=
ould
>>> be a separate change to fixing the implementation to do what the cu=
rrent
>>> firmware expects.
>> There are other boards that use the BCM2835 and I didn't want to bre=
ak the
>> behaviour for those that use the reference firmware.
> We don't support those other board in mainline Linux AFAIK. In other
> discussions, Eric Anholt stated that the Roku 2 for example doesn't u=
se
> the same firmware (albeit they were derived from the same base a long
> way back apparently) so I have no good reason to believe this logic i=
s a
> standard across difference bcm2835 devices. Do you know more specific
> details?

I didn't know that only Raspberry Pi was supported and I have no detail=
s=20
about
the other boards. I'll send a new patch. Thanks.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
