Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60441 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755323AbaJWMpL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Oct 2014 08:45:11 -0400
Message-ID: <5448F7F1.1080509@free-electrons.com>
Date: Thu, 23 Oct 2014 09:43:29 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when possible
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>	<20141022155614.04d33791@free-electrons.com>	<5448F1A1.9040404@free-electrons.com> <20141023142657.6b4d61fb@free-electrons.com>
In-Reply-To: <20141023142657.6b4d61fb@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/23/2014 09:26 AM, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
>=20
> On Thu, 23 Oct 2014 09:16:33 -0300, Ezequiel Garcia wrote:
>=20
>>> You don't clearly state whether your patch series keep compatibilit=
y
>>> with the 375 Z1 or not. And in fact, it doesn't keep compatibility =
with
>>> Z1. I'm fine with that, but then it means we should officially decl=
are
>>> the Z1 support in mainline as dead, and get rid of the workarounds =
that
>>> applied only to 375 Z1.
>>
>> How many people have Z1 boards? And is someone actually using one fo=
r
>> something? Do we have any other reason to support Z1?
>>
>> FWIW, a v3.18-rc1 kernel built with mvebu_v7_defconfig, silently sta=
lls
>> in the middle of the boot on Z1. Had to remove lots of compile time
>> options to make it boot.
>>
>> Before I start digging into this, maybe we can discuss your suggesti=
on
>> to drop it. If nobody is booting this often enough, maybe nobody car=
es
>> about this, and it makes sense to drop the support?
>=20
> Marvell has always said they are not interested in having Z1 supporte=
d
> in mainline, except as a first step to start getting the 375 support =
in
> mainline. I have been waiting for everyone of us to have access to 37=
5
> A0 platforms, which is now the case. So I believe we can probably get
> rid of the 375 Z1 support entirely.
>=20
> It saddens me to know that a shiny development board in the office wi=
ll
> no longer be useful for anything else but its own physical beauty, bu=
t
> I believe that's a normal retirement strategy for a very early
> development platform :-)
>=20

I'm afraid I have news for you. Even now, the board is almost unusable,
as the mvpp2 network driver only supports A0 (Z1 support was never even
planned).

So you have a NAS development board without network... sounds pretty
useless to me :)
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
