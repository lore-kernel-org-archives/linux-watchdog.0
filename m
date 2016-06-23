Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50674 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcFWNrQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jun 2016 09:47:16 -0400
Date: Thu, 23 Jun 2016 06:46:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joel Stanley <joel@jms.id.au>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jk@ozlabs.org,
	benh@kernel.crashing.org
Subject: Re: [v2,1/2] doc/devicetree: Add Aspeed watchdog timer bindings
Message-ID: <20160623134651.GA5523@roeck-us.net>
References: <1463062631-16432-2-git-send-email-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463062631-16432-2-git-send-email-joel@jms.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 12, 2016 at 11:47:10PM +0930, Joel Stanley wrote:
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/aspeed-wdt.txt          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> new file mode 100644
> index 000000000000..78ad314eaab9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -0,0 +1,16 @@
> +Aspeed Watchdog Timer
> +
> +Required properties:
> + - compatible: must be one of:
> +	- "aspeed,ast2400-wdt"
> +	- "aspeed,ast2500-wdt"
> +
> + - reg: physical base address of the controller and length of memory mapped
> +   region
> +
> +Example:
> +
> +	watchdog1: watchdog@1e785000 {
> +		compatible = "aspeed,ast2400-wdt";
> +		reg = <0x1e785000 0x1c>;
> +	};
