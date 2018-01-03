Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34994 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeACEq0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 2 Jan 2018 23:46:26 -0500
Subject: Re: [PATCH v2 5/8] MIPS: jz4740: dts: Add bindings for the jz4740-wdt
 driver
To: Paul Cercueil <paul@crapouillou.net>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-5-paul@crapouillou.net>
 <CANc+2y5ZUM_ZzXaGgbx9b7O1GF4GrbaYsv97G+akvhP2d2VVUA@mail.gmail.com>
 <1514911698.3623.1@smtp.crapouillou.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <698e7ae5-9f19-1282-7b82-0e2fd2080906@roeck-us.net>
Date: Tue, 2 Jan 2018 20:46:22 -0800
MIME-Version: 1.0
In-Reply-To: <1514911698.3623.1@smtp.crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/02/2018 08:48 AM, Paul Cercueil wrote:
> Hi PrasannaKumar,
> 
> Le mar. 2 janv. 2018 à 17:37, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com> a écrit :
>> Hi Paul,
>>
>> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
>>>  Also remove the watchdog platform_device from platform.c, since it
>>>  wasn't used anywhere anyway.
>>>
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  ---
>>>   arch/mips/boot/dts/ingenic/jz4740.dtsi |  8 ++++++++
>>>   arch/mips/jz4740/platform.c            | 16 ----------------
>>>   2 files changed, 8 insertions(+), 16 deletions(-)
>>>
>>>   v2: No change
>>>
>>>  diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>  index cd5185bb90ae..26c6b561d6f7 100644
>>>  --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>  +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>>  @@ -45,6 +45,14 @@
>>>                  #clock-cells = <1>;
>>>          };
>>>
>>>  +       watchdog: watchdog@10002000 {
>>>  +               compatible = "ingenic,jz4740-watchdog";
>>>  +               reg = <0x10002000 0x10>;
>>>  +
>>>  +               clocks = <&cgu JZ4740_CLK_RTC>;
>>>  +               clock-names = "rtc";
>>>  +       };
>>>  +
>>
>> The watchdog driver calls jz4740_timer_enable_watchdog and
>> jz4740_timer_disable_watchdog which defined in
>> arch/mips/jz4740/timer.c. It accesses registers iomapped by timer
>> code. Declaring register size as 0x10 does not show the real picture.
>> Better use register size as 0x100 and let timer, wdt, pwm drivers to
>> share them.
> 
> As you said, it accesses registers iomapped by timer code. So the watchdog
> driver doesn't need to iomap them.
> 
>> Code from one of your branches
>> (https://github.com/OpenDingux/linux/blob/for-upstream-clocksource/arch/mips/boot/dts/ingenic/jz4740.dtsi)
>> does it. Can you prepare a patch series and send it?
>> I have a patch set that moves timer code out of arch/mips/jz4740/ and
>> does a similar thing for watchdog and pwm. As your new timer driver is
>> better than the existing one I have not sent my patches yet. I would
>> like to see it getting mainlined as it paves way for removing most of
>> code in arch/mips/jz4740.
> 
> The whole 'for-upstream-clocksource' branch is supposed to go upstream,
> but I can't do it in one big patchset without having lots of breakages with
> my other patchsets (jz4770 SoC support, and jz4740 watchdog updates)
> currently under review. That also makes it simpler to upstream than having
> one single patchset that touches 6 different frameworks (MIPS, irq, clocks,
> clocksource, watchdog, PWM).
> 
> So I will submit it in two steps, first the irq/clocks/clocksource drivers
> (this patchset) hopefully for 4.16, and then the platform/watchdog/PWM fixes
> for 4.17.
> 

I kind of lost it in this exchange, sorry. At this point I don't know if something
is wrong with the watchdog patches, and I have no clue what the upstream path
is supposed to be. My working assumption is that 1) something may be wrong with
the current version of the patches, and, 2), even if not, none of the patches
is expected to find its way upstream through the watchdog subsystem. Plus, 3),
even if some of the patches are supposed to go upstream through the watchdog
subsystem, that won't happen in 4.16, and the patches will be resubmitted later
when they are ready [and will hopefully marked clearly for submission through
the watchdog subsystem].

With that in mind, I'll mark the series for my reference as "not applicable".
If this is wrong please let me know.

Guenter
