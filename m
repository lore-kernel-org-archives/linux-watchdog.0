Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:32985 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdCCKRF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Mar 2017 05:17:05 -0500
MIME-Version: 1.0
In-Reply-To: <SG2PR06MB11656FE3E3CF8BAA1B8A86688A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170302135746.30550-1-chris.brandt@renesas.com>
 <20170302135746.30550-2-chris.brandt@renesas.com> <bf76e106-9272-622c-8d4e-c270a6b51d16@roeck-us.net>
 <SG2PR06MB11656FE3E3CF8BAA1B8A86688A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Mar 2017 11:16:19 +0100
Message-ID: <CAMuHMdXJw=6ygGqYNV334+MQsUBaBH1e2fAmz_6ZDrL+uKT+tA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] watchdog: add rza_wdt driver
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Chris,

On Thu, Mar 2, 2017 at 4:38 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
>> > +   /*
>> > +    * Since the max possible timeout of our 8-bit count register is
>> less
>> > +    * than a second, we must use max_hw_heartbeat_ms.
>> > +    */
>> > +   priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX)/rate;
>>
>> space before and after /
>
> OK.
> #Funny because checkpatch.pl said it didn't like a space on one side but
>  not the other, so I choose no spaces and it was happy. I'm way below 80
>  characters for that line so it doesn't matter to me.

Just drop the parentheses? Standard C operator precedence is fine here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
