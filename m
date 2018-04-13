Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36780 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeDMOyT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 13 Apr 2018 10:54:19 -0400
MIME-Version: 1.0
In-Reply-To: <20180413142526.9321-1-wsa+renesas@sang-engineering.com>
References: <20180413142526.9321-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Apr 2018 16:54:17 +0200
Message-ID: <CAMuHMdXUR7=67xkU1Hv=HV++t4n+xpFV6mVbc0Kcz6iWSGh3pA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: renesas-wdt: Add support for the R8A77965 WDT
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Apr 13, 2018 at 4:25 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car M3N (R8A77965) SoC. No driver update is needed.

M3-N

>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [wsa: rebased to top-of-tree]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
