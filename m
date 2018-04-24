Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37310 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932871AbeDXIqh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 24 Apr 2018 04:46:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180424083819.oyqb2vrh7h7vktjr@verge.net.au>
References: <20180414101858.3208-1-wsa+renesas@sang-engineering.com> <20180424083819.oyqb2vrh7h7vktjr@verge.net.au>
From: Vaishali Thakkar <vthakkar@vaishalithakkar.in>
Date: Tue, 24 Apr 2018 14:16:34 +0530
Message-ID: <CAK-LDbLSSVSEzjMA5VHdrEXOxgVZV5dZ73XZj+g4CtOkDUM=TA@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: renesas-wdt: Add support for the R8A77965 WDT
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 24, 2018 at 2:08 PM, Simon Horman <horms@verge.net.au> wrote:
> On Sat, Apr 14, 2018 at 12:18:58PM +0200, Wolfram Sang wrote:
>> Document support for the Watchdog Timer (WDT) Controller in the Renesas
>> R-Car M3-N (R8A77965) SoC. No driver update is needed.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> [wsa: rebased to top-of-tree]
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Vaishali Thakkar <vthakkar@vaishalithakkar.in>

>> ---
>>
>> Change since v1: s/M3N/M3-N/ (Thanks, Geert!)
>>
>>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
>> index 123bb1b2654b..613d860f2353 100644
>> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
>> @@ -15,6 +15,7 @@ Required properties:
>>                - "renesas,r8a7794-wdt" (R-Car E2)
>>                - "renesas,r8a7795-wdt" (R-Car H3)
>>                - "renesas,r8a7796-wdt" (R-Car M3-W)
>> +              - "renesas,r8a77965-wdt" (R-Car M3-N)
>>                - "renesas,r8a77970-wdt" (R-Car V3M)
>>                - "renesas,r8a77995-wdt" (R-Car D3)
>>              The generic compatible string must be:
>> --
>> 2.11.0
>>
