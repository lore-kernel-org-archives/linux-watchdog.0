Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:36378 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330AbbKZX2X (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 18:28:23 -0500
From: Harald Geyer <harald@ccbib.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-reply-to: <20151126163936.GO19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org> <1444220352-20548-2-git-send-email-harald@ccbib.org> <20151126092526.GM19888@pengutronix.de> <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at> <20151126163936.GO19888@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-ID: <1512.1448580493.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: QUOTED-PRINTABLE
Date: Fri, 27 Nov 2015 00:28:13 +0100
Message-Id: <E1a25xV-0000OQ-J9@stardust.g4.wien.funkfeuer.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

Uwe Kleine-K=C3=B6nig writes:
> On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> > Uwe Kleine-K=C3=B6nig writes:
> > > Hmm, so you set a bit in a persistent register iff the watchdog i=
s
> > > running.  And if that bit is set during probe you assume the watc=
hdog
> > > reset the machine. But this also happens, when the user presses t=
he
> > > reset button which makes the detection unreliable.
> >=20
> > Yes, kind of. I'm using this driver on an imx233-olinuxino, where t=
he
> > reset button causes the device to power cycle and thus clears the
> > persitent bit. So I can't test your case, but surely there are some=
 paths
>=20
> So the rtc isn't properly battery backed?

Yes, since the mainline kernel can't do anything useful with the batter=
y
other than reporting it's voltage, nobody uses imx233-olinuxino with
mainline kernel and battery.

> AFAIUI the persistent bits should survive a power cycle?!

I only tested without battery, and in my case they definitely don't.

> I think somewhere in our hardware
> repository at Pengutronix we have a machine where I can test that, I
> will check that.

Thanks!

Best regards,
Harald

> > into reset, that don't clear the bit and cause false positives.
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig   =
         |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |

--=20
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via bitcoin to 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
