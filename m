Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49019 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbdCEQEh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 5 Mar 2017 11:04:37 -0500
Subject: Re: [PATCH v6 2/3] watchdog: renesas-wdt: add support for rza
To: Chris Brandt <chris.brandt@renesas.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170304223737.20419-1-chris.brandt@renesas.com>
 <20170304223737.20419-3-chris.brandt@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <03a34493-f3e4-a48b-3305-09f6f386eb11@roeck-us.net>
Date: Sun, 5 Mar 2017 08:04:33 -0800
MIME-Version: 1.0
In-Reply-To: <20170304223737.20419-3-chris.brandt@renesas.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/04/2017 02:37 PM, Chris Brandt wrote:
> Describe the WDT hardware in the RZ/A series.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v3:
> * Add Acked-by, Reviewed-by.
> v2:
> * added to renesas-wdt.txt instead of creating a new file
> * changed commit title
> * added "renesas,rza-wdt" as a fallback
> * added interrupts property
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index da24e31..9e306af 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -2,10 +2,11 @@ Renesas Watchdog Timer (WDT) Controller
>
>  Required properties:
>  - compatible : Should be "renesas,<soctype>-wdt", and
> -	       "renesas,rcar-gen3-wdt" as fallback.
> +	       "renesas,rcar-gen3-wdt" or "renesas,rza-wdt" as fallback.
>  	       Examples with soctypes are:
>  	         - "renesas,r8a7795-wdt" (R-Car H3)
>  	         - "renesas,r8a7796-wdt" (R-Car M3-W)
> +	         - "renesas,r7s72100-wdt" (RZ/A1)
>
>    When compatible with the generic version, nodes must list the SoC-specific
>    version corresponding to the platform first, followed by the generic
> @@ -17,6 +18,7 @@ Required properties:
>  Optional properties:
>  - timeout-sec : Contains the watchdog timeout in seconds
>  - power-domains : the power domain the WDT belongs to
> +- interrupts: Some WDTs have an interrupt when used in interval timer mode
>
>  Examples:
>
>

