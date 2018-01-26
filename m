Return-Path: <geert.uytterhoeven@gmail.com>
Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1516903391-30467-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com> <1516903391-30467-2-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2018 10:46:23 +0100
Message-ID: <CAMuHMdWVvMJR5NHMFn6zx39jw2XdP5nteU3actUcen0dmoT-LQ@mail.gmail.com>
Subject: Re: [RFC 01/37] ARM: shmobile: Add watchdog support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-clk <linux-clk@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hi Fabrizio,

On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> On R-Car Gen2 and RZ/G1 platforms, we use the SBAR registers to make non
> boot CPUs run a routine designed to bring up SMP and deal with hot plug.
> The value contained in the SBAR registers is not initialized by a WDT
> triggered reset, which means that after a WDT triggered reset we jump
> to the SMP bring up routine, preventing the system from executing the
> bootrom code.

Thanks for your patch!

> The purpose of this patch is to jump to the bootrom code in case of a
> WDT triggered reset, and keep the SMP functionality untouched.
> In order to tell if the code had been called due to the WDT overflowing
> we need to inspect flag WOVF from register RWTCSRA, however for this
> to work smoothly we need to make sure that RWDT clock is ON.
> Since it's not wise to interfere with the clock configuration from
> within this routine, a flag has been put in place
> (shmobile_wdt_clock_status) so that the watchdog driver can tell
> shmobile_boot_vector when the clock is ON, and therefore there is no
> need for shmobile_boot_vector to mess up with the clock registers.
>
> Bit WOVF survives a watchdog triggered reset, and it is usually cleared
> by the bootloader. Checking the MMU enable bit from register SCTLR
> allows us to make the code a little bit more robust (just in case the
> bit wasn't cleared up), as right after a reset the MMU is disabled,
> and when Linux is running the MMU is enabled. Also, accessing RWTCSRA
> physical address is safe when the MMU is down.

Checking a hardware register is indeed a better solution than my original
idea to let SMP bringup set a flag in RAM, as the former is less racy.
However, as you can probably imagine, I don't like the
shmobile_wdt_clock_status part ;-)

Isn't is sufficient to check the MMU enable bit?
However, that would precludes uClinux (do we care?).
Is there any other register/bit that's reset when the watchdog is
triggered, and always set by Linux?

> SMP bringup, CPU hot plug, and suspend to RAM work as normal.

shmobile_boot_vector is not only used for R-Car Gen2 and RZ/G1 SoCs, but
also for EMMA Mobile, SH/R-Mobile, and R-Car H1.  Hence this breaks SMP
for the latter (and their build if ARCH_RENESAS=n, due to missing
shmobile_wdt_clock_status).

> Since shmobile_boot_vector has become bigger, "reg" property of nodes
> compatible with "renesas,smp-sram" now need to be set to "<0 0x64>".

This breaks backwards compatibility with old DTs declaring a too small
smp-sram area. If the area is too small, you should fallback to the old and
smaller code.

> --- a/arch/arm/mach-shmobile/headsmp.S
> +++ b/arch/arm/mach-shmobile/headsmp.S
> @@ -16,6 +16,13 @@
>  #include <asm/assembler.h>
>  #include <asm/memory.h>
>
> +#define RWDT_CLOCK_ON  0xdeadbeef
> +#define RWDT_CLOCK_OFF 0x00000000
> +#define SCTLR_MMU      0x01
> +#define BOOTROM_ADDRESS        0xE6340000
> +#define RWTCSRA_ADDRESS 0xE6020004
> +#define RWTCSRA_WOVF   0x10
> +
>  /*
>   * Reset vector for secondary CPUs.
>   * This will be mapped at address 0 by SBAR register.
> @@ -24,11 +31,57 @@
>         .arm
>         .align  12
>  ENTRY(shmobile_boot_vector)

This should become e.g. rcar_gen2_boot_vector_wdt

> +/*
> +       if (SCTLR_MMU == 1)
> +               goto shmobile_smp_continue;
> +*/
> +       mrc     p15, 0, r1, c1, c0, 0           @ r1 = SCTLR
> +       and     r0, r1, #SCTLR_MMU
> +       cmp     r0, #SCTLR_MMU
> +       beq     shmobile_smp_continue
> +/*
> +       if (shmobile_wdt_clock_status != RWDT_CLOCK_ON)
> +               goto shmobile_smp_continue;
> +*/
> +       ldr     r0, #shmobile_wdt_clock_status
> +       ldr     r1, #clock_on
> +       cmp     r0, r1
> +       bne     shmobile_smp_continue
> +
> +/*
> +       if (RWTCSRA_WOVF == 0)
> +               goto shmobile_smp_continue;
> +*/
> +       ldr     r0, rwtcsra
> +       mov     r1, #0
> +       ldrb    r1, [r0]
> +       and     r0, r1, #RWTCSRA_WOVF
> +       cmp     r0, #RWTCSRA_WOVF
> +       bne     shmobile_smp_continue
> +
> +/*
> +       goto bootrom;
> +*/
> +       ldr     r0, bootrom
> +       bx      r0
> +
> +shmobile_smp_continue:

This should become

    ENTRY(shmobile_boot_vector)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
