Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34379 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeIPGQZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Sep 2018 02:16:25 -0400
Date: Sat, 15 Sep 2018 17:55:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [v4,2/2] dt-bindings: watchdog: renesas-wdt: Add support for
 R7S9210
Message-ID: <20180916005523.GA31712@roeck-us.net>
References: <20180910195233.25296-3-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910195233.25296-3-chris.brandt@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 10, 2018 at 02:52:33PM -0500, Chris Brandt wrote:
> Document support for RZ/A2
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index 5d47a262474c..45a709dd0345 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -19,6 +19,7 @@ Required properties:
>  	         - "renesas,r8a77990-wdt" (R-Car E3)
>  	         - "renesas,r8a77995-wdt" (R-Car D3)
>  	         - "renesas,r7s72100-wdt" (RZ/A1)
> +	         - "renesas,r7s9210-wdt"  (RZ/A2)
>  		The generic compatible string must be:
>  		 - "renesas,rza-wdt" for RZ/A
>  		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
