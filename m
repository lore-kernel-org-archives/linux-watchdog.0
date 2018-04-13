Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:46622 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeDMRSu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 13 Apr 2018 13:18:50 -0400
MIME-Version: 1.0
In-Reply-To: <20180413153704.ku3shg4pk5fshcir@ninjato>
References: <20180413142526.9321-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXUR7=67xkU1Hv=HV++t4n+xpFV6mVbc0Kcz6iWSGh3pA@mail.gmail.com> <20180413153704.ku3shg4pk5fshcir@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Apr 2018 19:18:49 +0200
Message-ID: <CAMuHMdWmbxOZ9aDaqfvh1rwWkw7jMni1mVPE5HDMpJQPaT0XCg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: renesas-wdt: Add support for the R8A77965 WDT
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On Fri, Apr 13, 2018 at 5:37 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Apr 13, 2018 at 04:54:17PM +0200, Geert Uytterhoeven wrote:
>> On Fri, Apr 13, 2018 at 4:25 PM, Wolfram Sang
>> <wsa+renesas@sang-engineering.com> wrote:
>> > Document support for the Watchdog Timer (WDT) Controller in the Renesas
>> > R-Car M3N (R8A77965) SoC. No driver update is needed.
>>
>> M3-N
>
> Do we have a de-facto reference for those namings? Sigh, I was kinda
> sure M3N was agreed on.

The User's Manual? (oops, 5 occurrences of "M3N" left)

> So, it must be fixed in the patch as well...

Doh, missed one. These errors are too easy to overlook ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
