Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:51829 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbaKYPrf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Nov 2014 10:47:35 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so1226761wgh.20
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Nov 2014 07:47:33 -0800 (PST)
Message-ID: <5474A490.5050606@linaro.org>
Date: Tue, 25 Nov 2014 16:47:28 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 0/3] Make Armada 375 use the reference clock when possible
References: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com> <546C6226.5000900@linaro.org> <20141119104535.GB8973@spo001.leaseweb.nl> <5472F48E.40802@linaro.org> <20141125133409.GC19785@spo001.leaseweb.nl>
In-Reply-To: <20141125133409.GC19785@spo001.leaseweb.nl>
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/25/2014 02:34 PM, Wim Van Sebroeck wrote:
> Hi Daniel,
>
> I'm OK with the patchset. You can add my Acked-by.

Thanks. Applied to my tree for 3.19.

   -- Daniel



>
> Kind regards,
> Wim.
>
>> On 11/19/2014 11:45 AM, Wim Van Sebroeck wrote:
>>> Hi Daniel,
>>>
>>> I'll review before the weekend and will let you know something.
>>> But everything through one tree is fine by me.
>>
>> Hi Wim,
>>
>> did you have time to review this patchset ? I would like to send my =
PR
>> for tglx as soon as possible.
>>
>> Thanks
>>    -- Daniel
>>
>>>
>>> Kind regards,
>>> Wim.
>>>
>>>> On 11/04/2014 02:21 PM, Ezequiel Garcia wrote:
>>>>> Hi Daniel, Wim:
>>>>>
>>>>> Seems we are ready to merge these, unless some objection raises. =
Do you
>>>>> think
>>>>> you can take the patches through your trees?
>>>>
>>>> Hi Wim,
>>>>
>>>> I can take through my tree the entire patchset if you want but I n=
eed
>>>> your blessing for the watchdog part.
>>>>
>>>> Thanks
>>>>    -- Daniel
>>>>
>>>>> Changes from v2:
>>>>>
>>>>>    * Fix messed up empty lines, as suggested by Thomas Petazzoni.
>>>>>
>>>>> Changes from v1:
>>>>>
>>>>>    * Make the A375 timer and watchdog devicetree binding match th=
e
>>>>>    hardware
>>>>>      and require the two available clocks: core and reference clo=
ck.
>>>>>
>>>>> This series adds support for the 25 MHz reference clock available=
 on
>>>>> Armada 375 SoC to be used on the timer and watchdog drivers. It i=
s
>>>>> similar to the one present in Armada XP SoC.
>>>>>
>>>>> Given we initially had access to only a very early SoC revision (=
A375 Z1)
>>>>> and due to a hardware issue, the timer and watchdog support was
>>>>> originally
>>>>> submitted to use the core clock.
>>>>>
>>>>> Now that the A0 SoC revision is out, we can fix this and use the
>>>>> reference
>>>>> clock. The reason for this change is that the core clock is subje=
ct to
>>>>> the
>>>>> SSCG (Spread Spectrum Clock Generator), so boards where SSCG is e=
nabled
>>>>> exhibit a very large timer drift.
>>>>>
>>>>> Notice that this change will produce unpleseant results on A375 Z=
1, given
>>>>> the
>>>>> reference 25 MHz clock doesn't work properly on that SoC revision=
=2E
>>>>>
>>>>> But since the Z1 revision is not supported by the recently submit=
ted A375
>>>>> network driver (mvpp2), and therefore nobody is expected to run m=
ainline
>>>>> (if there are users at all of this early revision), the support w=
ill be
>>>>> dropped entirely in a near future.
>>>>>
>>>>> To prevent any compatibility issues when booting with an older
>>>>> devicetree,
>>>>> this series provides proper fall backs in each case.
>>>>>
>>>>> The series applies on v3.18-rc2.
>>>>>
>>>>> Ezequiel Garcia (3):
>>>>>    clocksource: armada-370-xp: Add missing clock enable
>>>>>    watchdog: orion: Use the reference clock on Armada 375 SoC
>>>>>    clocksource: armada-370-xp: Use the reference clock on A375 So=
C
>>>>>
>>>>>   .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++--
>>>>>   .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
>>>>>   drivers/clocksource/time-armada-370-xp.c           | 30
>>>>>   ++++++++++++++++
>>>>>   drivers/watchdog/orion_wdt.c                       | 42
>>>>>   +++++++++++++++++++++-
>>>>>   4 files changed, 90 insertions(+), 4 deletions(-)
>>>>>
>>>>
>>>>
>>>> --
>>>>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source softwa=
re for ARM
>>>>   SoCs
>>>>
>>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>>> <http://twitter.com/#!/linaroorg> Twitter |
>>>> <http://www.linaro.org/linaro-blog/> Blog
>>>>
>>
>>
>> --
>>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software=
 for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


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
