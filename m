Return-path: <ukl@pengutronix.de>
Date: Tue, 17 Jan 2017 09:10:06 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Magnus Lilja <lilja.magnus@gmail.com>,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] dts: teach newer i.MX machines to have the i.MX35
 type watchdog
Message-ID: <20170117081006.rptalfhzois5sjvu@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
 <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
 <20170116204337.j67oeknraas7ryib@pengutronix.de>
 <0586b2cd-6cbb-2e8a-9cd6-d7220708931d@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0586b2cd-6cbb-2e8a-9cd6-d7220708931d@mleia.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Vladimir,

On Mon, Jan 16, 2017 at 11:48:40PM +0200, Vladimir Zapolskiy wrote:
> On 01/16/2017 10:43 PM, Uwe Kleine-König wrote:
> > On Mon, Jan 16, 2017 at 04:35:26PM -0200, Fabio Estevam wrote:
> >> On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-König
> >> <u.kleine-koenig@pengutronix.de> wrote:
> >>> Only i.MX35 and newer feature a WMCR register that should be written to. Older
> >>> SoCs hang when this address is written.
> >>>
> >>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >>
> >> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> >>
> >> Only a minor nit: Subject could: ARM: dts: imx: teach...
> > 
> > Ack. To reference the commit id of the first patch in the third I can
> > prepare a branch to pull. There I'd fix the Subject. Shawn, is this OK?
> > 
> 
> This is too early for changes, which are not reviewed by Linux watchdog masters.
> 
> As I emphasized multiple times in our discussions your series is organized
> improperly, it has interdependencies between DTS and driver, it lacks
> atomicity feature of a proper fix, in the middle it breaks backward compatibility
> with old DTB, all that makes it impossible to send an atomic fix for linux-stable,

Oh, I must have missed that. In my inbox there are two replys to my
series, the one I reply to being the first to mention these critics.

Regarding your critics:

 - organized improperly: that alone is too abstract to understand what
   you mean.
 - interdependencies between DTS and driver, lacks atomicity, impossible
   to send an atomic fix for linux-stable: I wonder how you want to get
   rid of that. Yes there are interdependencies, that's because both
   driver and dts need adaption. Well, I could squash together some of
   the changes, then there is a single patch that atomically fixes
   everything. Personally I prefer to have three commits, each one
   changing a single thing and considering all three together as a fix
   for stable.
 - in the middle it breaks backward compatibility: There are three
   patches:

   	1) watchdog: imx2: Only i.MX35 and later have a WMCR register
	2) dts: teach newer i.MX machines to have the i.MX35 type watchdog
	3) watchdog: imx2: add compatibility for new i.MX35 type watchdog

   Before the first patch we have:

	- newer i.mx dtsi wrongly claims to have i.mx21 type watchdog
	- watchdog handles i.MX21 as if it were i.MX35

   After the first patch we have:

	- newer i.mx dtsi wrongly claims to have i.mx21 type watchdog

   And after the second everything is fine (assuming a dtb not older
   than the kernel). So each patch fixes a single thing.

   Yes, after the first patch machines having an i.MX35 type watchdog
   might have a problem. That's because there are two things to fix (so
   there are two patches): The driver must know about the new type and
   the dts must make use of it. And fixing the first makes the second
   visible, but doesn't introduce it (after all the i.MX35 dtsi is wrong
   claiming to have the i.MX21 type).

Now that there are machines known that suffer from the problem under
discussion it's obvious that we want the changes from the third patch.
Personally I don't care much if it stays separate or is squashed into
the first one.

> some of the changes are captured from mine ones without preserving the authorship
> or even a reported-by credit.

Compared to your v1 the similarities are AFAICT:

 - added .data to dt_ids array
 - added an if to only conditionally execute the breaking command
 - added a new compatible to several dtsi files

All these are necessary to fix the problem discussed here. The way I
implemented the first two ones are different to your way. So IMHO it's
at least questionable if you or I should be the author of the patches I
sent.

I'm ok to add a Reported-by for you. I usually add such a tag only after
a request for it. I missed to ask for that, please excuse this.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
