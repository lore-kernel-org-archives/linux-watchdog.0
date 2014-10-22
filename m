Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53477 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752277AbaJVPMO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 11:12:14 -0400
Message-ID: <5447C8CC.7080306@free-electrons.com>
Date: Wed, 22 Oct 2014 12:10:04 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>
CC: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when possible
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>	<5447C276.4050106@free-electrons.com> <20141022164919.4f4f4acf@free-electrons.com>
In-Reply-To: <20141022164919.4f4f4acf@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/22/2014 11:49 AM, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
>=20
> On Wed, 22 Oct 2014 16:43:02 +0200, Gregory CLEMENT wrote:
>=20
>> On 22/10/2014 15:34, Ezequiel Garcia wrote:
>>> This series adds support for the 25 MHz reference clock available o=
n
>>> Armada 375 SoC to use on the timer and watchdog drivers. It is
>>> similar to the one present in Armada XP SoC.
>>
>> I agree with Thomas P. comments: could you see if it was possible to=
 reuse the same
>> function and dt bindings that the ones used for Armada XP ?
>> I am not aware of any difference between Armada XP and Armada 375 fo=
r this IP.
>=20
> Well, there's one difference: on Armada XP we don't need to support t=
he
> "old" Device Tree, which didn't had the fixed 25 Mhz clock input
> described.
>=20

Indeed.

> So either we decide that it was a mistake due to an early version of
> the 375 and we skip backward DT compatibility. Or we need in some way=
 a
> different logic than Armada XP, because Armada XP doesn't have this
> backward compatibility requirement.
>=20

Backward DT compatibility is a must. For instance, patches can be merge=
d
through different routes (which has already happened) and you can break
things badly.

It doesn't worth the risk, for something that can be solved by just
implementing things carefully.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
