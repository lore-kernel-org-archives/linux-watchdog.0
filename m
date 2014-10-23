Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60296 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755237AbaJWMSR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Oct 2014 08:18:17 -0400
Message-ID: <5448F1A1.9040404@free-electrons.com>
Date: Thu, 23 Oct 2014 09:16:33 -0300
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
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com> <20141022155614.04d33791@free-electrons.com>
In-Reply-To: <20141022155614.04d33791@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/22/2014 10:56 AM, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
>=20
> On Wed, 22 Oct 2014 10:34:40 -0300, Ezequiel Garcia wrote:
>> This series adds support for the 25 MHz reference clock available on
>> Armada 375 SoC to use on the timer and watchdog drivers. It is
>> similar to the one present in Armada XP SoC.
>>
>> Given we initially had access to only a very early SoC revision (A37=
5 Z0)
>=20
> Actually: s/Z0/Z1/.
>=20
>> and due to a hardware issue, the timer and watchdog support was orig=
inally
>> submitted to use the core clock.
>>
>> Now that the A0 SoC revision is out, we can fix this and use the ref=
erence
>> clock. The reason for this change is that the core clock is subject =
to the
>> SSCG, so boards where SSCG is enabled exhibit a very large timer dri=
ft.
>>
>> To prevent any compatibility issues when booting with an older devic=
etree,
>> this series provides proper fall backs in each case.
>=20
> You don't clearly state whether your patch series keep compatibility
> with the 375 Z1 or not. And in fact, it doesn't keep compatibility wi=
th
> Z1. I'm fine with that, but then it means we should officially declar=
e
> the Z1 support in mainline as dead, and get rid of the workarounds th=
at
> applied only to 375 Z1.
>=20

How many people have Z1 boards? And is someone actually using one for
something? Do we have any other reason to support Z1?

=46WIW, a v3.18-rc1 kernel built with mvebu_v7_defconfig, silently stal=
ls
in the middle of the boot on Z1. Had to remove lots of compile time
options to make it boot.

Before I start digging into this, maybe we can discuss your suggestion
to drop it. If nobody is booting this often enough, maybe nobody cares
about this, and it makes sense to drop the support?
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
