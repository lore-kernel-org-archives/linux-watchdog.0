Return-Path: <marcus.folkesson@gmail.com>
Return-path: <marcus.folkesson@gmail.com>
Date: Mon, 5 Mar 2018 23:08:04 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
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
Message-ID: <20180305220804.GA3424@gmail.com>
References: <20180301085450.13829-1-marcus.folkesson@gmail.com>
 <20180304235319.55gulkoxk4vcaoug@darkstar.musicnaut.iki.fi>
 <9db48467-7727-87b7-5c55-9c53c46a901f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db48467-7727-87b7-5c55-9c53c46a901f@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Guenter, Aaro,

On Sun, Mar 04, 2018 at 05:11:00PM -0800, Guenter Roeck wrote:
> On 03/04/2018 03:53 PM, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Thu, Mar 01, 2018 at 09:54:50AM +0100, Marcus Folkesson wrote:
> > > diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
> > > index 39cd51df2ffc..258dfcf9cbda 100644
> > > --- a/drivers/watchdog/retu_wdt.c
> > > +++ b/drivers/watchdog/retu_wdt.c
> > > @@ -1,3 +1,4 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > 
> > Why "+" and not just GPL-2.0?
> > 
> 
> My non-attorney feedback, which doesn't really mean anything, is that
> MODULE_LICENSE says GPL. There appears to be no indication in the file
> suggesting that the license would be limited or restricted to GPL v2.
> 

Yep, that is correct.
The license for this module is set to "GPLv2 or later" as MODULE_LICENSE says "GPL".

>From include/linux/module.h [1]:

/*
 * The following license idents are currently accepted as indicating free
 * software modules
 *
 *	"GPL"				[GNU Public License v2 or later]
 *	"GPL v2"			[GNU Public License v2]
 *	"GPL and additional rights"	[GNU Public License v2 rights and more]
 *	"Dual BSD/GPL"			[GNU Public License v2
 *					 or BSD license choice]
 *	"Dual MIT/GPL"			[GNU Public License v2
 *					 or MIT license choice]
 *	"Dual MPL/GPL"			[GNU Public License v2
 *					 or Mozilla license choice]
 *


But in this case the boilerplate license text was GPLv2, and I should
have go for that instead.


> This makes me wonder if we should drop this patch entirely. I am not an
> attorney, and if we start getting into license disputes I rather revert
> to doing nothing than getting into trouble by signing off to something
> that isn't legally clean.
> 

I understand that.
Nor am I a lawyer, but I have strong reverence for licenses and really
want it to be right without any doubt which license is applicable.

My motivation for this patch was that:

1) Many modules suggests different licenses in the boilerplate
	license text and MODULE_LICENSE which makes life hard.

2) Even many new drivers for the kernel has a mismatch in
	SPDX/Boilerplate/MODULE_LICENSE(), so there is a knowledge gap to
	fill. I think it has been good to just raise this question.

3) SPDX is uniform and really filling its purpose [2]. Better up, it is in
	our guidelines to use SPDX identifier to express the license [3]:

	"
		The Linux kernel requires the precise SPDX identifier in all source files.
	The valid identifiers used in the kernel are explained in the section
	`License identifiers`_ and have been retrieved from the official SPDX
	license list at https://spdx.org/licenses/ along with the license
	texts.
	"

4) Make the source file match the licence that the author **really**
	intended to use. Some reviewers has the intention to use GPLv2 but has
	stated "GPLv2 or later" without knowing it. Just bringing it up to
	light is good.

5) I guess that not all authors will go through their files and add SPDX
	identifiers, so this patch was intended to help.


Also, I want to point out that this patch does not (intentionally) *change*
any license, just express it in another way that is more uniform and more in
line with our guidelines for the kernel.

However, there has been much doubt and insecurity about this.

I do not mind if we choose to drop this patch, just let me know.

But still, I think it would be good to go through all licenses
because it is not clear what license is applicable in all files.


[1] https://elixir.bootlin.com/linux/latest/source/include/linux/module.h
[2] https://spdx.org/sites/cpstandard/files/pages/files/using_spdx_license_list_short_identifiers.pdf
[3] https://elixir.bootlin.com/linux/v4.16-rc4/source/Documentation/process/license-rules.rst


Best regards,
Marcus Folkesson


> Guenter
