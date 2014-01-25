Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45388 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751914AbaAYQ5o (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Jan 2014 11:57:44 -0500
Date: Sat, 25 Jan 2014 13:57:47 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
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
Message-ID: <20140125165746.GB12189@localhost>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 22, 2014 at 08:04:57PM -0300, Ezequiel Garcia wrote:
[..]
>=20
> Thanks to everyone who has helped reviewing the previous sets! It's c=
ertainly
> easier to move forward when you get so much nice feedback...
>=20
> Ezequiel Garcia (18):
>   ARM: Introduce atomic MMIO modify
>   clocksource: orion: Use atomic access for shared registers
>   watchdog: orion: Add clock error handling
>   watchdog: orion: Use atomic access for shared registers
>   watchdog: orion: Remove unused macros
>   watchdog: orion: Make sure the watchdog is initially stopped
>   watchdog: orion: Handle IRQ
>   watchdog: orion: Make RSTOUT register a separate resource
>   watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
>   watchdog: orion: Introduce an orion_watchdog device structure
>   watchdog: orion: Introduce per-compatible of_device_id data
>   watchdog: orion: Add per-compatible clock initialization
>   watchdog: orion: Add per-compatible watchdog start implementation
>   watchdog: orion: Add support for Armada 370 and Armada XP SoC
>   ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
>   ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
>   watchdog: orion: Enable the build on ARCH_MVEBU
>   ARM: mvebu: Enable watchdog support in defconfig
>=20
[..]

If at all possible I'd like to get some acks or reviews from the people
that has followed, reviewed and discussed this series with me.

Jason, Arnd, Andrew?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
