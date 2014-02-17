Return-Path: <jason@lakedaemon.net>
Date: Mon, 17 Feb 2014 17:09:48 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 00/18] Armada 370/XP watchdog
Message-ID: <20140217220948.GF7862@titan.lakedaemon.net>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Whole series applied as follows (with Wim's Acks):

> Ezequiel Garcia (18):
>   watchdog: orion: Add clock error handling
>   watchdog: orion: Use atomic access for shared registers
>   watchdog: orion: Remove unused macros
>   watchdog: orion: Make sure the watchdog is initially stopped
>   watchdog: orion: Handle the interrupt so it's properly acked
>   watchdog: orion: Make RSTOUT register a separate resource
>   watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
>   watchdog: orion: Introduce an orion_watchdog device structure
>   watchdog: orion: Introduce per-compatible of_device_id data
>   watchdog: orion: Add per-compatible clock initialization
>   watchdog: orion: Add per-compatible watchdog start implementation
>   watchdog: orion: Add support for Armada 370 and Armada XP SoC

to mvebu/watchdog (deps on mvebu/irqchip-fixes (renamed))

>   ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
>   ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
>   ARM: dove: Enable Dove watchdog in the devicetree

to mvebu/dt

>   watchdog: orion: Enable the build on ARCH_MVEBU

to mvebu/watchdog

>   ARM: mvebu: Enable watchdog support in defconfig
>   ARM: dove: Enable watchdog support in the defconfig

to mvebu/defconfig

>  .../devicetree/bindings/watchdog/marvel.txt        |  11 +-
>  arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
>  arch/arm/boot/dts/armada-370.dtsi                  |   5 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |   6 +
>  arch/arm/boot/dts/dove.dtsi                        |   8 +
>  arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
>  arch/arm/configs/dove_defconfig                    |   2 +
>  arch/arm/configs/multi_v7_defconfig                |   2 +
>  arch/arm/configs/mvebu_defconfig                   |   2 +
>  arch/arm/mach-dove/include/mach/bridge-regs.h      |   1 +
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   1 +
>  arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   1 +
>  arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   1 +
>  arch/arm/plat-orion/common.c                       |  10 +-
>  drivers/watchdog/Kconfig                           |   2 +-
>  drivers/watchdog/orion_wdt.c                       | 381 ++++++++++++++++-----
>  16 files changed, 352 insertions(+), 87 deletions(-)

Great work, Ezequiel!

thx,

Jason.
