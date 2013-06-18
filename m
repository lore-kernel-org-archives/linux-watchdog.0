Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:33507 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932458Ab3FRRP2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 13:15:28 -0400
Date: Tue, 18 Jun 2013 19:14:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] Watchdog: fix clearing of the watchdog interrupt
Message-ID: <20130618171452.GB31360@lunn.ch>
References: <E1Uoye0-0001Cw-Po@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Uoye0-0001Cw-Po@rmk-PC.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 18, 2013 at 05:20:32PM +0100, Russell King wrote:
> The bits in BRIDGE_CAUSE are documented as RW0C - read, write 0 to
> clear.  If we read the register, mask off the watchdog bit, and
> write it back, we're actually clearing every interrupt which wasn't
> pending at the time we read the register - and that is racy.
> 
> Fix this to only write ~WATCHDOG_BIT to the register, which means
> we write as zero only the watchdog bit.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/watchdog/orion_wdt.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 4074244..4ea5fcc 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -70,9 +70,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
>  	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
>  
>  	/* Clear watchdog timer interrupt */
> -	reg = readl(BRIDGE_CAUSE);
> -	reg &= ~WDT_INT_REQ;
> -	writel(reg, BRIDGE_CAUSE);
> +	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
>  
>  	/* Enable watchdog timer */
>  	reg = readl(wdt_reg + TIMER_CTRL);
> -- 
> 1.7.4.4


Hi Russell

For this, and patch 1/2:

Tested-by: Andrew Lunn <andrew@lunn.ch>

On a kirkwood.

   Andrew
