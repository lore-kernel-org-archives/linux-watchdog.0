Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37847 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751317AbaBEXTO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Feb 2014 18:19:14 -0500
Date: Wed, 5 Feb 2014 20:19:04 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Lior Amsalem <alior@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 02/20] clocksource: orion: Use atomic access for
 shared registers
Message-ID: <20140205231903.GA30244@localhost>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390836440-12744-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140205191035.GZ8533@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140205191035.GZ8533@titan.lakedaemon.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 05, 2014 at 02:10:35PM -0500, Jason Cooper wrote:
> On Mon, Jan 27, 2014 at 12:27:02PM -0300, Ezequiel Garcia wrote:
> > Replace the driver-specific thread-safe shared register API
> > by the recently introduced atomic_io_clear_set().
> >=20
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/clocksource/time-orion.c | 28 ++++++++++------------------
> >  1 file changed, 10 insertions(+), 18 deletions(-)
>=20
> The MMIO patch this depends on:
>=20
>   c5ca95b507c8 ARM: 7930/1: Introduce atomic MMIO modify
>=20
> made it in to v3.14-rc1.  It looks like this change is independent of
> the rest of the watchdog series, so:
>=20
> Acked-by: Jason Cooper <jason@lakedaemon.net>
>=20

Thanks, Jason.

Daniel: If you can pick this I'll drop it from the next watchdog patchs=
et
submission.

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
