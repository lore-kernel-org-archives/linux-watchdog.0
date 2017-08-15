Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47853 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdHOCU7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 22:20:59 -0400
Date: Mon, 14 Aug 2017 19:20:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
Subject: Re: [1/2] dt-bindings: watchdog: aspeed: External reset signal
 properties
Message-ID: <20170815022057.GA2172@roeck-us.net>
References: <20170802044529.30032-2-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802044529.30032-2-andrew@aj.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 02, 2017 at 02:15:28PM +0930, Andrew Jeffery wrote:
> For the AST2500 and compatible watchdog controllers the external reset
> signal can be configured for push-pull or open-drain drive types, and in
> the case of push-pull driving, active low or high.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index 2b34ce9b60b9..c5077a1f5cb3 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -33,10 +33,18 @@ Optional properties:
>          - none: No reset is performed on timeout. Assumes another watchdog
>                  engine is responsible for this.
>  
> + - aspeed,alt-boot:    If property is present then boot from alternate block.
>   - aspeed,external-signal: If property is present then signal is sent to
>  			external reset counter (only WDT1 and WDT2). If not
>  			specified no external signal is sent.
> - - aspeed,alt-boot:    If property is present then boot from alternate block.
> + - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
> +
> +Optional properties for AST2500-compatible watchdogs:
> + - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
> +			 drive type to push-pull. The default is open-drain.
> + - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
> +			   is configured as push-pull, then set the pulse
> +			   polarity to active-high. The default is active-low.
>  
>  Example:
>  
