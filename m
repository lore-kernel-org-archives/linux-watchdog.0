Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49985 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaAUJyj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:54:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 03/15] watchdog: orion: Use atomic access for shared registers
Date: Tue, 21 Jan 2014 10:54:37 +0100
Message-ID: <3381968.dYvuFs4ZXV@wuerfel>
In-Reply-To: <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 21 January 2014 06:12:29 Ezequiel Garcia wrote:
>         writel(~WDT_INT_REQ, BRIDGE_CAUSE);
>  
>         /* Enable watchdog timer */
> -       reg = readl(wdt_reg + TIMER_CTRL);
> -       reg |= WDT_EN;
> -       writel(reg, wdt_reg + TIMER_CTRL);
> +       atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);

As mentioned in my comment for patch 2, it seems that the exported
orion_timer_ctrl_clrset() function would be more appropriate for this.

>         /* Enable reset on watchdog */
> -       reg = readl(RSTOUTn_MASK);
> -       reg |= WDT_RESET_OUT_EN;
> -       writel(reg, RSTOUTn_MASK);
> +       atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);

And this register already has an abstraction in
arch/arm/mach-mvebu/system-controller.c. I would prefer to find a way
to generalize that. I can see multiple ways to do that:

* Turn the "marvell,armada-370-xp-system-controller" device into a "syscon"
  device that can be used through regmap from other parts of the kernel.

* Move arch/arm/mach-mvebu/system-controller.c into drivers/soc (we don't
  have this directory yet, but have discussed it in the past) to export
  soc-specific functions from there.

* Move all of the system-controller implementation into the wdt driver
  and require that this driver be enabled in order to do regular system
  reset. The system-controller can register itself as a reboot hook,
  so you can remove the ".restart = mvebu_restart" part from mach-mvebu.

	Arnd
