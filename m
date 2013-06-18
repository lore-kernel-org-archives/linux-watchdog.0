Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31160 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165Ab3FRQbq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 12:31:46 -0400
Date: Tue, 18 Jun 2013 12:31:29 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] Watchdog: allow orion_wdt to be built for Dove
Message-ID: <20130618163129.GY31667@titan.lakedaemon.net>
References: <E1Uoyd2-0001Cp-KL@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Uoyd2-0001Cp-KL@rmk-PC.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 18, 2013 at 05:19:32PM +0100, Russell King wrote:
> The watchdog infrastructure in Dove is no different from that in
> Orion5x or Kirkwood, so let's enable it for Dove.  The only things
> missing are a few register settings in Dove's bridge-regs.h.
> 
> Rather than duplicating the same register bit masks for the RSTOUTn_MASK
> and BRIDGE_CAUSE registers, move the definitions into the watchdog
> driver itself.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-dove/include/mach/bridge-regs.h     |    1 +
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 --
>  arch/arm/mach-orion5x/include/mach/bridge-regs.h  |    3 ---
>  drivers/watchdog/Kconfig                          |    2 +-
>  drivers/watchdog/orion_wdt.c                      |    3 +++
>  5 files changed, 5 insertions(+), 6 deletions(-)

There shouldn't be any conflicts on the mvebu side.  Wim, feel free to
take it:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
