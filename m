Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43659 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeEHEdP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 8 May 2018 00:33:15 -0400
Subject: Re: [PATCH v3] watchdog: renesas-wdt: Add support for the R8A77965
 WDT
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20180507122942.7669-1-wsa+renesas@sang-engineering.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <743a3d42-a89d-2f99-91bd-7e3aaacb7e00@roeck-us.net>
Date: Mon, 7 May 2018 21:33:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180507122942.7669-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/07/2018 05:29 AM, Wolfram Sang wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car M3-N (R8A77965) SoC. No driver update is needed.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [wsa: rebased to v4.17-rc3]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

This one applies.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks!
Guenter

> ---
> 
> Change since V2: rebase to 4.17-rc3
> 
>   Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index 74b2f03c1515..fa56697a1ba6 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -7,6 +7,7 @@ Required properties:
>   	         - "renesas,r7s72100-wdt" (RZ/A1)
>   	         - "renesas,r8a7795-wdt" (R-Car H3)
>   	         - "renesas,r8a7796-wdt" (R-Car M3-W)
> +		 - "renesas,r8a77965-wdt" (R-Car M3-N)
>   	         - "renesas,r8a77970-wdt" (R-Car V3M)
>   	         - "renesas,r8a77995-wdt" (R-Car D3)
>   
> 

