Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33404 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753363AbaA2SUH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jan 2014 13:20:07 -0500
Date: Wed, 29 Jan 2014 15:19:50 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 00/20] Armada 370/XP watchdog support
Message-ID: <20140129181949.GB27143@localhost>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
> A new round, mostly fixing some minor nitpicks.
>=20

If anyone wants to give this a test, here's a public branch:

https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_=
v5

I'll be resending a new v6 adressing Russell's last comment about the
clock initialization, as soon as v3.14-rc1 is out.

Go, testers, go!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
