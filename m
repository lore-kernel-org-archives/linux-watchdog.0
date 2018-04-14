Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35077 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeDNOOA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 14 Apr 2018 10:14:00 -0400
Subject: Re: [PATCH v2] watchdog: renesas-wdt: Add support for the R8A77965
 WDT
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20180414101858.3208-1-wsa+renesas@sang-engineering.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f5140981-50df-e499-f7e5-f6aa2f3d0fc3@roeck-us.net>
Date: Sat, 14 Apr 2018 07:13:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180414101858.3208-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/14/2018 03:18 AM, Wolfram Sang wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car M3-N (R8A77965) SoC. No driver update is needed.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [wsa: rebased to top-of-tree]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Change since v1: s/M3N/M3-N/ (Thanks, Geert!)
> 
>   Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index 123bb1b2654b..613d860f2353 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -15,6 +15,7 @@ Required properties:
>   		 - "renesas,r8a7794-wdt" (R-Car E2)
>   		 - "renesas,r8a7795-wdt" (R-Car H3)
>   		 - "renesas,r8a7796-wdt" (R-Car M3-W)
> +		 - "renesas,r8a77965-wdt" (R-Car M3-N)
>   		 - "renesas,r8a77970-wdt" (R-Car V3M)
>   		 - "renesas,r8a77995-wdt" (R-Car D3)
>   	       The generic compatible string must be:
> 

