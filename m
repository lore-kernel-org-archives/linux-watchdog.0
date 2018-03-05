Return-Path: <aaro.koskinen@iki.fi>
Return-path: <aaro.koskinen@iki.fi>
Date: Mon, 5 Mar 2018 21:30:58 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Joel Stanley <joel@jms.id.au>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Baruch Siach <baruch@tkos.co.il>,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Jimmy Vance <jimmy.vance@hpe.com>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Zwane Mwaikambo <zwanem@gmail.com>,
	Jim Cromie <jim.cromie@gmail.com>, Barry Song <baohua@kernel.org>,
	Patrice Chotard <patrice.chotard@st.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Marc Gonzalez <marc.w.gonzalez@free.fr>,
	Mans Rullgard <mans@mansr.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>, Jun Nie <jun.nie@linaro.org>,
	Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v5] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180305193057.3pxsfc6i5fjdi5dm@darkstar.musicnaut.iki.fi>
References: <20180301085450.13829-1-marcus.folkesson@gmail.com>
 <20180304235319.55gulkoxk4vcaoug@darkstar.musicnaut.iki.fi>
 <9db48467-7727-87b7-5c55-9c53c46a901f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db48467-7727-87b7-5c55-9c53c46a901f@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

On Sun, Mar 04, 2018 at 05:11:00PM -0800, Guenter Roeck wrote:
> On 03/04/2018 03:53 PM, Aaro Koskinen wrote:
> > On Thu, Mar 01, 2018 at 09:54:50AM +0100, Marcus Folkesson wrote:
> > > diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
> > > index 39cd51df2ffc..258dfcf9cbda 100644
> > > --- a/drivers/watchdog/retu_wdt.c
> > > +++ b/drivers/watchdog/retu_wdt.c
> > > @@ -1,3 +1,4 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > 
> > Why "+" and not just GPL-2.0?
> 
> My non-attorney feedback, which doesn't really mean anything, is that
> MODULE_LICENSE says GPL. There appears to be no indication in the file
> suggesting that the license would be limited or restricted to GPL v2.

Well, it does ask to check kernel's COPYING file for details.

A.
