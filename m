Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34322 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754667AbdFXWH0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 24 Jun 2017 18:07:26 -0400
Date: Sat, 24 Jun 2017 15:07:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Cc: wim@iguana.be, joel@jms.id.au, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, andrew@aj.id.au
Subject: Re: [1/2] drivers/watchdog: Document new aspeed optional dev tree
 properties.
Message-ID: <20170624220722.GA3621@roeck-us.net>
References: <20170613203818.17399-2-cbostic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613203818.17399-2-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 13, 2017 at 03:38:17PM -0500, Christopher Bostic wrote:
> Describe new optional property 'external-signal'.  When present in the
> system device tree an exernal signal is generated on watchdog timeout.
> 
> Describe new optional property 'no-system-reset'.  When present in the
> system device tree no system reset is to occur on watchdog timeout.
> System reset in this case is managed by one of the other watchogs
> available.
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>

This requires DT maintainer approval, but DT maintainers were not copied.
Please resend and use scripts/get_maintainer.pl to determine who to send
it to.

Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index c5e74d7..4099ea5 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -8,9 +8,20 @@ Required properties:
>   - reg: physical base address of the controller and length of memory mapped
>     region
>  
> +Optional properties:
> + - external-signal: If the property is present then an external signal is to
> +   be generated on watchdog timeout.  If absent, external signal is not
> +   generated.
> +
> + - no-system-reset: If the property is present then system will not be reset
> +   on watchdog timeout. In this case one of the other watchdogs will handle
> +   reset.  If absent then the watchdog resets the system on timeout.
> +
>  Example:
>  
>  	wdt1: watchdog@1e785000 {
>  		compatible = "aspeed,ast2400-wdt";
>  		reg = <0x1e785000 0x1c>;
> +		external-signal;
> +		no-system-reset;
>  	};
