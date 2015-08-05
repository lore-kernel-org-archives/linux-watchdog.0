Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59143 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbHEAtZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Aug 2015 20:49:25 -0400
Message-ID: <55C15D8F.4020009@roeck-us.net>
Date: Tue, 04 Aug 2015 17:49:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>,
	linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <55C14E2B.1080904@draigBrady.com>
In-Reply-To: <55C14E2B.1080904@draigBrady.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/04/2015 04:43 PM, Pádraig Brady wrote:
> On 04/08/15 03:13, Guenter Roeck wrote:
>> The watchdog infrastructure is currently purely passive, meaning
>> it only passes information from user space to drivers and vice versa.
>>
>> Since watchdog hardware tends to have its own quirks, this can result
>> in quite complex watchdog drivers. A number of scanarios are especially common.
>>
>> - A watchdog is always active and can not be disabled, or can not be disabled
>>    once enabled. To support such hardware, watchdog drivers have to implement
>>    their own timers and use those timers to trigger watchdog keepalives while
>>    the watchdog device is not or not yet opened.
>> - A variant of this is the desire to enable a watchdog as soon as its driver
>>    has been instantiated, to protect the system while it is still booting up,
>>    but the watchdog daemon is not yet running.
>
> Just mentioning that patting the watchdog in the boot loader
> (by patching grub etc.) can be a more general solution here as it
> avoids hangs if the kernel crashes before it runs the watchdog driver,
> which is especially true if PXE loaded across the net for example.
> Also this tends to be better spaced between boot start and user space loading.
>

I understand. However, that is not always sufficient, and it may not work
well since grub would need to know about the actual watchdog hardware.
Also, there are systems where the time between "watchdog driver instantiated"
and "watchdog daemon started" is just too large for the maximum watchdog
hardware timeout.

The point here is that there _are_ many drivers which implement this
functionality in the driver code. Not counting the drivers I converted as an
exercise, "git grep mod_timer | cut -f1 -d: | sort -u | wc" in drivers/watchdog
suggests that there are 20 more drivers implementing their own heartbeat
management. With that, it just makes sense to move the functionality to
the infrastructure.

Thanks,
Guenter

