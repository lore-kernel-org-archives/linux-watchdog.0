Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19212 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751883Ab2KTM7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Nov 2012 07:59:38 -0500
Date: Tue, 20 Nov 2012 07:58:34 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Kukjin Kim <kgene.kim@samsung.com>,
	linux-watchdog@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ben Dooks <ben-linux@fluff.org>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/8] watchdog: orion_wdt: add timeout-sec property
 binding
Message-ID: <20121120125834.GU22106@titan.lakedaemon.net>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
 <1353334243-16703-4-git-send-email-fabio.porcedda@gmail.com>
 <20121119160643.GI22106@titan.lakedaemon.net>
 <CAHkwnC-2MXtNODnqjOvFuHt7ToqvMqeDjnqdGyGfMacKBWzoLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHkwnC-2MXtNODnqjOvFuHt7ToqvMqeDjnqdGyGfMacKBWzoLw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 01:50:46PM +0100, Fabio Porcedda wrote:
> On Mon, Nov 19, 2012 at 5:06 PM, Jason Cooper <jason@lakedaemon.net> wr=
ote:
> > On Mon, Nov 19, 2012 at 03:10:38PM +0100, Fabio Porcedda wrote:
> >> Only compile tested.
> >>
> >> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> >> Cc: Jason Cooper <jason@lakedaemon.net>
> >> Cc: Andrew Lunn <andrew@lunn.ch>
> >> ---
> >>  Documentation/devicetree/bindings/watchdog/marvel.txt | 5 +++++
> >>  drivers/watchdog/orion_wdt.c                          | 8 +++-----
> >>  2 files changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b=
/Documentation/devicetree/bindings/watchdog/marvel.txt
> >> index 0b2503a..5dc8d30 100644
> >> --- a/Documentation/devicetree/bindings/watchdog/marvel.txt
> >> +++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
> >> @@ -5,10 +5,15 @@ Required Properties:
> >>  - Compatibility : "marvell,orion-wdt"
> >>  - reg                : Address of the timer registers
> >>
> >> +Optional properties:
> >> +
> >> +- timeout-sec        : Contains the watchdog timeout in seconds
> >> +
> >>  Example:
> >>
> >>       wdt@20300 {
> >>               compatible =3D "marvell,orion-wdt";
> >>               reg =3D <0x20300 0x28>;
> >> +             timeout-sec =3D <10>;
> >>               status =3D "okay";
> >>       };
> >> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_w=
dt.c
> >> index c20f96b..446a3e9 100644
> >> --- a/drivers/watchdog/orion_wdt.c
> >> +++ b/drivers/watchdog/orion_wdt.c
> >> @@ -162,12 +162,10 @@ static int __devinit orion_wdt_probe(struct pl=
atform_device *pdev)
> >>
> >>       wdt_max_duration =3D WDT_MAX_CYCLE_COUNT / wdt_tclk;
> >>
> >> -     if ((heartbeat < 1) || (heartbeat > wdt_max_duration))
> >> -             heartbeat =3D wdt_max_duration;
> >> -
> >> -     orion_wdt.timeout =3D heartbeat;
> >>       orion_wdt.min_timeout =3D 1;
> >> +     orion_wdt.timeout =3D wdt_max_duration;
> >>       orion_wdt.max_timeout =3D wdt_max_duration;
> >> +     watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node=
);
> >
> > Hi Fabio,
> >
> > There are many boards using pdata, !CONFIG_OF.  Have you compile-test=
ed
> > this without CONFIG_OF?
>=20
> Hi Jason,
>=20
> I've tested with and without the CONFIG_OF define.
>=20
> The first time I=E2=80=99ve used the kirkwood_defconfig without modific=
ations,
> the second time I=E2=80=99ve enabled only the CONFIG_MACH_SHEEVAPLUG an=
d
> disabled USE_OF.
>=20
> In both cases the orion_wdt driver compile without any warning.
>=20
> Thanks for the review.

Acked-by: Jason Cooper <jason@lakedaemon.net>

for the orion_wdt bits.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
