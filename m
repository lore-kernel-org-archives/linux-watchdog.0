Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35268 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753642AbeCNIRd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Mar 2018 04:17:33 -0400
MIME-Version: 1.0
In-Reply-To: <20180313200548.fgexoxlha3coa7hs@verge.net.au>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdX=m9ui6GczF51SJH2X7Cw1OnxoH9pfk1DybpDX-A873Q@mail.gmail.com>
 <20180221161326.ktvf3mlzzxith5kw@verge.net.au> <CAMuHMdUTSmrWggMK4ehSL3Ux-JUzVpamTuToveuXogjuvGKkaw@mail.gmail.com>
 <20180221183223.qacrmmuzoqlzzbpo@verge.net.au> <CAMuHMdXCt1-coXGgtgFBm4rZLGBRMvSjbgeBSweiyKrOfCF0Xg@mail.gmail.com>
 <20180223081443.ak6kl3z72kamcxob@verge.net.au> <CAMuHMdVKPFSVTbnQy9RwAg13OC3R=H1PN9+1FyU0SDHQPa1cuQ@mail.gmail.com>
 <20180313200548.fgexoxlha3coa7hs@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Mar 2018 09:17:31 +0100
Message-ID: <CAMuHMdUntJeeM1=+SKwjQGogeuV0PywiE4WwqysFPVdSqeymEg@mail.gmail.com>
Subject: Re: [PATCH v5 00/26] Fix watchdog on Renesas R-Car Gen2 and RZ/G1
To: Simon Horman <horms@verge.net.au>
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Simon,

On Tue, Mar 13, 2018 at 9:05 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Mar 01, 2018 at 11:20:11AM +0100, Geert Uytterhoeven wrote:
>> On Fri, Feb 23, 2018 at 9:14 AM, Simon Horman <horms@verge.net.au> wrote=
:
>> > On Thu, Feb 22, 2018 at 09:38:39AM +0100, Geert Uytterhoeven wrote:
>> >> On Wed, Feb 21, 2018 at 7:32 PM, Simon Horman <horms@verge.net.au> wr=
ote:
>> >> > On Wed, Feb 21, 2018 at 05:30:12PM +0100, Geert Uytterhoeven wrote:
>> >> >> On Wed, Feb 21, 2018 at 5:13 PM, Simon Horman <horms@verge.net.au>=
 wrote:
>> >> >> > On Tue, Feb 20, 2018 at 01:51:28PM +0100, Geert Uytterhoeven wro=
te:
>> >> >> >> On Mon, Feb 12, 2018 at 6:44 PM, Fabrizio Castro
>> >> >> >> <fabrizio.castro@bp.renesas.com> wrote:
>> >> >> >> > this series has been around for some time as RFC, and it has =
collected
>> >> >> >> > useful comments from the community along the way.
>> >> >> >> > The solution proposed by this patch set works for most R-Car =
Gen2 and
>> >> >> >> > RZ/G1 devices, but not all of them. We now know that for some=
 R-Car
>> >> >> >> > Gen2 early revisions there is no proper software fix. Anyway,=
 no
>> >> >> >> > product has been built around early revisions, but developmen=
t boards
>> >> >> >> > mounting early revisions (basically prototypes) are still out=
 there.
>> >> >> >> > As a result, this series isn't enabling the internal watchdog=
 on R-Car
>> >> >> >> > Gen2 boards, developers may enable it in board specific devic=
e trees
>> >> >> >> > if needed.
>> >> >> >> > This series has been tested by me on the iwg20d, iwg22d, Lage=
r, Alt,
>> >> >> >> > and Koelsch boards.
>> >> >> >> >
>> >> >> >> > The problem
>> >> >> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >> >> > To deal with SMP on R-Car Gen2 and RZ/G1, we install a reset =
vector
>> >> >> >> > to ICRAM1 and we program the [S]BAR registers so that when we=
 turn ON
