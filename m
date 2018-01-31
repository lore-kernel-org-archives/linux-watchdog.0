Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33823 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeAaPh2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 10:37:28 -0500
MIME-Version: 1.0
In-Reply-To: <007dd1e3-70fd-69ad-fd02-4719e958b41c@roeck-us.net>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517343778-27902-12-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180130220504.GA16709@roeck-us.net> <TY1PR06MB0895ECB2936323F9D281C1EFC0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <CAMuHMdViQgCjVFbs0kkBObAAoFTzvz8yPFUHPWHrtYzkbnYm_g@mail.gmail.com> <007dd1e3-70fd-69ad-fd02-4719e958b41c@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 31 Jan 2018 16:37:27 +0100
Message-ID: <CAMuHMdXPntakrTvdOs4p5xvzJOS7ujmyztSuGEyMDnen5QZOxg@mail.gmail.com>
Subject: Re: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2 support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi G=C3=BCnter,

On Wed, Jan 31, 2018 at 3:48 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/31/2018 04:13 AM, Geert Uytterhoeven wrote:
>> On Wed, Jan 31, 2018 at 11:47 AM, Fabrizio Castro
>> <fabrizio.castro@bp.renesas.com> wrote:
>>>> Subject: Re: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2
>>>> support
>>>> On Tue, Jan 30, 2018 at 08:22:44PM +0000, Fabrizio Castro wrote:
>>>>>
>>>>> On R-Car Gen2 and RZ/G1 the rwdt clock needs to be always ON, therefo=
re
>>>>> when suspending to RAM we need to explicitly disable the counting by
>>>>> clearing TME from RWTCSRA.
>>>>> Also, on some systems RWDT is the only piece of HW that allows the So=
C
>>>>> to be restarted, therefore this patch implements the restart callback=
.
>>>>>
>>>>> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>>>>> Signed-off-by: Ramesh Shanmugasundaram
>>>>> <ramesh.shanmugasundaram@bp.renesas.com>
>>>>> ---
>>>>> Wolfram, was the restart callback implementation missing for a reason=
?
>>>>> Is its implementation going to break any Gen3 platform?
>>>>
>>>> The changes clearly are way more than claimed in the subject. Adding
>>>> restart handler and PM support may be prerequisites for Gen2, but the
>>>> changes apply to Gen3 as well. What happened to "one patch per logical
>>>> change" ?
>>>
>>> The PM implementation should be ok for Gen3 too, without this patch
>>> series the kernel
>>> would disable the rwdt clock when suspending to RAM, this would "pause"
>>> the counting.
>>> This patch series declares the rwdt clock as critical for Gen2 and RZ/G=
1,
>>> which means we
>>> need to explicitly disable the counting to keep the same behaviour in
>>> place.
>>
>> Note that if the kernel crashes after rwdt_suspend(), the watchdog won't
>> restart the system. But that's an issue common to many watchdog driver,
>> right?
>>
> If so, that would be buggy.

All watchdog drivers implementing a system suspend handler stop the watchdo=
g
before suspending the system. I guess if they wouldn't do that, the watchdo=
g
would restart the system while asleep?

Exceptions are:
  - atlas7_wdt, sirfsoc_wdt: these seem to rely on another driver stopping
    the watchdog clock, so it behaves the same as all above,
  - diag288_wdt: this returns -EBUSY when trying to suspend the system
    while the watchdog is enabled, to put the burden of disabling the
    watchdog on the user,
  - ux500_wdt: this seems to use a hardware feature to automatically
    disable the watchdog during suspend.

So only the last one seems to protect against kernel crashes after the
watchdog's suspend method is called...

Note that two drivers (iTCO_wdt and wdat_wdt) implements suspend_noirq
instead of suspend, which decreases the window of running without a watchdo=
g
a bit.

>>> With respect to the restart callback implementation, that may well have
>>> consequences on
>>> Gen3, hopefully Wolfram will give us a feedback on this.
>>> In particular I would like to know if we should be installing the resta=
rt
>>> callback only when
>>> we use "renesas,rcar-gen2-wdt" as compatible string, or it's ok to make
>>> it available for
>>> Gen3 as well.
>>
>> IIRC, the reason we don't have the restart callback on R-Car Gen3 is the
>> arm64 maintainers insisting on using PSCI, and vetoing other means,
>> to restart the system.
>
> You could just give it lower priority than PSCI.
>
>> Which leaves us with a few boards where we have to use the watchdog, and
>> wait until the timeout triggers...
>
> Which means the veto is counter-productive and thus meaningless.

I do welcome that point of view ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
