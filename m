Return-Path: <geert.uytterhoeven@gmail.com>
Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1516903391-30467-11-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com> <1516903391-30467-11-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2018 11:05:58 +0100
Message-ID: <CAMuHMdWiVu9hs3PvXypJyeG0iDQkDvyPzHkTfq4NyPVdaYZKew@mail.gmail.com>
Subject: Re: [RFC 10/37] soc: renesas: rcar-rst: Enable watchdog as reset
 trigger for Gen2
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
> This patch allows for platform specific quirks as some of the SoC need
> further customization for the watchdog to work properly, like for R-Car
> Gen2 and for RZ/G.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/soc/renesas/rcar-rst.c
> +++ b/drivers/soc/renesas/rcar-rst.c
> @@ -13,8 +13,18 @@
>  #include <linux/of_address.h>
>  #include <linux/soc/renesas/rcar-rst.h>
>
> +#define WDTRSTCR_RESET         0xA55A0002
> +#define WDTRSTCR               0x0054
> +
> +static int gen2_configuration(void __iomem *base)

rcar_rst_enable_wdt_reset()?

> +{
> +       iowrite32(WDTRSTCR_RESET, base + WDTRSTCR);
> +       return 0;
> +}
> +
>  struct rst_config {
> -       unsigned int modemr;    /* Mode Monitoring Register Offset */
> +       unsigned int modemr;            /* Mode Monitoring Register Offset */
> +       int (*configure)(void *base);   /* Platform specific configuration */
>  };
>
>  static const struct rst_config rcar_rst_gen1 __initconst = {
> @@ -23,6 +33,7 @@ static const struct rst_config rcar_rst_gen1 __initconst = {
>
>  static const struct rst_config rcar_rst_gen2 __initconst = {
>         .modemr = 0x60,
> +       .configure = gen2_configuration,

BTW, does it hurt to do this on R-Car Gen3, too?

Instead of a function pointer, you could also just have a feature bit.

>  };
>
>  static const struct rst_config rcar_rst_gen3 __initconst = {
> @@ -79,6 +90,14 @@ static int __init rcar_rst_init(void)
>         rcar_rst_base = base;
>         cfg = match->data;
>         saved_mode = ioread32(base + cfg->modemr);
> +       if (cfg->configure) {
> +               error = cfg->configure(base);
> +               if (error) {
> +                       pr_warn("%pOF: Cannot run SoC specific configuration\n",
> +                               np);
> +                       goto out_put;
> +               }
> +       }
>
>         pr_debug("%pOF: MODE = 0x%08x\n", np, saved_mode);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
