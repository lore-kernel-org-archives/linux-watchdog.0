Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46997 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752081AbcL1Vq7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Dec 2016 16:46:59 -0500
Date: Wed, 28 Dec 2016 22:46:51 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20161228214651.oncshkvksqep3krk@pengutronix.de>
References: <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
 <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
 <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
 <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
 <20161223100113.s57bi7257yero7f7@pengutronix.de>
 <7018c466-2467-a9fc-2382-889d3a62741e@mentor.com>
 <20161223141139.rlsvoonih5lhnnpu@pengutronix.de>
 <c22600d5-f6b5-4c13-59b4-ba391ea29a4c@mleia.com>
 <20161228205419.la74jr4rfes7fa4v@pengutronix.de>
 <CAOMZO5BD3Y6vXwt7_bdv_KyGvKSYru1vzDowsD81fzEbM4gHPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BD3Y6vXwt7_bdv_KyGvKSYru1vzDowsD81fzEbM4gHPA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 28, 2016 at 07:33:26PM -0200, Fabio Estevam wrote:
> On Wed, Dec 28, 2016 at 6:54 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > I'd do it the other way around and so get more and simpler patches:
> >
> >  - make driver aware of i.MX35
> >  - fix dtsi to use i.MX35 type where applicable
> 
> This would not work for old dtb's as they are not aware of the  i.mx35 type.

Right, so they would fall back to the i.MX21 type and not profit from
Markus' change until either the dtb is updated or the third commit is
added. I'll try to contact Markus to ask if he remembers more details.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
