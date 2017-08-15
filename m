Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33655 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbdHOCSE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 22:18:04 -0400
Date: Mon, 14 Aug 2017 19:18:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Cc: wim@iguana.be, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [v5, 1/2] drivers/watchdog: Add optional ASPEED device tree
 properties
Message-ID: <20170815021801.GA1819@roeck-us.net>
References: <20170717192539.7950-2-cbostic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717192539.7950-2-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 17, 2017 at 02:25:38PM -0500, Christopher Bostic wrote:
> Describe device tree optional properties:
> 
>   * aspeed,reset-type = "cpu|soc|system|none"
>      One of three different, mutually exclusive, values
> 
> 	"cpu" : ARM CPU reset on signal
> 	"soc" : 'System on chip' reset
> 	"system" : Full system reset
> 
>      The value can also be set to "none" which indicates that no
>      reset of any kind is to be done via this watchdog.  This assumes
>      another watchdog on the chip is to take care of resets.
> 
>   * aspeed,external-signal - Generate external signal (WDT1 and WDT2 only)
>   * aspeed,alt-boot - Boot from alternate block on signal
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v5 - Removed aspeed,interrupt property - no plans at this point to
>      need this functionality in the driver.
> v4 - Add aspeed-reset-type and assign one of four values,
>      cpu, soc, system, none.
> v3 - Invert soc and sys reset to 'no' to preserve backwards
>      compatibility.  SOC and SYS reset will be set by default
>      without any optional parameters set
> v2 - Add 'aspeed,' prefix to all optional properties
>    - Add arm-reset, soc-reset, interrupt, alt-boot properties
> ---
>  .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index c5e74d7..2b34ce9 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -8,9 +8,41 @@ Required properties:
>   - reg: physical base address of the controller and length of memory mapped
>     region
>  
> +Optional properties:
> +
> + - aspeed,reset-type = "cpu|soc|system|none"
> +
> +   Reset behavior - Whenever a timeout occurs the watchdog can be programmed
> +   to generate one of three different, mutually exclusive, types of resets.
> +
> +   Type "none" can be specified to indicate that no resets are to be done.
> +   This is useful in situations where another watchdog engine on chip is
> +   to perform the reset.
> +
> +   If 'aspeed,reset-type=' is not specfied the default is to enable system
> +   reset.
> +
> +   Reset types:
> +
> +        - cpu: Reset CPU on watchdog timeout
> +
> +        - soc: Reset 'System on Chip' on watchdog timeout
> +
> +        - system: Reset system on watchdog timeout
> +
> +        - none: No reset is performed on timeout. Assumes another watchdog
> +                engine is responsible for this.
> +
> + - aspeed,external-signal: If property is present then signal is sent to
> +			external reset counter (only WDT1 and WDT2). If not
> +			specified no external signal is sent.
> + - aspeed,alt-boot:    If property is present then boot from alternate block.
> +
>  Example:
>  
>  	wdt1: watchdog@1e785000 {
>  		compatible = "aspeed,ast2400-wdt";
>  		reg = <0x1e785000 0x1c>;
> +		aspeed,reset-type = "system";
> +		aspeed,external-signal;
>  	};
