Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57787 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754395AbaJWA5S (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 20:57:18 -0400
Message-ID: <5448520E.3030305@free-electrons.com>
Date: Wed, 22 Oct 2014 21:55:42 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
To: Andrew Lunn <andrew@lunn.ch>
CC: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-watchdog@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] watchdog: orion: Use the reference clock on Armada
 375 SoC
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com> <1413984884-20273-3-git-send-email-ezequiel.garcia@free-electrons.com> <20141022140221.GP9845@lunn.ch> <54483297.90102@free-electrons.com> <20141022235900.GA20968@lunn.ch>
In-Reply-To: <20141022235900.GA20968@lunn.ch>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/22/2014 08:59 PM, Andrew Lunn wrote:
> On Wed, Oct 22, 2014 at 07:41:27PM -0300, Ezequiel Garcia wrote:
>> On 10/22/2014 11:02 AM, Andrew Lunn wrote:
>>> On Wed, Oct 22, 2014 at 10:34:42AM -0300, Ezequiel Garcia wrote:
>>>> The 25 MHz reference clock has better stability so its use is pref=
erred over the
>>>> core clock. Changes the Armada 375 clock initialization to use thi=
s reference
>>>> clock. To ensure the driver is compatible with an old devicetree, =
also provide
>>>> a fallback path which will silently return to the previous behavio=
r.
>>>
>>> Hi Ezequiel
>>>
>>> There is now quite a lot of code in orion_wdt.c which is not releva=
nt
>>> to Orion5x and Kirkwood. Would it be possible to put some of it ins=
ide
>>> a #ifdef MACH_MVEBU_V7?
>>>
>>
>> Hum.. I found ifdefs scary, so I tend to avoid them if at all possib=
le.
>> Just did a quick hack enclosing all the armada-xxx stuff around #if =
0
>> and here's the result:
>>
>> $ ./scripts/bloat-o-meter ~/linux/.builds/mvebu_v7/drivers/watchdog/=
orion_wdt.o ~/linux/.builds/orion5x/drivers/watchdog/orion_wdt.o
>> add/remove: 0/0 grow/shrink: 1/4 up/down: 12/-80 (-68)
>> function                                     old     new   delta
>> orion_wdt_probe                              732     744     +12
>> orion_wdt_get_timeleft                        44      40      -4
>> orion_enabled                                 68      60      -8
>> orion_start                                  120      88     -32
>> orion_wdt_ping                                80      44     -36
>=20
> Hi Ezequiel
>=20
> I did a similar test:
>=20
> size drivers/watchdog/orion_wdt.o-*
>    text	   data	    bss	    dec	    hex	filename
>    4428	    100       1    4529    11b1	drivers/watchdog/orion_wdt.o-=
full-fat
>    2324	    100	      1    2425	    979	drivers/watchdog/orion_wdt.o-=
skimmed
>=20
> So for v5 kirkwood/orion5x, there is about 90% overhead from the v7
> code, in the text section. This is for -rc1 code, before adding any
> more v7 code in this patchset.
>=20
> I don't think the #ifdef's look that scary.
>=20

I understand it's a lot of overhead when you think of the relative
driver's size, but still it's just a 2 KiB saving.

Don't get me wrong, I'm all for reducing bloat, but I don't want to
author a patch that ifdefs all around the place to save a couple kiloby=
tes.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
