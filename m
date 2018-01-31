Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44343 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbeAaInh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 03:43:37 -0500
MIME-Version: 1.0
In-Reply-To: <1517343778-27902-7-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com> <1517343778-27902-7-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 31 Jan 2018 09:43:35 +0100
Message-ID: <CAMuHMdXX2Ow2dB81FuUFTqdQ84nBzBPPQe_eETpC8mB1zuVYnQ@mail.gmail.com>
Subject: Re: [RFC v3 06/25] ARM: dts: r8a7792: Adjust SMP routine size
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

On Tue, Jan 30, 2018 at 9:22 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This patch adjusts the definition of the SMP routine size according
> to the latest changes made by commit:
> "ARM: shmobile: Add watchdog support"
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
