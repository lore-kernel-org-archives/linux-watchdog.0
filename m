Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:29255
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753996Ab2G3DtH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 29 Jul 2012 23:49:07 -0400
Date: Mon, 30 Jul 2012 11:49:06 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
CC: <wim@iguana.be>, <kernel@pengutronix.de>,
	<linux-watchdog@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] watchdog: imx2_wdt: Select the driver via ARCH_MXC
Message-ID: <20120730034904.GE30774@S2101-09.ap.freescale.net>
References: <1341264782-19098-1-git-send-email-festevam@gmail.com>
 <CAOMZO5DiV8io9v2v=6L9zpEY1M+Df3UZGYmSdTofq0FoxVe14Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DiV8io9v2v=6L9zpEY1M+Df3UZGYmSdTofq0FoxVe14Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Jul 28, 2012 at 04:35:46PM -0300, Fabio Estevam wrote:
> On Mon, Jul 2, 2012 at 6:33 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > With device tree support in place, we should not use IMX_HAVE_PLATFORM_IMX2_WDT
> > as a dependency for selecting the imx2_wdt driver.
> >
> > Use ARCH_MXC symbol instead, so that the driver can be even selected by a device-tree
> > only SoC, such as i.MX6.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Sascha/Shawn,
> 
> Any comments?
> 
Acked-by: Shawn Guo <shawn.guo@linaro.org>

