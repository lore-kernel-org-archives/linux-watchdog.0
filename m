Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36955 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbdHNOzG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 10:55:06 -0400
Date: Mon, 14 Aug 2017 07:55:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/11] watchdog: gemini/ftwdt010: rename DT bindings
Message-ID: <20170814145503.GF14491@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170812184318.10144-2-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 12, 2017 at 08:43:08PM +0200, Linus Walleij wrote:
> The device tree bindings are in two copies and also should be
> consolidated into a single Faraday Technology FTWDT010
> binding since we uncovered that this IP part is a standard
> IP from Faraday.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Will need Ack from Rob.


> ---
>  .../bindings/watchdog/cortina,gemini-watchdog.txt       | 17 -----------------
>  ...{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} | 11 ++++++++---
>  2 files changed, 8 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
>  rename Documentation/devicetree/bindings/watchdog/{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} (55%)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt b/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
> deleted file mode 100644
> index bc4b865d178b..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Cortina Systems Gemini SoC Watchdog
> -
> -Required properties:
> -- compatible : must be "cortina,gemini-watchdog"
> -- reg : shall contain base register location and length
> -- interrupts : shall contain the interrupt for the watchdog
> -
> -Optional properties:
> -- timeout-sec : the default watchdog timeout in seconds.
> -
> -Example:
> -
> -watchdog@41000000 {
> -	compatible = "cortina,gemini-watchdog";
> -	reg = <0x41000000 0x1000>;
> -	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> -};
> diff --git a/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
> similarity index 55%
> rename from Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
> rename to Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
> index bc4b865d178b..9ecdb502e605 100644
> --- a/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
> +++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
> @@ -1,7 +1,12 @@
> -Cortina Systems Gemini SoC Watchdog
> +Faraday Technology FTWDT010 watchdog
> +
> +This is an IP part from Faraday Technology found in the Gemini
> +SoCs and others.
>  
>  Required properties:
> -- compatible : must be "cortina,gemini-watchdog"
> +- compatible : must be one of
> +  "faraday,ftwdt010"
> +  "cortina,gemini-watchdog", "faraday,ftwdt010"
>  - reg : shall contain base register location and length
>  - interrupts : shall contain the interrupt for the watchdog
>  
> @@ -11,7 +16,7 @@ Optional properties:
>  Example:
>  
>  watchdog@41000000 {
> -	compatible = "cortina,gemini-watchdog";
> +	compatible = "faraday,ftwdt010";
>  	reg = <0x41000000 0x1000>;
>  	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
>  };
> -- 
> 2.13.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
