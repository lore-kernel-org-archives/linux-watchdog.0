Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35844 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeCUIYu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Mar 2018 04:24:50 -0400
MIME-Version: 1.0
In-Reply-To: <20180320213626.14208-1-wsa+renesas@sang-engineering.com>
References: <20180320213626.14208-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Mar 2018 09:24:49 +0100
Message-ID: <CAMuHMdXN-6xQu6Xr8rpvOzwBNmFx9WE_FqTj6Tj+2FUz0sSqsw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: renesas-wdt: Add support for WDIOF_CARDRESET
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 20, 2018 at 10:36 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
>
> This patch adds the WDIOF_CARDRESET support for the Renessas platform
> watchdog, to know if the board reboot is due to a watchdog reset.
>
> This is done via the WOVF bit (bit 4) of the RWTCSRA register, which
> indicates if RWTCNT overflowed, triggering the reset in last boot.
>
> Signed-off-by: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
> [takeshi.kihara.df: changed to read the RWTCSRA register while clock is
>  enabled]
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
