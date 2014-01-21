Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53721 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbaAUJrb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:47:31 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 02/15] clocksource: orion: Use atomic access for shared registers
Date: Tue, 21 Jan 2014 10:46:38 +0100
Message-ID: <5118193.GjKusj569J@wuerfel>
In-Reply-To: <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 21 January 2014 06:12:28 Ezequiel Garcia wrote:
> -/*
> - * Thread-safe access to TIMER_CTRL register
> - * (shared with watchdog timer)
> - */
> -void orion_timer_ctrl_clrset(u32 clr, u32 set)
> -{
> -       spin_lock(&timer_ctrl_lock);
> -       writel((readl(timer_base + TIMER_CTRL) & ~clr) | set,
> -               timer_base + TIMER_CTRL);
> -       spin_unlock(&timer_ctrl_lock);
> -}
> -EXPORT_SYMBOL(orion_timer_ctrl_clrset);

I don't understand what's wrong with this function, it seems like
a cleaner approach than touching the register directly from two
different drivers. Is this something that would only work on
orion but not on armadaxp?


	Arnd
