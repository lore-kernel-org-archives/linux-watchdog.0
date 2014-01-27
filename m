Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50772 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753577AbaA0OtV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 09:49:21 -0500
Date: Mon, 27 Jan 2014 11:49:28 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 00/18] Armada 370/XP watchdog support
Message-ID: <20140127144927.GA3036@localhost>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <52E19A44.7040308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <52E19A44.7040308@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sebastian,

On Thu, Jan 23, 2014 at 11:40:04PM +0100, Sebastian Hesselbarth wrote:
> On 01/23/2014 12:04 AM, Ezequiel Garcia wrote:
> > After some lengthy discussion on the [v2] and [v3] patchsets, here'=
s a new
> > round. I hope I haven't forgotten anything.
> >
>=20
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>=20

As currently Dove doesn't have watchdog support in the devicetree, I've=
 added
it to the v5 (which I'll submit now) with your Tested-by on all the pat=
chset.

Thanks a lot for the test,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
