Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40278 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbeAaMNQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 07:13:16 -0500
MIME-Version: 1.0
In-Reply-To: <TY1PR06MB0895ECB2936323F9D281C1EFC0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517343778-27902-12-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180130220504.GA16709@roeck-us.net> <TY1PR06MB0895ECB2936323F9D281C1EFC0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 31 Jan 2018 13:13:13 +0100
Message-ID: <CAMuHMdViQgCjVFbs0kkBObAAoFTzvz8yPFUHPWHrtYzkbnYm_g@mail.gmail.com>
Subject: Re: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2 support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
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
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabrizio,

On Wed, Jan 31, 2018 at 11:47 AM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
>> Subject: Re: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2 support
>> On Tue, Jan 30, 2018 at 08:22:44PM +0000, Fabrizio Castro wrote:
>> > On R-Car Gen2 and RZ/G1 the rwdt clock needs to be always ON, therefore
>> > when suspending to RAM we need to explicitly disable the counting by
>> > clearing TME from RWTCSRA.
>> > Also, on some systems RWDT is the only piece of HW that allows the SoC
>> > to be restarted, therefore this patch implements the restart callback.
>> >
>> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
>> > ---
>> > Wolfram, was the restart callback implementation missing for a reason?
>> > Is its implementation going to break any Gen3 platform?
>>
>> The changes clearly are way more than claimed in the subject. Adding
>> restart handler and PM support may be prerequisites for Gen2, but the
>> changes apply to Gen3 as well. What happened to "one patch per logical
>> change" ?
>
> The PM implementation should be ok for Gen3 too, without this patch series the kernel
> would disable the rwdt clock when suspending to RAM, this would "pause" the counting.
> This patch series declares the rwdt clock as critical for Gen2 and RZ/G1, which means we
> need to explicitly disable the counting to keep the same behaviour in place.

Note that if the kernel crashes after rwdt_suspend(), the watchdog won't
restart the system. But that's an issue common to many watchdog driver, right?

> With respect to the restart callback implementation, that may well have consequences on
> Gen3, hopefully Wolfram will give us a feedback on this.
> In particular I would like to know if we should be installing the restart callback only when
> we use "renesas,rcar-gen2-wdt" as compatible string, or it's ok to make it available for
> Gen3 as well.

IIRC, the reason we don't have the restart callback on R-Car Gen3 is the
arm64 maintainers insisting on using PSCI, and vetoing other means,
to restart the system.

Which leaves us with a few boards where we have to use the watchdog, and
wait until the timeout triggers...

> The only way to reboot iWave's boards iwg20d and iwg22d is to use the internal watchdog,
> that's why the restart implementation was merged into this patch.
> I can split this patch in two, one for PM support and one for restart support for the next
> version, what do you think about this?

Splitting in individual logical changes sounds like a good idea to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
