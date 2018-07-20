Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34791 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeGTMEE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 20 Jul 2018 08:04:04 -0400
MIME-Version: 1.0
References: <20180720111125.11551-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180720111125.11551-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Jul 2018 13:16:06 +0200
Message-ID: <CAMuHMdUbvUWLrKBT9C8t_13Ugy+2bP96h6wTSCXfENL4j3deBw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: renesas-wdt: Add support for the R8A77990 wdt
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 20, 2018 at 1:11 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car E3 (R8A77990) SoC. No driver update is needed.
>
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Dupe of "[v2] dt-bindings: watchdog: renesas-wdt: Add support for the
R8A77990 wdt"
(https://patchwork.kernel.org/patch/10511091/), and queued in
linux-staging.git#watchdog-next, which is not in next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
