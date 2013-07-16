Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36000 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab3GPOEk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 10:04:40 -0400
Date: Tue, 16 Jul 2013 11:04:36 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org, wim@iguana.be,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 00/10] Orion Watchdog fixes
Message-ID: <20130716140435.GA23904@localhost>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch>
 <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
 <20130716121432.GA2317@localhost>
 <20130716134422.GE12062@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130716134422.GE12062@titan.lakedaemon.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 09:44:22AM -0400, Jason Cooper wrote:
> On Tue, Jul 16, 2013 at 09:14:33AM -0300, Ezequiel Garcia wrote:
> > On the other side, I'm much interested in knowing if you are OK with
> > breaking the watchdog DT compatibility. If you NACK this, then I'll
> > start preparing a different watchdog driver for 370/XP, since I don't
> > want to extend a driver that is a bit dirty.
>=20
> Apparently there is some agreement that the bindings are still in flux
> and that they need to be for a bit longer in order to hammer out
> problems such as this.
>=20
> Arnd and Olof both mentioned that something (a doc, and email?) is
> forthcoming about marking some bindings as stable.  Whatever form that
> takes, this one wouldn't get the stable marking yet. ;-)
>=20

Yup, that's my understanding as well. But on the other side, I don't
want to break possible users out there.

So, just to check, you say it's early enough to safely do such change?

In that case, I'll extend this patchset to include Armada 370/XP support
and post it as soon as Sebastian's clocksource stuff gets in.

> Oh, and one more nit.  The work 'fix' triggers a whole bunch of "get on
> this right away, does it need to go to stable?  Has anyone confirmed it=
?
> Which commit caused the regression? etc."  Although I hate the word, I
> think 'refactoring' is much more appropriate description for this serie=
s.
>=20

Oh, good observation. I wrote the cover letter at 8 PM, after ten long
hours (*) of hacking and smashing this into something easy to review,
and that's the best title I could come up with. I'll change it on v2.

Thanks,

(*) yes, I have another pair of eyes, in case these wear out.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
