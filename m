Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40487 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754090AbaAUKxI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 05:53:08 -0500
Date: Tue, 21 Jan 2014 07:53:21 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 02/15] clocksource: orion: Use atomic access for
 shared registers
Message-ID: <20140121105320.GA4356@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <52DE4491.2000505@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <52DE4491.2000505@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Daniel,

On Tue, Jan 21, 2014 at 10:57:37AM +0100, Daniel Lezcano wrote:
> On 01/21/2014 10:12 AM, Ezequiel Garcia wrote:
> > Replace the driver-specific thread-safe shared register API
> > by the recently introduced atomic_io_clear_set().
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>=20
> in the future, put me in Cc when modifying files in clocksource that=20
> will make my life easier to track the changes.
>=20

Ouch, sorry about that.

[..]
> >   /*
> >    * Free-running clocksource handling.
> > @@ -68,7 +54,8 @@ static int orion_clkevt_next_event(unsigned long =
delta,
> >   {
> >   	/* setup and enable one-shot timer */
> >   	writel(delta, timer_base + TIMER1_VAL);
> > -	orion_timer_ctrl_clrset(TIMER1_RELOAD_EN, TIMER1_EN);
> > +	atomic_io_modify(timer_base + TIMER_CTRL,
> > +		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);
>=20
> I am not convinced this change is worth.
>=20
> Could you elaborate the race the spinlock should prevent ?
>=20

Sure. Take a look to the patchset that adds the atomic I/O (sorry again=
 for
not Ccing you on that one):

  http://www.spinics.net/lists/arm-kernel/msg292775.html

The TIMER_CTRL register provides clocksource and watchdog control, so w=
e
need a safe way to access the register, since we're sharing it on two
completely unrelated drivers.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
