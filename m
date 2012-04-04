Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:43257 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab2DDIqH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Apr 2012 04:46:07 -0400
Date: Wed, 04 Apr 2012 04:39:52 -0400 (EDT)
Message-Id: <20120404.043952.1333187975072018080.davem@davemloft.net>
To: stigge@antcom.de
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	w.sang@pengutronix.de, srinivas.bakki@nxp.com, kevin.wells@nxp.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, wim@iguana.be, jonsmirl@gmail.com
Subject: Re: [PATCH v3 3/8] net: Add device tree support to LPC32xx
From: David Miller <davem@davemloft.net>
In-Reply-To: <1333528480-17134-4-git-send-email-stigge@antcom.de>
References: <1333528480-17134-1-git-send-email-stigge@antcom.de>
	<1333528480-17134-4-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Roland Stigge <stigge@antcom.de>
Date: Wed,  4 Apr 2012 10:34:35 +0200

> This patch adds device tree support for lpc_eth.c.
> 
> The runtime option for MII/RMII is solved via the "phy-mode" property, SRAM
> ("IRAM") usage for DMA can be chosen via "use-iram".
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Feel free to merge this in via one of the ARM trees.

Acked-by: David S. Miller <davem@davemloft.net>
