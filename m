Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50476 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbKZQjk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 11:39:40 -0500
Date: Thu, 26 Nov 2015 17:39:36 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151126163936.GO19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Harald,

On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> Uwe Kleine-K=F6nig writes:
> > On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
> > > This device doesn't provide any information about boot status.
> > > As workaround we use a persitent bit to track watchdog activity.
> >=20
> > Hmm, so you set a bit in a persistent register iff the watchdog is
> > running.  And if that bit is set during probe you assume the watchd=
og
> > reset the machine. But this also happens, when the user presses the
> > reset button which makes the detection unreliable.
>=20
> Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
> reset button causes the device to power cycle and thus clears the
> persitent bit. So I can't test your case, but surely there are some p=
aths

So the rtc isn't properly battery backed? AFAIUI the persistent bits
should survive a power cycle?! I think somewhere in our hardware
repository at Pengutronix we have a machine where I can test that, I
will check that.

> into reset, that don't clear the bit and cause false positives.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
