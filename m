Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42896 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbcA1Bvy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Jan 2016 20:51:54 -0500
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: William Breathitt Gray <vilhelm.gray@gmail.com>, wim@iguana.be
References: <20160125190942.GA6824@sophia>
 <20160125192810.2487661b@lxorguk.ukuu.org.uk> <56A6889E.60208@roeck-us.net>
 <56A6B198.2080205@gmail.com> <56A6CB48.4010402@roeck-us.net>
 <56A80391.40009@gmail.com> <56A84F75.3050805@roeck-us.net>
 <20160128001836.GA15216@sophia>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A97436.1090703@roeck-us.net>
Date: Wed, 27 Jan 2016 17:51:50 -0800
MIME-Version: 1.0
In-Reply-To: <20160128001836.GA15216@sophia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/27/2016 04:18 PM, William Breathitt Gray wrote:
> On Tue, Jan 26, 2016 at 09:02:45PM -0800, Guenter Roeck wrote:
>>> Unfortunately, the sensors-detect only reported "No" for each Super I/O
>>> chip test, while the superiotool gave an unhelpful "No Super I/O chip
>>> detected" message.
>>>
>>
>> Too bad. That suggests that the watchdog may in fact be implemented in the fpga.
>
> I received a response from WinSystems: the watchdog timer is implemented
> in the Lattice FPGA (base address 0x298), along with other WinSystems
> firmware. I was offered two methods of identifying the chip.
>
> The first method is to use a 16-bit read of the register at port address
> 0x29E to get the version number of the watchdog timer; my machine
> reported a value of 0x0009. Unfortunately, I don't believe this method
> is very reliable since the version number may not be consistent across
> these motherboards, and the same value could easily happen to be
> returned by an unknown hardware.
>
> The second method is slightly more involved so I'll quote WinSystems:
>
>> 8-bit read of 299h – save this value
>> 8-bit write of 60h to 299h
>> 16-bit read of 29ah should return the base address of the WDT which is 564h
>> 8-bit write of saved value to 299h - don’t want t accidentally change the WDT base address
>
> If the system does return a value of 0x564, then it's pretty safe to say
> that the watchdog timer is implemented on the chip. However, I'm not
> sure it would be safe to send write commands to a port address until the
> hardware has been identified; this second method may not be the best
> route either.
>
> What do you think?
>
Let's stick with DMI.

Thanks,
Guenter

