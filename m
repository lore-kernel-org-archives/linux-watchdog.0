Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32841 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161509AbeCAUW0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 15:22:26 -0500
MIME-Version: 1.0
In-Reply-To: <1519928243-28596-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com> <1519928243-28596-3-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Mar 2018 21:22:25 +0100
Message-ID: <CAMuHMdWmgLaOuj+_qBwf6=1RzQTCxs0To8Fu2sixRDAcuAT4qw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] watchdog: renesas_wdt: Add R-Car Gen2 support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabrizio,

On Thu, Mar 1, 2018 at 7:17 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Due to commits:
> * "ARM: shmobile: Add watchdog support",
> * "ARM: shmobile: rcar-gen2: Add watchdog support", and
> * "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
> we now have everything we needed for the watchdog to work on Gen2 and
> RZ/G1.
>
> This commit adds "renesas,rcar-gen2-wdt" as compatible string for R-Car
> Gen2 and RZ/G1.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

To avoid nasty surprises on early R-Car Gen2 SoCs, "[PATCH] watchdog:
renesas_wdt: Blacklist early R-Car Gen2 SoCs"
(https://patchwork.kernel.org/patch/10233297/) should be folded into this
patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
