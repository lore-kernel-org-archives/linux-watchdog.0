Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:12982 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500AbbCMQgT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 12:36:19 -0400
Message-ID: <550311FA.9000908@atmel.com>
Date: Fri, 13 Mar 2015 17:36:10 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	"Jean-Christophe Plagniol-Villard" <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v5 00/10] Atmel System Timer cleanups
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com> <5502BA89.8020100@linaro.org> <20150313103329.GF4329@piout.net> <5502BD17.6030509@linaro.org>
In-Reply-To: <5502BD17.6030509@linaro.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Le 13/03/2015 11:33, Daniel Lezcano a =C3=A9crit :
> On 03/13/2015 11:33 AM, Alexandre Belloni wrote:
>> On 13/03/2015 at 11:23:05 +0100, Daniel Lezcano wrote :
>>> On 03/12/2015 01:07 PM, Alexandre Belloni wrote:
>>>> This patch set cleans up the system timer driver.
>>>>
>>>> The main goal is to get rid of the mach/ headers dependency. At the =
same time,
>>>> it introduces proper probing and locking (using a regmap) for the wa=
tchdog
>>>> driver.
>>>>
>>>> This is based on 4.0-rc1 and will have two merge conflicts with my c=
leanup #1 in
>>>> mach-at91/at91rm9200.c
>>>>
>>>> It also needs this patch to probe the watchdog properly:
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327=
274.html
>>>
>>>
>>> Hi Alexandre,
>>>
>>> through which tree do you want this patchset to be merged ?
>>>
>>
>> I'd say through the at91 tree as I have another series that depend on
>> that one
>=20
> Ok.

Absolutely. To the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And I stack it on at91-4.1-cleanup right now.

Bye,
--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
