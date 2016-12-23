Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45503 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759508AbcLWKBY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Dec 2016 05:01:24 -0500
Date: Fri, 23 Dec 2016 11:01:13 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20161223100113.s57bi7257yero7f7@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
 <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
 <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
 <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
 <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 23, 2016 at 11:27:24AM +0200, Vladimir Zapolskiy wrote:
> On 12/23/2016 10:32 AM, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Fri, Dec 23, 2016 at 10:20:20AM +0200, Vladimir Zapolskiy wrote:
> >> On 12/23/2016 03:55 AM, Guenter Roeck wrote:
> >>> What is the ultimate conclusion of this exchange ?
> >>>
> >>> Are we going to get another version of the patch, or did everyone agree that
> >>> the patch is good as it is and does not require further changes ?
> >>>
> >>
> >> I can not imagine a different fix.
> > 
> > my preferred fix would be:
> > 
> >  - add an imx35 compatible to all newer dtsi
> >  - update the driver to only write the wmcr on imx35 compatible devices
> >    adding only imx35.
> > 
> 
> It breaks old DTS vs. new kernel compatibility, I've already mentioned this.

Correct, and I didn't deny that. In my mail I pointed out the problem
this imposes and I think it's small enough to not justify the complexity
introduced in your proposed change.

If we cannot agree then at least this needs to be better documented in
the driver because otherwise someone makes a cleanup later dropping all
the compatibles that are needed to keep backwards compatibility.

But my suggestion is to first do the minimal fix, and if in the next
merge window people lament about breakages on their machine, we can
still extend the simple fix to a fully backwards compatible change.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
