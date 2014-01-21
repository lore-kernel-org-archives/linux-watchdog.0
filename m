Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:50044 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbaAUJ6W (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:58:22 -0500
Message-ID: <52DE44B9.70308@gmail.com>
Date: Tue, 21 Jan 2014 10:58:17 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 02/15] clocksource: orion: Use atomic access for shared
 registers
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com> <5118193.GjKusj569J@wuerfel>
In-Reply-To: <5118193.GjKusj569J@wuerfel>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/21/14 10:46, Arnd Bergmann wrote:
> On Tuesday 21 January 2014 06:12:28 Ezequiel Garcia wrote:
>> -/*
>> - * Thread-safe access to TIMER_CTRL register
>> - * (shared with watchdog timer)
>> - */
>> -void orion_timer_ctrl_clrset(u32 clr, u32 set)
>> -{
>> -       spin_lock(&timer_ctrl_lock);
>> -       writel((readl(timer_base + TIMER_CTRL) & ~clr) | set,
>> -               timer_base + TIMER_CTRL);
>> -       spin_unlock(&timer_ctrl_lock);
>> -}
>> -EXPORT_SYMBOL(orion_timer_ctrl_clrset);
>
> I don't understand what's wrong with this function, it seems like
> a cleaner approach than touching the register directly from two
> different drivers. Is this something that would only work on
> orion but not on armadaxp?

The real problem with this is that it resides in orion-time.c which
is fine for Orion SoCs. Armada 370/XP use a different timer and
therefore the _common_ watchdog driver cannot call this function.

Moreover, Dove (out of Orion) and Armada 370/XP will happily live in
one V7 kernel with both time-orion and time-armada-370-xp compiled in.

The idea of the atomic readl/writel was to have something lightweight
and _early_ to allow such locking even for timers.

IIRC, there was some kind of consensus that it is okay to have atomic
readl/writel here.

Sebastian
