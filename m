Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33693 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933158Ab3FRQci (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 12:32:38 -0400
Date: Tue, 18 Jun 2013 12:32:26 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] Watchdog: fix clearing of the watchdog interrupt
Message-ID: <20130618163226.GZ31667@titan.lakedaemon.net>
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

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
