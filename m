Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34971 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbdBQK31 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Feb 2017 05:29:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170216172320.10897-4-chris.brandt@renesas.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com> <20170216172320.10897-4-chris.brandt@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Feb 2017 11:29:25 +0100
Message-ID: <CAMuHMdVMBo9fNMTqz_XdU27FF5TX98r-OE5pJ5atJ1s4XLxcTw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: r7s72100: Add reset handler
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Feb 16, 2017 at 6:23 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> For the RZ/A1, the only way to do a reset is to overflow the WDT.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
