Return-Path: <fabrizio.castro@bp.renesas.com>
Return-path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Michael
 Turquette" <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
	Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>, Ramesh Shanmugasundaram
	<ramesh.shanmugasundaram@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro@bp.renesas.com>
Subject: RE: [RFC v2 01/37] ARM: shmobile: Add watchdog support
Date: Fri, 26 Jan 2018 16:16:34 +0000
Message-ID: <TY1PR06MB089517B9B153473B3F411B96C0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <TY1PR06MB08950BD28BEC28D55C6D80EDC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <1516982937-29245-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1516982937-29245-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hello Geert,


>> Since shmobile_boot_vector has become bigger, "reg" property of nodes
>> compatible with "renesas,smp-sram" now need to be set to "<0 0x64>".

> This breaks backwards compatibility with old DTs declaring a too small
> smp-sram area. If the area is too small, you should fallback to the old a=
nd
> smaller code.

would the v2s for patches 01/37 and 23/37 be ok with you to take care of th=
at issue?

Thanks,
Fabrizio



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
