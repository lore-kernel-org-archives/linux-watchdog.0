Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:35975 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbaAUXfj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 18:35:39 -0500
Date: Tue, 21 Jan 2014 16:35:37 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
Message-ID: <20140121233537.GS18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 06:12:32AM -0300, Ezequiel Garcia wrote:
> After adding the IRQ request, the BRIDGE_CAUSE bit should be cleared by the
> bridge interrupt controller. There's no longer a need to do it in the watchdog
> driver, so we can simply remove it.

When we talked about this before I pointed out that sequence here is
important:

- Disable WDT
- Clear bridge
- Enable WDT

Looking at this patch in isolation it looks to me like the clear
bridge lines should be replaced with a request_irq (as that does the
clear) - is the request_irq in the wrong spot?

> @@ -68,9 +66,6 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
>  	/* Set watchdog duration */
>  	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
>  
> -	/* Clear watchdog timer interrupt */
> -	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
> -
>  	/* Enable watchdog timer */
>  	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
>  

Regards,
Jason
