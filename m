Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35651 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdHQMvs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 Aug 2017 08:51:48 -0400
MIME-Version: 1.0
In-Reply-To: <20170726215439.9623-3-wsa+renesas@sang-engineering.com>
References: <20170726215439.9623-1-wsa+renesas@sang-engineering.com> <20170726215439.9623-3-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Aug 2017 14:51:48 +0200
Message-ID: <CAMuHMdWZ4YG5nNNbKecshciWjfLFWwAy4gdhbOfbT2qPVM-OtA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] watchdog: renesas_wdt: make 'clk' a variable
 local to probe()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 26, 2017 at 11:54 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> It is not needed outside probe() anymore.
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
