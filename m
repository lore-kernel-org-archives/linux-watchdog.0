Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45935 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDMnH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Dec 2018 07:43:07 -0500
MIME-Version: 1.0
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Dec 2018 13:42:54 +0100
Message-ID: <CAMuHMdUSbTFUDQDW208=gzhBP_UsQVxaGewsuHngb_Or0e+ghg@mail.gmail.com>
Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during suspend/resume
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 4, 2018 at 1:02 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> After discussing this mail thread [1] again, we concluded that giving
> userspace enough time to prepare is our favourite option. So, do not
> keep the time value when suspended but reset it when resuming.
>
> [1] https://patchwork.kernel.org/patch/10252209/
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
