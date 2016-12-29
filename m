Return-path: <ukl@pengutronix.de>
Date: Thu, 29 Dec 2016 23:04:45 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Magnus Lilja <lilja.magnus@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20161229220445.x23gcp5aaw2fz7cv@pengutronix.de>
References: <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
 <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
 <20161223100113.s57bi7257yero7f7@pengutronix.de>
 <7018c466-2467-a9fc-2382-889d3a62741e@mentor.com>
 <20161223141139.rlsvoonih5lhnnpu@pengutronix.de>
 <c22600d5-f6b5-4c13-59b4-ba391ea29a4c@mleia.com>
 <20161228205419.la74jr4rfes7fa4v@pengutronix.de>
 <CAOMZO5BD3Y6vXwt7_bdv_KyGvKSYru1vzDowsD81fzEbM4gHPA@mail.gmail.com>
 <20161228214651.oncshkvksqep3krk@pengutronix.de>
 <CAOMZO5CBfiRMicxvGyHrm-rQFzn8yEQyb5=t49PBr6rdpZYPug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CBfiRMicxvGyHrm-rQFzn8yEQyb5=t49PBr6rdpZYPug@mail.gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Dec 28, 2016 at 09:39:51PM -0200, Fabio Estevam wrote:
> On Wed, Dec 28, 2016 at 7:46 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Right, so they would fall back to the i.MX21 type and not profit from
> > Markus' change until either the dtb is updated or the third commit is
> > added. I'll try to contact Markus to ask if he remembers more details.
> 
> There is no profit from Markus' change for mx21/mx27/mx31.

Ack. If you teach the driver now about i.MX35 and only make use of the WMCR
register on this one, the possible breakage is that this register isn't
written to on the i.MX35 type until the dtb is updated.

> As Vladimir explained in his commit log these SoCs do not have the
> WMCR register, which causes a hang on these SoCs when we try to write
> to it.

So this should be fixed by adding support for i.MX35.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
