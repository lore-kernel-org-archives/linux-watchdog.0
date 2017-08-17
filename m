Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37035 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdHQMvJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 Aug 2017 08:51:09 -0400
MIME-Version: 1.0
In-Reply-To: <20170726215439.9623-2-wsa+renesas@sang-engineering.com>
References: <20170726215439.9623-1-wsa+renesas@sang-engineering.com> <20170726215439.9623-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Aug 2017 14:51:08 +0200
Message-ID: <CAMuHMdVyBYoUifQy+fVE3pdfNdLNBJ6uhhX-VCtXAXN1h+R_LQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] watchdog: renesas_wdt: consistently use RuntimePM
 for clock management
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 26, 2017 at 11:54 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> On Renesas R-Car archs, RuntimePM does all the clock handling. So, use
> it consistently to enable/disable the clocks. Also make sure that clocks
> are really enabled around clk_get_rate(). clk_summary looks proper now:
>
>                 clock   enable_cnt      prepare_cnt     rate ...
> Before this commit:
>
> At boot:        rwdt    1               1               32768 0 0
> WDT running:    rwdt    2               2               32768 0 0
>
> After this commit:
>
> At boot:        rwdt    0               1               32768 0 0
> WDT running     rwdt    1               1               32768 0 0
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
