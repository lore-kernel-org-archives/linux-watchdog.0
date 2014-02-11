Return-Path: <ezequiel.garcia@free-electrons.com>
Date: Tue, 11 Feb 2014 05:31:23 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v7 00/18] Armada 370/XP watchdog
Message-ID: <20140211083122.GB3687@localhost>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Feb 10, 2014 at 08:00:19PM -0300, Ezequiel Garcia wrote:
> Yet another round. This time, addressing Guenter's comment about the nowayout
> parameter. So, to allow for proper nowayout behavior, we now restrict the
> initial watchdog stop; which is only done if the watchdog is not properly
> enabled.
> 
> I've dropped the clocksource patch which was previously part of the series.
> The patch is independent and will be merged through the subsystem maintainer,
> Daniel Lezcano.
> 
> Also, I've updated the multi_v7_defconfig, as per Jason Cooper request.
> 
> This series depends on Sebastian's irqchip fixes to clear the bridge irqs
> cause, which Jason picked here:
> 
>   http://git.infradead.org/linux-mvebu.git mvebu-next/irqchip-fixes
> 
> Wim: Can we take all the watchdog changes through mvebu, with your Ack?
> This way, we can sort out the irqchip dependency.
> 

Wim: Do you have any comments about these patches?

-- 
Ezequiel García, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
