Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:47115 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbaBZUgs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 26 Feb 2014 15:36:48 -0500
Date: Wed, 26 Feb 2014 13:36:33 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 0/2] Watchdog on Armada 375 SoC
Message-ID: <20140226203633.GA24656@obsidianresearch.com>
References: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 26, 2014 at 09:50:45AM -0300, Ezequiel Garcia wrote:
 
> Here we found both the above RSTOUT:
> 
> 1. It has the same dedicated register as A370/XP (0x20704)
> 2. Also has a bit in the shared RSTOUT register (0x18254)

Unless you know otherwise I think the same risk exists, RSTOUT could
be (or become) internally asserted when you unmask the bit in the
control register that drives the pin, which says the watchdog driver
should control to it.

> A possible solution is to extend the reg property in the watchdog
> devicetree and allow for a new optional pair of cells to complete
> the specification of the RSTOUT.
> 
> 	watchdog-timer@20300 {
> 		compatible = "marvell,orion-wdt";
> 		reg = <0x20300 0x28
> 		       {shared RSOUT} 0x4
> 		       0x0 0x0>;
> 	};

I wouldn't have the 0x0, if you want to go this way, just make the
375 compatible string require a 3 entry reg.

Jason
