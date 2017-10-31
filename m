Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:48198 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753474AbdJaRXB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 31 Oct 2017 13:23:01 -0400
Date: Tue, 31 Oct 2017 10:22:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Add support for the
 r8a77970 wdt
Message-ID: <20171031172259.GH28688@roeck-us.net>
References: <1509378199-19388-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509378199-19388-1-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 30, 2017 at 04:43:19PM +0100, Geert Uytterhoeven wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car V3M (r8a77970) SoC.  Restore sort order while at it.
> 
> No driver update is needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index bf6d1ca58af7d198..74b2f03c151553f5 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -4,10 +4,11 @@ Required properties:
>  - compatible : Should be "renesas,<soctype>-wdt", and
>  	       "renesas,rcar-gen3-wdt" or "renesas,rza-wdt" as fallback.
>  	       Examples with soctypes are:
> +	         - "renesas,r7s72100-wdt" (RZ/A1)
>  	         - "renesas,r8a7795-wdt" (R-Car H3)
>  	         - "renesas,r8a7796-wdt" (R-Car M3-W)
> +	         - "renesas,r8a77970-wdt" (R-Car V3M)
>  	         - "renesas,r8a77995-wdt" (R-Car D3)
> -	         - "renesas,r7s72100-wdt" (RZ/A1)
>  
>    When compatible with the generic version, nodes must list the SoC-specific
>    version corresponding to the platform first, followed by the generic
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
