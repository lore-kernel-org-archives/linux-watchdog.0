Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47474 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751348AbaAZO6I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 Jan 2014 09:58:08 -0500
Date: Sun, 26 Jan 2014 15:57:51 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 07/18] watchdog: orion: Handle IRQ
Message-ID: <20140126155751.6c6ea59d@skate>
In-Reply-To: <20140126131445.GA14713@localhost>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1390431915-5115-8-git-send-email-ezequiel.garcia@free-electrons.com>
	<20140126090412.37f4932f@skate>
	<20140126131445.GA14713@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Ezequiel Garcia,

On Sun, 26 Jan 2014 10:14:46 -0300, Ezequiel Garcia wrote:

> > I don't quiite understand the first sentence of this commit log, and
> > the commit title looks wrong. Maybe a bad copy/paste or something?
> > 
> 
> Hm... yes it doesn't look right. It should read:
> 
> "DT-enabled platforms, where the irqchip driver for the brigde interrupt
> controller is available, can handle the watchdog IRQ properly. Therefore,
> we request the interrupt and add a dummy handler that merely calls panic()".

Ok.

> I guess we can re-phrase it be a bit more readable.
> 
> Why does th commit title looks wrong? By requesting the IRQ we are
> "handling it", no?

Right, but it looks "truncated". Maybe something like:

watchdog: orion: handle irq to avoid having to clear BRIDGE_CLAUSE

or something like that (adjust to the actual reality, I haven't
followed all the implications).

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
