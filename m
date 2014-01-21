Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39969 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753955AbaAUJmP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:42:15 -0500
Date: Tue, 21 Jan 2014 06:42:15 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-watchdog@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 03/15] watchdog: orion: Use atomic access for shared
 registers
Message-ID: <20140121094214.GA3577@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAOMZO5BKjpkjQGOOAQ5fwmxhg1SYTmTq4Y9tUCZaDSQiosGYyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <CAOMZO5BKjpkjQGOOAQ5fwmxhg1SYTmTq4Y9tUCZaDSQiosGYyw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 07:19:52AM -0200, Fabio Estevam wrote:
> On Tue, Jan 21, 2014 at 7:12 AM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > Since the timer control register is shared with the clocksource dri=
ver,
> > use the recently introduced atomic_io_clear_set() to access such re=
gister.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/watchdog/orion_wdt.c | 20 ++++----------------
> >  1 file changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_=
wdt.c
> > index f7722a4..cf64510 100644
> > --- a/drivers/watchdog/orion_wdt.c
> > +++ b/drivers/watchdog/orion_wdt.c
> > @@ -61,8 +61,6 @@ static int orion_wdt_ping(struct watchdog_device =
*wdt_dev)
> >
> >  static int orion_wdt_start(struct watchdog_device *wdt_dev)
> >  {
> > -       u32 reg;
> > -
> >         spin_lock(&wdt_lock);
>=20
> Shouldn't this spin_lock be dropped now?
>=20

Hm... yes. The watchdog core uses a mutex to serialize all the watchdog=
 hooks:
start, stop, ping, set_timeout, etc. So it seems you're right, the spin=
lock
should be dropped entirely as I see no need for it.

Thanks for the feedback,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
