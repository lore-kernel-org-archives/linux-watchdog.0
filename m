Return-Path: <geert.uytterhoeven@gmail.com>
Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <TY1PR06MB08950BD28BEC28D55C6D80EDC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWVvMJR5NHMFn6zx39jw2XdP5nteU3actUcen0dmoT-LQ@mail.gmail.com> <TY1PR06MB08950BD28BEC28D55C6D80EDC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2018 13:10:59 +0100
Message-ID: <CAMuHMdUOoMHqu3WD8GUbGFTfeAsw9d5vKtkzdMQjMfTEknos-A@mail.gmail.com>
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
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-clk <linux-clk@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi Fabrizio,

On Fri, Jan 26, 2018 at 12:52 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
>> Subject: Re: [RFC 01/37] ARM: shmobile: Add watchdog support
>> On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
>> <fabrizio.castro@bp.renesas.com> wrote:
>> > On R-Car Gen2 and RZ/G1 platforms, we use the SBAR registers to make n=
on
>> > boot CPUs run a routine designed to bring up SMP and deal with hot plu=
g.
>> > The value contained in the SBAR registers is not initialized by a WDT
>> > triggered reset, which means that after a WDT triggered reset we jump
>> > to the SMP bring up routine, preventing the system from executing the
>> > bootrom code.
>>
>> Thanks for your patch!
>
> Thank you for looking into this!
>
> I am not going to reply to your comments on the other patches for now, as=
 we need to find a solution for this particular patch we are all happy with=
 first.
> A change to this patch may impact the other patches as well.
>
>> > The purpose of this patch is to jump to the bootrom code in case of a
>> > WDT triggered reset, and keep the SMP functionality untouched.
>> > In order to tell if the code had been called due to the WDT overflowin=
g
>> > we need to inspect flag WOVF from register RWTCSRA, however for this
>> > to work smoothly we need to make sure that RWDT clock is ON.
>> > Since it's not wise to interfere with the clock configuration from
>> > within this routine, a flag has been put in place
>> > (shmobile_wdt_clock_status) so that the watchdog driver can tell
>> > shmobile_boot_vector when the clock is ON, and therefore there is no
>> > need for shmobile_boot_vector to mess up with the clock registers.
>> >
>> > Bit WOVF survives a watchdog triggered reset, and it is usually cleare=
d
>> > by the bootloader. Checking the MMU enable bit from register SCTLR
>> > allows us to make the code a little bit more robust (just in case the
>> > bit wasn't cleared up), as right after a reset the MMU is disabled,
>> > and when Linux is running the MMU is enabled. Also, accessing RWTCSRA
>> > physical address is safe when the MMU is down.
>>
>> Checking a hardware register is indeed a better solution than my origina=
l
>> idea to let SMP bringup set a flag in RAM, as the former is less racy.
>
> Also, such a flag would not be accessible after the reset gets triggered.

It would, if it's stored in e.g. ICRAM.

>> However, as you can probably imagine, I don't like the
>> shmobile_wdt_clock_status part ;-)
>
> Neither do I!      :-D

Good ;-)

>> Isn't is sufficient to check the MMU enable bit?
>
> I am afraid it isn't, when bringing up SMP the cores will read the MMU fl=
ag as disabled, to make things worse at that precise point in time the rwdt=
 clock is disabled.
> If the system just restarted due to the watchdog, then when you read WOVF=
 chances are you are going to read '1', hence the system will fail to bring=
 up SMP.

OK, so I was mislead by the MMU check.

>> However, that would precludes uClinux (do we care?).
>
> The MMU will be constantly disabled in this case, wouldn't it? Therefore =
the reset vector will always proceed with the testing of variable "shmobile=
_wdt_clock_status", and it'll finally test WOVF only when it's safe to do s=
o. If WOVF is set, then we still jump to the bootrom code. if WOVF is not s=
et, then we jump to shmobile_boot_fn. Could you please elaborate your thoug=
hts a little bit more?
>
>> Is there any other register/bit that's reset when the watchdog is
>> triggered, and always set by Linux?
>
> Not that I know of, but you may know better ;-P
> Any suggestion?

Any chance WDTRSTCR.RWDT_RSTMSK is reinitialized to 1 on watchdog reset?
Probably not, as the Hardware User's Manual says the register is
initialized on power on reset caused by PRESET#.

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
