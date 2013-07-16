Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35191 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab3GPMOj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 08:14:39 -0400
Date: Tue, 16 Jul 2013 09:14:33 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org, wim@iguana.be,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 00/10] Orion Watchdog fixes
Message-ID: <20130716121432.GA2317@localhost>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch>
 <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130716073101.GB25043@lunn.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Thomas, Andrew:

Thanks for looking at this!

On Tue, Jul 16, 2013 at 09:31:01AM +0200, Andrew Lunn wrote:
> On Tue, Jul 16, 2013 at 09:20:59AM +0200, Thomas Petazzoni wrote:
> >=20
> > On Tue, 16 Jul 2013 08:59:52 +0200, Andrew Lunn wrote:
> >=20
> > > Maybe i'm missing something here. You are making use of
> > > orion_timer_ctrl_clrset() from time-orion.c. How will this work on
> > > 370/XP which has a different clocksource driver?
> >=20
> > I *think* the idea is that the Armada 370/XP driver will expose the
> > same function, so from the point of view of the watchdog driver, it
> > will just work.

Indeed that was one of the ideas. As Thomas said, this was just
preparation work.

>=20
> That was what i was thinking would happen. And then i started to
> wonder how well the kernel linker deals with multiple definitions of
> the same symbol. Dove and 370/XP can end up in the same kernel. So we
> need to have both orion-timer and the 370/XP timer in the same kernel,
> so we end up with the same symbol in the kernel twice...
>=20

Yeah, well... I wasn't sure about using the same name, so another approac=
h
would be adding a new compatible to the driver and then make it use the
appropriate function in the 370/XP clocksource driver (with a different n=
ame).

And, yet another approach, is what Sebastian just said, although I'm
not sure I understood it :). In any case, we have already several solutio=
ns,
which is why I'm not too worried about this particular issue.

On the other side, I'm much interested in knowing if you are OK with
breaking the watchdog DT compatibility. If you NACK this, then I'll
start preparing a different watchdog driver for 370/XP, since I don't
want to extend a driver that is a bit dirty.

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
