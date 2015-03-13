Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35252 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbbCMKeB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 06:34:01 -0400
Received: by wggy19 with SMTP id y19so22279727wgg.2
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2015 03:34:00 -0700 (PDT)
Message-ID: <5502BD17.6030509@linaro.org>
Date: Fri, 13 Mar 2015 11:33:59 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 00/10] Atmel System Timer cleanups
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com> <5502BA89.8020100@linaro.org> <20150313103329.GF4329@piout.net>
In-Reply-To: <20150313103329.GF4329@piout.net>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/13/2015 11:33 AM, Alexandre Belloni wrote:
> On 13/03/2015 at 11:23:05 +0100, Daniel Lezcano wrote :
>> On 03/12/2015 01:07 PM, Alexandre Belloni wrote:
>>> This patch set cleans up the system timer driver.
>>>
>>> The main goal is to get rid of the mach/ headers dependency. At the=
 same time,
>>> it introduces proper probing and locking (using a regmap) for the w=
atchdog
>>> driver.
>>>
>>> This is based on 4.0-rc1 and will have two merge conflicts with my =
cleanup #1 in
>>> mach-at91/at91rm9200.c
>>>
>>> It also needs this patch to probe the watchdog properly:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/32=
7274.html
>>
>>
>> Hi Alexandre,
>>
>> through which tree do you want this patchset to be merged ?
>>
>
> I'd say through the at91 tree as I have another series that depend on
> that one

Ok.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
