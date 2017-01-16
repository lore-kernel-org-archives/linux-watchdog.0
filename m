Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47865 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750968AbdAPUoQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 15:44:16 -0500
Date: Mon, 16 Jan 2017 21:43:37 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-watchdog@vger.kernel.org,
        Magnus Lilja <lilja.magnus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dts: teach newer i.MX machines to have the i.MX35
 type watchdog
Message-ID: <20170116204337.j67oeknraas7ryib@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
 <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 16, 2017 at 04:35:26PM -0200, Fabio Estevam wrote:
> On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > Only i.MX35 and newer feature a WMCR register that should be written to. Older
> > SoCs hang when this address is written.
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Only a minor nit: Subject could: ARM: dts: imx: teach...

Ack. To reference the commit id of the first patch in the third I can
prepare a branch to pull. There I'd fix the Subject. Shawn, is this OK?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