>> >> >> >> > the non-boot CPUs they are redirected to the reset vector ins=
talled by
>> >> >> >> > Linux in ICRAM1, and eventually they continue the execution t=
o RAM,
>> >> >> >> > where the SMP bring-up code will take care of the rest.
>> >> >> >> > The content of the [S]BAR registers survives a watchdog trigg=
ered reset,
>> >> >> >> > and as such after the watchdog fires the boot core will try a=
nd execute
>> >> >> >> > the SMP bring-up code instead of jumping to the bootrom code.
>> >> >> >> >
>> >> >> >> > The fix
>> >> >> >> > =3D=3D=3D=3D=3D=3D=3D
>> >> >> >> > The main strategy for the solution is to let the reset vector=
 decide
>> >> >> >> > if it needs to jump to shmobile_boot_fn or to the bootrom cod=
e.
>> >> >> >> > In a watchdog triggered reset scenario, since the [S]BAR regi=
sters keep
>> >> >> >> > their values, the boot CPU will jump into the newly designed =
reset
>> >> >> >> > vector, the assembly routine will eventually test WOVF (a bit=
 in register
>> >> >> >> > RWTCSRA that indicates if the watchdog counter has overflown,=
 the value
>> >> >> >> > of this bit gets retained in this scenario), and jump to the =
bootrom code
>> >> >> >> > which will in turn load up the bootloader, etc.
>> >> >> >> > When bringing up SMP or using CPU hotplug, the reset vector w=
ill jump
>> >> >> >> > to shmobile_boot_fn instead.
>> >> >> >> >
>> >> >> >> > Thank you All for your help.
>> >> >> >> >
>> >> >> >> > Best regards,
>> >> >> >> >
>> >> >> >> > Fabrizio Castro (26):
>> >> >> >> >   ARM: shmobile: Add watchdog support
>> >> >> >> >   ARM: dts: r8a7743: Adjust SMP routine size
>> >> >> >> >   ARM: dts: r8a7745: Adjust SMP routine size
>> >> >> >> >   ARM: dts: r8a7790: Adjust SMP routine size
>> >> >> >> >   ARM: dts: r8a7791: Adjust SMP routine size
>> >> >> >> >   ARM: dts: r8a7792: Adjust SMP routine size
>> >> >> >> >   ARM: dts: r8a7793: Adjust SMP routine size
>> >> >> >> >   ARM: dts: r8a7794: Adjust SMP routine size
>> >> >> >> >   soc: renesas: rcar-rst: Enable watchdog as reset trigger fo=
r Gen2
>> >> >> >> >   ARM: shmobile: rcar-gen2: Add watchdog support
>> >> >> >> >   dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
>> >> >> >> >   watchdog: renesas_wdt: Add R-Car Gen2 support
>> >> >> >> >   watchdog: renesas_wdt: Add restart handler
>> >> >> >> >   ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
>> >> >> >> >   clk: renesas: r8a7743: Add rwdt clock
>> >> >> >> >   clk: renesas: r8a7745: Add rwdt clock
>> >> >> >> >   clk: renesas: r8a7790: Add rwdt clock
>> >> >> >> >   clk: renesas: r8a7791/r8a7793: Add rwdt clock
>> >> >> >> >   clk: renesas: r8a7794: Add rwdt clock
>> >> >> >> >   ARM: dts: r8a7743: Add watchdog support to SoC dtsi
>> >> >> >> >   ARM: dts: r8a7745: Add watchdog support to SoC dtsi
>> >> >> >> >   ARM: dts: r8a7790: Add watchdog support to SoC dtsi
>> >> >> >> >   ARM: dts: r8a7791: Add watchdog support to SoC dtsi
>> >> >> >> >   ARM: dts: r8a7794: Add watchdog support to SoC dtsi
>> >> >> >> >   ARM: dts: iwg20m: Add watchdog support to SoM dtsi
>> >> >> >> >   ARM: dts: iwg22m: Add watchdog support to SoM dtsi
>> >> >> >> >
>> >> >> >> >  .../devicetree/bindings/watchdog/renesas-wdt.txt   | 19 ++++=
++--
>> >> >> >> >  arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |  5 ++
>> >> >> >> >  arch/arm/boot/dts/r8a7743.dtsi                     | 12 ++++=
-
>> >> >> >> >  arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |  5 ++
>> >> >> >> >  arch/arm/boot/dts/r8a7745.dtsi                     | 12 ++++=
-
>> >> >> >> >  arch/arm/boot/dts/r8a7790.dtsi                     | 12 ++++=
-
>> >> >> >> >  arch/arm/boot/dts/r8a7791.dtsi                     | 12 ++++=
-
>> >> >> >> >  arch/arm/boot/dts/r8a7792.dtsi                     |  2 +-
>> >> >> >> >  arch/arm/boot/dts/r8a7793.dtsi                     |  2 +-
>> >> >> >> >  arch/arm/boot/dts/r8a7794.dtsi                     | 12 ++++=
-
>> >> >> >> >  arch/arm/configs/shmobile_defconfig                |  1 +
>> >> >> >> >  arch/arm/mach-shmobile/common.h                    |  6 +++
>> >> >> >> >  arch/arm/mach-shmobile/headsmp.S                   | 55 ++++=
++++++++++++++++++
>> >> >> >> >  arch/arm/mach-shmobile/platsmp-apmu.c              |  1 +
>> >> >> >> >  arch/arm/mach-shmobile/pm-rcar-gen2.c              | 15 ++++=
--
>> >> >> >> >  drivers/clk/renesas/r8a7743-cpg-mssr.c             |  2 +
>> >> >> >> >  drivers/clk/renesas/r8a7745-cpg-mssr.c             |  2 +
>> >> >> >> >  drivers/clk/renesas/r8a7790-cpg-mssr.c             |  2 +
>> >> >> >> >  drivers/clk/renesas/r8a7791-cpg-mssr.c             |  2 +
>> >> >> >> >  drivers/clk/renesas/r8a7794-cpg-mssr.c             |  2 +
>> >> >> >> >  drivers/soc/renesas/rcar-rst.c                     | 35 ++++=
+++++++---
>> >> >> >> >  drivers/watchdog/renesas_wdt.c                     | 39 ++++=
+++++++++--
>> >> >> >>
>> >> >> >> Thanks, I've queued the clock patches in clk-renesas-for-v4.17,=
 as they are
