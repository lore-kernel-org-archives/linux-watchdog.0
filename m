Return-Path: <horms@verge.net.au>
Return-path: <horms@verge.net.au>
Date: Wed, 21 Feb 2018 19:32:24 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk <linux-clk@vger.kernel.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: Re: [PATCH v5 00/26] Fix watchdog on Renesas R-Car Gen2 and RZ/G1
Message-ID: <20180221183223.qacrmmuzoqlzzbpo@verge.net.au>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdX=m9ui6GczF51SJH2X7Cw1OnxoH9pfk1DybpDX-A873Q@mail.gmail.com>
 <20180221161326.ktvf3mlzzxith5kw@verge.net.au>
 <CAMuHMdUTSmrWggMK4ehSL3Ux-JUzVpamTuToveuXogjuvGKkaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUTSmrWggMK4ehSL3Ux-JUzVpamTuToveuXogjuvGKkaw@mail.gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Feb 21, 2018 at 05:30:12PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Feb 21, 2018 at 5:13 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Feb 20, 2018 at 01:51:28PM +0100, Geert Uytterhoeven wrote:
> >> On Mon, Feb 12, 2018 at 6:44 PM, Fabrizio Castro
> >> <fabrizio.castro@bp.renesas.com> wrote:
> >> > this series has been around for some time as RFC, and it has collected
> >> > useful comments from the community along the way.
> >> > The solution proposed by this patch set works for most R-Car Gen2 and
> >> > RZ/G1 devices, but not all of them. We now know that for some R-Car
> >> > Gen2 early revisions there is no proper software fix. Anyway, no
> >> > product has been built around early revisions, but development boards
> >> > mounting early revisions (basically prototypes) are still out there.
> >> > As a result, this series isn't enabling the internal watchdog on R-Car
> >> > Gen2 boards, developers may enable it in board specific device trees
> >> > if needed.
> >> > This series has been tested by me on the iwg20d, iwg22d, Lager, Alt,
> >> > and Koelsch boards.
> >> >
> >> > The problem
> >> > ===========
> >> > To deal with SMP on R-Car Gen2 and RZ/G1, we install a reset vector
> >> > to ICRAM1 and we program the [S]BAR registers so that when we turn ON
> >> > the non-boot CPUs they are redirected to the reset vector installed by
> >> > Linux in ICRAM1, and eventually they continue the execution to RAM,
> >> > where the SMP bring-up code will take care of the rest.
> >> > The content of the [S]BAR registers survives a watchdog triggered reset,
> >> > and as such after the watchdog fires the boot core will try and execute
> >> > the SMP bring-up code instead of jumping to the bootrom code.
> >> >
> >> > The fix
> >> > =======
> >> > The main strategy for the solution is to let the reset vector decide
> >> > if it needs to jump to shmobile_boot_fn or to the bootrom code.
> >> > In a watchdog triggered reset scenario, since the [S]BAR registers keep
> >> > their values, the boot CPU will jump into the newly designed reset
> >> > vector, the assembly routine will eventually test WOVF (a bit in register
> >> > RWTCSRA that indicates if the watchdog counter has overflown, the value
> >> > of this bit gets retained in this scenario), and jump to the bootrom code
> >> > which will in turn load up the bootloader, etc.
> >> > When bringing up SMP or using CPU hotplug, the reset vector will jump
> >> > to shmobile_boot_fn instead.
> >> >
> >> > Thank you All for your help.
> >> >
> >> > Best regards,
> >> >
> >> > Fabrizio Castro (26):
> >> >   ARM: shmobile: Add watchdog support
> >> >   ARM: dts: r8a7743: Adjust SMP routine size
> >> >   ARM: dts: r8a7745: Adjust SMP routine size
> >> >   ARM: dts: r8a7790: Adjust SMP routine size
> >> >   ARM: dts: r8a7791: Adjust SMP routine size
> >> >   ARM: dts: r8a7792: Adjust SMP routine size
> >> >   ARM: dts: r8a7793: Adjust SMP routine size
> >> >   ARM: dts: r8a7794: Adjust SMP routine size
> >> >   soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
> >> >   ARM: shmobile: rcar-gen2: Add watchdog support
> >> >   dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
> >> >   watchdog: renesas_wdt: Add R-Car Gen2 support
> >> >   watchdog: renesas_wdt: Add restart handler
> >> >   ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
> >> >   clk: renesas: r8a7743: Add rwdt clock
> >> >   clk: renesas: r8a7745: Add rwdt clock
> >> >   clk: renesas: r8a7790: Add rwdt clock
> >> >   clk: renesas: r8a7791/r8a7793: Add rwdt clock
> >> >   clk: renesas: r8a7794: Add rwdt clock
> >> >   ARM: dts: r8a7743: Add watchdog support to SoC dtsi
> >> >   ARM: dts: r8a7745: Add watchdog support to SoC dtsi
> >> >   ARM: dts: r8a7790: Add watchdog support to SoC dtsi
> >> >   ARM: dts: r8a7791: Add watchdog support to SoC dtsi
> >> >   ARM: dts: r8a7794: Add watchdog support to SoC dtsi
> >> >   ARM: dts: iwg20m: Add watchdog support to SoM dtsi
> >> >   ARM: dts: iwg22m: Add watchdog support to SoM dtsi
> >> >
> >> >  .../devicetree/bindings/watchdog/renesas-wdt.txt   | 19 ++++++--
> >> >  arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |  5 ++
> >> >  arch/arm/boot/dts/r8a7743.dtsi                     | 12 ++++-
> >> >  arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |  5 ++
> >> >  arch/arm/boot/dts/r8a7745.dtsi                     | 12 ++++-
> >> >  arch/arm/boot/dts/r8a7790.dtsi                     | 12 ++++-
> >> >  arch/arm/boot/dts/r8a7791.dtsi                     | 12 ++++-
> >> >  arch/arm/boot/dts/r8a7792.dtsi                     |  2 +-
> >> >  arch/arm/boot/dts/r8a7793.dtsi                     |  2 +-
> >> >  arch/arm/boot/dts/r8a7794.dtsi                     | 12 ++++-
> >> >  arch/arm/configs/shmobile_defconfig                |  1 +
> >> >  arch/arm/mach-shmobile/common.h                    |  6 +++
> >> >  arch/arm/mach-shmobile/headsmp.S                   | 55 ++++++++++++++++++++++
> >> >  arch/arm/mach-shmobile/platsmp-apmu.c              |  1 +
> >> >  arch/arm/mach-shmobile/pm-rcar-gen2.c              | 15 ++++--
> >> >  drivers/clk/renesas/r8a7743-cpg-mssr.c             |  2 +
> >> >  drivers/clk/renesas/r8a7745-cpg-mssr.c             |  2 +
> >> >  drivers/clk/renesas/r8a7790-cpg-mssr.c             |  2 +
> >> >  drivers/clk/renesas/r8a7791-cpg-mssr.c             |  2 +
> >> >  drivers/clk/renesas/r8a7794-cpg-mssr.c             |  2 +
> >> >  drivers/soc/renesas/rcar-rst.c                     | 35 +++++++++++---
> >> >  drivers/watchdog/renesas_wdt.c                     | 39 +++++++++++++--
> >>
> >> Thanks, I've queued the clock patches in clk-renesas-for-v4.17, as they are
> >> a hard dependency for:
> >>   (1) The new reset vector in arch/arm/mach-shmobile/
> >>   (2) The watchdog driver.
> >>
> >> Note that the watchdog driver itself (2) has a hard dependency on the
> >> new reset vector (1).
> >
> > Thanks, I have marked the watchdog driver patch as Deferred.
> > Please resubmit or otherwise ping me once they dependencies
> > are in an rc release.
> 
> I gave the dependencies a bit more thought.
> 
> I think we can gain once release cycle if you would postpone the DTS patches
> (both SMP routine size adjustments and RWDT device node additions) to v4.18.
> Then all other parts can be upstreamed in parallel in v4.17, as nothing
> will be activated before the DTS parts are in.
> 
> Does this look sane?

What about new DTS on old kernels of a specific vintage?
