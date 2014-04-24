Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39942 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbaDXEwQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Apr 2014 00:52:16 -0400
Date: Thu, 24 Apr 2014 00:51:53 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [RESEND/PATCH v4 0/9] Watchdog support for Armada 375/38x SoC
Message-ID: <20140424045153.GU28159@titan.lakedaemon.net>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 14, 2014 at 10:23:24AM -0300, Ezequiel Garcia wrote:
> Here's the fourth round of the patchset adding support for watchdog
> on Armada 375 and Armada 38x SoCs, rebased on v3.15-rc1 and with
> collected Tested-by's.
> 
> The new Armada 375/385 SoCs have two registers for the watchdog RSTOUT:
> 
>  1. It has a dedicated register (similar to the one in A370/XP)
>  2. Also has a bit in a shared RSTOUT register.
> 
> Therefore, in order to support this two-folded RSTOUT, we extend the 'reg'
> property in the watchdog devicetree and require a new pair of cells to specify
> the shared RSTOUT.
> 
> On the driver side, we need to implement per-SoC stop() and enabled()
> functions. Such somewhat complex infrastructure is needed to ensure the driver
> performs proper reset of the watchdog timer, by masking and disabling the
> RSTOUT before the interrupt is enabled.
> 
> Tested on A375-DB, A385-DB, A370-RD and Dove Cubox. Sebastian did more tests
> on Dove, and Jason Gunthorpe on Kirkwood.

Applied patches 7 and 8 to mvebu/dt.  For the rest,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
