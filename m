Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42332 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeBFPo3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Feb 2018 10:44:29 -0500
MIME-Version: 1.0
In-Reply-To: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2018 16:44:28 +0100
Message-ID: <CAMuHMdX0EBhc20G1eaN-LXyMpamyjW1otja3YV10kR1PNEprXg@mail.gmail.com>
Subject: Re: [RFC v4 00/26] Fix watchdog on Renesas R-Car Gen2 and RZ/G1
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
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
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabrizio,

On Wed, Jan 31, 2018 at 7:24 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> the forth version of this series aims at consolidating the watchdog fix.
> There is a discussion still in progress about the changes to the
> watchdog driver, please see the following for more information:
> https://patchwork.kernel.org/patch/10192435/
>
> It doesn't look like leaving the restart handler in for Gen3 is going
> to do any harm (but it may be unwelcome), perhaps esplicitly setting
> its priority to a medium level (128) will help its adoption on Gen3
> as well? This is what this particular version is proposing.
>
> Also, although the latest implmentation of the reset vector hasn't
> raised any problem so far, it hasn't received any feedback either.
> Please do look into it to espose problems and weaknesses (if any).
>
> Finally, it would be great if someone could test this patch set on his
> Gen2/Gen3/RZ/G1 board, and it would be awesome if that board was a
> Lager with all of the cores enabled and working at the same time ;-)

I applied your series, made the following change:

--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -499,6 +499,11 @@
        status = "okay";
 };

+&rwdt {
+       timeout-sec = <5>;
+       status = "okay";
+};
+
 &sata0 {
        status = "okay";
 };

and tried it on koelsch. Unfortunately it hangs:

    # cat > /dev/watchdog
    [wait 5s]
    [hang]

However, it does work when booted with maxcpus=1, or when built with
CONFIG_SMP=n.

It also works when offlining CPU1 first:

    # echo 0 > /sys/devices/system/cpu/cpu1/online
    #cat > /dev/watchdog
    [wait 5s]
    [reboot]

It does not work when offlining CPU0 first.

This is on r8a7791 ES1.0.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
