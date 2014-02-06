Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47116 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaBFXrg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 18:47:36 -0500
Received: by mail-wg0-f42.google.com with SMTP id l18so310319wgh.1
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Feb 2014 15:47:35 -0800 (PST)
Message-ID: <52F41F15.307@linaro.org>
Date: Thu, 06 Feb 2014 23:47:33 +0000
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Lior Amsalem <alior@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 02/20] clocksource: orion: Use atomic access for shared
 registers
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390836440-12744-3-git-send-email-ezequiel.garcia@free-electrons.com> <20140205191035.GZ8533@titan.lakedaemon.net> <20140205231903.GA30244@localhost>
In-Reply-To: <20140205231903.GA30244@localhost>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/05/2014 11:19 PM, Ezequiel Garcia wrote:
> On Wed, Feb 05, 2014 at 02:10:35PM -0500, Jason Cooper wrote:
>> On Mon, Jan 27, 2014 at 12:27:02PM -0300, Ezequiel Garcia wrote:
>>> Replace the driver-specific thread-safe shared register API
>>> by the recently introduced atomic_io_clear_set().
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> ---
>>>   drivers/clocksource/time-orion.c | 28 ++++++++++-----------------=
-
>>>   1 file changed, 10 insertions(+), 18 deletions(-)
>>
>> The MMIO patch this depends on:
>>
>>    c5ca95b507c8 ARM: 7930/1: Introduce atomic MMIO modify
>>
>> made it in to v3.14-rc1.  It looks like this change is independent o=
f
>> the rest of the watchdog series, so:
>>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>
>
> Thanks, Jason.
>
> Daniel: If you can pick this I'll drop it from the next watchdog patc=
hset
> submission.

Yep, ok. I am out of the office for the moment, I will take care of it=20
Monday.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
