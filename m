Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:47049 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbeHNQQr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Aug 2018 12:16:47 -0400
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a774a1
 support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <1534250028-15770-1-git-send-email-fabrizio.castro@bp.renesas.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ed09553a-c201-10bb-fcc8-2f66674eba92@roeck-us.net>
Date: Tue, 14 Aug 2018 06:29:33 -0700
MIME-Version: 1.0
In-Reply-To: <1534250028-15770-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/14/2018 05:33 AM, Fabrizio Castro wrote:
> RZ/G2M (R8A774A1) watchdog implementation is compatible with R-Car
> Gen3, therefore add relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index 5d47a26..9407212 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -7,6 +7,7 @@ Required properties:
>   	       Examples with soctypes are:
>   		 - "renesas,r8a7743-wdt" (RZ/G1M)
>   		 - "renesas,r8a7745-wdt" (RZ/G1E)
> +		 - "renesas,r8a774a1-wdt" (RZ/G2M)
>   	         - "renesas,r8a7790-wdt" (R-Car H2)
>   	         - "renesas,r8a7791-wdt" (R-Car M2-W)
>   	         - "renesas,r8a7792-wdt" (R-Car V2H)
> @@ -21,8 +22,8 @@ Required properties:
>   	         - "renesas,r7s72100-wdt" (RZ/A1)
>   		The generic compatible string must be:
>   		 - "renesas,rza-wdt" for RZ/A
> -		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
> -		 - "renesas,rcar-gen3-wdt" for R-Car Gen3
> +		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G1
> +		 - "renesas,rcar-gen3-wdt" for R-Car Gen3 and RZ/G2
>   
>   - reg : Should contain WDT registers location and length
>   - clocks : the clock feeding the watchdog timer.
> 
