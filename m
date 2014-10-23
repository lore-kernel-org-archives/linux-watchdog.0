Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60387 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755294AbaJWMiS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Oct 2014 08:38:18 -0400
Message-ID: <5448F653.5070206@free-electrons.com>
Date: Thu, 23 Oct 2014 09:36:35 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
To: Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Lior Amsalem <alior@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when possible
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com> <20141022155614.04d33791@free-electrons.com> <20141022140847.GQ9845@lunn.ch>
In-Reply-To: <20141022140847.GQ9845@lunn.ch>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/22/2014 11:08 AM, Andrew Lunn wrote:
>> You don't clearly state whether your patch series keep compatibility
>> with the 375 Z1 or not. And in fact, it doesn't keep compatibility w=
ith
>> Z1.
>=20
> Hi Thomas
>=20
> That answers my question. Thanks
>=20
>> I'm fine with that, but then it means we should officially declare
>> the Z1 support in mainline as dead, and get rid of the workarounds t=
hat
>> applied only to 375 Z1.
>=20
> A big ACK.
>=20
> How bad is it if you run these patches on a Z1? Is it worth adding a
> revision check and calling BUG()?
>=20

So, I just tried this on a Z1. Here's the result:

sleep 3 -> sleeps for 6 seconds

Configuring the watchdog for 3 seconds and:

echo "barf" > /dev/watchdog -> resets after 6 seconds

So using the 25 MHz reference clock is broken on Z1, but the point at
least boots; it will "just" keep track of time wrongly.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
