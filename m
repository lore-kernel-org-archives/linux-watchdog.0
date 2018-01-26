Return-Path: <geert.uytterhoeven@gmail.com>
Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1516903391-30467-12-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com> <1516903391-30467-12-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2018 11:06:53 +0100
Message-ID: <CAMuHMdUGq-k55RoGLvtG_fbG_aXtENovjKzpkHF5WD0nTon+zA@mail.gmail.com>
Subject: Re: [RFC 11/37] soc: renesas: rcar-rst: Document generic compatible strings
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

On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> From now on, devices compatible with the generic compatible strings
> documented by this commit don't need to modify the corresponding driver
> anymore.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks for your patch!

>From commit 362922a1a5345d17 ("reset: Add renesas,rst DT bindings")

    As the features provided by the hardware module differ a lot across the
    various SoC families and members, only SoC-specific compatible values
    are defined.

In fact the only commonalities are the presence of the MODEMR register
(the mode bits differ), and the Watchdog Timer Reset Control Register.
All other registers and bits depend on the SoC's CPU core configuration.

Hence that's why I did not add generic compatible values.
So unless you really need them (from this series, it looks like you
don't?), I wouldn't add them.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