>> >> >> >> a hard dependency for:
>> >> >> >>   (1) The new reset vector in arch/arm/mach-shmobile/
>> >> >> >>   (2) The watchdog driver.
>> >> >> >>
>> >> >> >> Note that the watchdog driver itself (2) has a hard dependency =
on the
>> >> >> >> new reset vector (1).
>> >> >> >
>> >> >> > Thanks, I have marked the watchdog driver patch as Deferred.
>> >> >> > Please resubmit or otherwise ping me once they dependencies
>> >> >> > are in an rc release.
>> >> >>
>> >> >> I gave the dependencies a bit more thought.
>> >> >>
>> >> >> I think we can gain once release cycle if you would postpone the D=
TS patches
>> >> >> (both SMP routine size adjustments and RWDT device node additions)=
 to v4.18.
>> >> >> Then all other parts can be upstreamed in parallel in v4.17, as no=
thing
>> >> >> will be activated before the DTS parts are in.
>> >> >>
>> >> >> Does this look sane?
>> >> >
>> >> > What about new DTS on old kernels of a specific vintage?
>> >>
>> >> New DTS would work fine on v4.16 and older, which don't have any of t=
he
>> >> other patches from this series.
>> >> New DTS would work fine on v4.17, assumed all other patches from this
>> >> series get into v4.17.
>> >>
>> >> The only issue would be a new DTS on a kernel that has some but not a=
ll
>> >> other patches from this series.
>> >
>> > Thanks for the analysis. I think this is the key point. What is the ri=
sk of
>> > that happening?
>>
>> I think the risk is fairly low.
>> You control when the DTS changes go in, and also when they are backporte=
d
>> to LTSI.
>>
>> >> If we want to fast-track everything into v4.17, we need a stable bran=
ch, to be
>> >> pulled by all 5 actors (clk-renesas, mach-shmobile, soc-renesas, watc=
hdog,
>> >> renesas-dts).
>> >
>> > It seems that watchdog is the only item on that list that neither you =
nor I
>> > sign off on. So I conclude that if the watchdog patch goes in early en=
ough
>> > in the cycle then we ought to be in good shape.
>> >
>> > None the less, is it worth the risk?
>>
>> Do we want the functionality early, or can we wait until v4.19?
>
> I understand that the watchdog driver has been accepted and that as thing=
s
> currently stand if it is enabled in the build it will be enabled in DT an=
d
> a crash will result. From my POV that is a regression so I have decided
> to adopt the alternate plan proposed by Geert above: in short drop DT
> patches (to avoid enabling broken driver) and enqueue mach-shmobile
> patches (which don't make things any worse.
>
> Patch-by-patch things are as follows.
>
> Dropped from "[PATCH v5 00/26] Fix watchdog on Renesas R-Car Gen2 and RZ/=
G1":
>
> 979d28f29742 ARM: dts: r8a7743: Adjust SMP routine size
> 0b205f679f5d ARM: dts: r8a7745: Adjust SMP routine size
> 2ad21a1d78b3 ARM: dts: r8a7790: Adjust SMP routine size
> 82c978459c77 ARM: dts: r8a7791: Adjust SMP routine size
> d303698e6ff3 ARM: dts: r8a7792: Adjust SMP routine size
> d8b8b9a1e295 ARM: dts: r8a7793: Adjust SMP routine size
> 70b3ab369773 ARM: dts: r8a7794: Adjust SMP routine size
>
> ebf26cf1b1de ARM: dts: r8a7743: Add watchdog support to SoC dtsi
> 5a4566ab3777 ARM: dts: r8a7745: Add watchdog support to SoC dtsi
> acd58e2bb1e5 ARM: dts: r8a7790: Add watchdog support to SoC dtsi
> e3f89168e72f ARM: dts: r8a7791: Add watchdog support to SoC dtsi
> e76a6a69a1fc ARM: dts: r8a7794: Add watchdog support to SoC dtsi
> 242cc1ab7f7c ARM: dts: iwg20m: Add watchdog support to SoM dtsi
> 748ed07f6c7c ARM: dts: iwg22m: Add watchdog support to SoM dtsi
>
>
> Dropped from "[PATCH/RFC 00/11] ARM: dts: rcar-gen2: Enable watchdog supp=
ort":
>
> c257202482e2 ARM: dts: r8a7792: Add RWDT node
> 01ec04dec8eb ARM: dts: r8a7793: Add RWDT node
> 8e6ebe4f2f94 ARM: dts: lager: Enable watchdog support
> f223ad0198f6 ARM: dts: koelsch: Enable watchdog support
> 1d14d2bb700d ARM: dts: porter: Enable watchdog support
> bf71652fc955 ARM: dts: blanche: Enable watchdog support
> 13a0b10aeea4 ARM: dts: wheat: Enable watchdog support
> 4e247bf110b8 ARM: dts: gose: Enable watchdog support
> 2dcbd24bbf5e ARM: dts: alt: Enable watchdog support
> 7f6844c900b4 ARM: dts: silk: Enable watchdog support
>
> And applied:
>
> [v5] ARM: shmobile: rcar-gen2: Add watchdog support
> [v5] ARM: shmobile: Add watchdog support
>
> In the case of the last patch above I removed the #ifdef from the header =
file.

Thank you, sounds good to me.

BTW, who will take "dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 supp=
ort"?
G=C3=BCnter, Wim: will you take this through the watchdog tree, too?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
