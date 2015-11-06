Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42170 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030298AbbKFWCy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Nov 2015 17:02:54 -0500
Date: Fri, 6 Nov 2015 14:02:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Akshay Bhat <akshay.bhat@timesys.com>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, justin.waters@timesys.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
Message-ID: <20151106220249.GA19791@roeck-us.net>
References: <1446758362-11702-1-git-send-email-akshay.bhat@timesys.com>
 <1446758362-11702-2-git-send-email-akshay.bhat@timesys.com>
 <20151105222325.GA26159@roeck-us.net>
 <CAJ+vNU2fSxRJ7YvxOfNzoEoiKgzv-dHj=+eksKxH48ekHiUw2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2fSxRJ7YvxOfNzoEoiKgzv-dHj=+eksKxH48ekHiUw2Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 06, 2015 at 11:53:42AM -0800, Tim Harvey wrote:
> On Thu, Nov 5, 2015 at 2:23 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Thu, Nov 05, 2015 at 04:19:21PM -0500, Akshay Bhat wrote:
> >> From: Tim Harvey <tharvey@gateworks.com>
> >>
> >> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
> >> can be pinmux'd to an external pin. This is typically used for boards that
> >> have PMIC's in control of the IMX6 power rails. In fact, failure to use
> >> such an external reset on boards with external PMIC's can result in various
> >> hangs due to the IMX6 not being fully reset [1] as well as the board failing
> >> to reset because its PMIC has not been reset to provide adequate voltage for
> >> the CPU when coming out of reset at 800Mhz.
> >>
> >> This uses a new device-tree property 'ext-reset-output' to indicate the
> >> board has such a reset and to cause the watchdog to be configured to assert
> >> WDOG_B instead of an internal reset both on a watchdog timeout and in
> >> system_restart.
> >>
> >> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
> >>
> >> Cc: Lucas Stach <l.stach@pengutronix.de>
> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >> ---
> >>  .../devicetree/bindings/watchdog/fsl-imx-wdt.txt     |  2 ++
> >>  drivers/watchdog/imx2_wdt.c                          | 20 ++++++++++++++++++--
> >>  2 files changed, 20 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> >> index 8dab6fd..9b89b3a 100644
> >> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> >> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> >> @@ -9,6 +9,8 @@ Optional property:
> >
> > properties ?
> >
> >>  - big-endian: If present the watchdog device's registers are implemented
> >>    in big endian mode, otherwise in native mode(same with CPU), for more
> >>    detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
> >> +- ext-reset-output: If present the watchdog device is configured to assert its
> >
> > Should that have a vendor prefix ? Also, not sure if "-output"
> > has any real value in the property name. "fsl,external-reset", maybe ?
> 
> Hi Guenter,
> 
> I don't see why a vendor prefix is necessary - its a feature of the
> IMX6 watchdog supported by this driver to be able to trigger an
> internal chip-level reset and/or an external signal that can be hooked
> to additional hardware.
> 
Sounded like vendor specific to me, but then I am not a devicetree maintainer,
so I am not an authority on the subject.

> I started with ext-reset, but it was suggested
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347437.html)
> to also make it clear that this is an 'output' and not a reset input.
> 
No problem, as long as you get an Ack from a devicetree maintainer.

Guenter
