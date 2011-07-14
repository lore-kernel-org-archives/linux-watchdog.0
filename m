Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail131.messagelabs.com ([216.82.242.99]:33150 "EHLO
	mail131.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab1GNRXq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2011 13:23:46 -0400
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Wolfram Sang <w.sang@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "wim@iguana.be" <wim@iguana.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"tim.bird@am.sony.com" <tim.bird@am.sony.com>
Date: Thu, 14 Jul 2011 12:23:43 -0500
Subject: RE: [RFC 0/6] watchdog drivers converted to the new framework
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383E05B65@AUSP01VMBX24.collaborationhost.net>
References: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wednesday, July 13, 2011 1:26 PM, Wolfram Sang wrote:
> As promised, here is a RFC with two examples demonstrating how watchdog=
 drivers
> can be converted to use the new watchdog framework (using the current v=
ersion
> Wim posted two days ago). There is also conversion guide put to the
> documentation folder. Being RFC, all this is not final yet, but present=
able, I
> hope.
>=20
> Although there are a few more consolidation options left, there is alre=
ady a
> gain of ~100 lines per driver. Promising, but there are a few issues to=
 be
> sorted out, too, yet nothing which can be dealt with.
>=20
> I have two other drivers in the making (stmp3xxx and imx2), but they ne=
ed some
> more preparation; the first one needs some internal cleanups (like a lo=
t of
> watchdog drivers); the latter one needs an addition to the framework
> (installing a timer for non-stoppable devices). I will also prepare a n=
ew
> driver (mx1) to show how small new drivers can be now :) The aim for al=
l these
> driver conversions is inclusion in Linux 3.2. I still hope we can get t=
he basic
> framework into Linux 3.1.
>=20
> Many thanks to CELF/LF for supporting this work and to Wim and Alan for=
 making
> the framework!
>=20
> Looking forward to comments,

What's the status on Wim's watchdog framework patches?  It would be nice =
to have
them re-posted and CC the linux-arm-kernel list.  Not everyone follows lk=
ml
regularly.

I found Wim's patches on lkml and converted the ep93xx watchdog driver an=
d get:

 drivers/watchdog/ep93xx_wdt.c |  174 +++++++++--------------------------=
-----
 1 files changed, 39 insertions(+), 135 deletions(-)

Overall I like the results.  It also makes the driver a lot easier to fol=
low.

I would also like to convert this driver into a proper platform_driver us=
ing
ioremap'ed addresses instead of the static mappings.  Converting the driv=
er
to the new watchdog framework would make this a bit cleaner.

Regards,
Hartley--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
