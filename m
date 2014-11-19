Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39719 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755547AbaKSKpk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Nov 2014 05:45:40 -0500
Date: Wed, 19 Nov 2014 11:45:35 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 0/3] Make Armada 375 use the reference clock when possible
Message-ID: <20141119104535.GB8973@spo001.leaseweb.nl>
References: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com> <546C6226.5000900@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <546C6226.5000900@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Daniel,

I'll review before the weekend and will let you know something.
But everything through one tree is fine by me.

Kind regards,
Wim.

> On 11/04/2014 02:21 PM, Ezequiel Garcia wrote:
> >Hi Daniel, Wim:
> >
> >Seems we are ready to merge these, unless some objection raises. Do =
you=20
> >think
> >you can take the patches through your trees?
>=20
> Hi Wim,
>=20
> I can take through my tree the entire patchset if you want but I need=
=20
> your blessing for the watchdog part.
>=20
> Thanks
>   -- Daniel
>=20
> >Changes from v2:
> >
> >   * Fix messed up empty lines, as suggested by Thomas Petazzoni.
> >
> >Changes from v1:
> >
> >   * Make the A375 timer and watchdog devicetree binding match the h=
ardware
> >     and require the two available clocks: core and reference clock.
> >
> >This series adds support for the 25 MHz reference clock available on
> >Armada 375 SoC to be used on the timer and watchdog drivers. It is
> >similar to the one present in Armada XP SoC.
> >
> >Given we initially had access to only a very early SoC revision (A37=
5 Z1)
> >and due to a hardware issue, the timer and watchdog support was orig=
inally
> >submitted to use the core clock.
> >
> >Now that the A0 SoC revision is out, we can fix this and use the ref=
erence
> >clock. The reason for this change is that the core clock is subject =
to the
> >SSCG (Spread Spectrum Clock Generator), so boards where SSCG is enab=
led
> >exhibit a very large timer drift.
> >
> >Notice that this change will produce unpleseant results on A375 Z1, =
given=20
> >the
> >reference 25 MHz clock doesn't work properly on that SoC revision.
> >
> >But since the Z1 revision is not supported by the recently submitted=
 A375
> >network driver (mvpp2), and therefore nobody is expected to run main=
line
> >(if there are users at all of this early revision), the support will=
 be
> >dropped entirely in a near future.
> >
> >To prevent any compatibility issues when booting with an older devic=
etree,
> >this series provides proper fall backs in each case.
> >
> >The series applies on v3.18-rc2.
> >
> >Ezequiel Garcia (3):
> >   clocksource: armada-370-xp: Add missing clock enable
> >   watchdog: orion: Use the reference clock on Armada 375 SoC
> >   clocksource: armada-370-xp: Use the reference clock on A375 SoC
> >
> >  .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++--
> >  .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
> >  drivers/clocksource/time-armada-370-xp.c           | 30 ++++++++++=
++++++
> >  drivers/watchdog/orion_wdt.c                       | 42=20
> >  +++++++++++++++++++++-
> >  4 files changed, 90 insertions(+), 4 deletions(-)
> >
>=20
>=20
> --=20
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
