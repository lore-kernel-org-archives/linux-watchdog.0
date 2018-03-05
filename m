Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45959 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCERMj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 5 Mar 2018 12:12:39 -0500
MIME-Version: 1.0
In-Reply-To: <1520263826-1937-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520263826-1937-1-git-send-email-fabrizio.castro@bp.renesas.com> <1520263826-1937-2-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Mar 2018 18:12:37 +0100
Message-ID: <CAMuHMdVP8QY_nZqHaTUrCE-ghx1F0P03gX13knzZ+Y09bFJC4Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] watchdog: renesas_wdt: Add suspend/resume support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 5, 2018 at 4:30 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> On R-Car Gen2 and RZ/G1 the watchdog IP clock needs to be always ON,
> on R-Car Gen3 we power the IP down during suspend.
>
> This commit adds suspend/resume support, so that the watchdog counting
> "pauses" during suspend on all of the SoCs compatible with this driver
> and on those we are now adding support for (R-Car Gen2 and RZ/G1).
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
