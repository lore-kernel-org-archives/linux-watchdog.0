Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36485 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdHHEKd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 8 Aug 2017 00:10:33 -0400
Subject: Re: Possible race in pc87413_wdt.ko
To: Anton Volkov <avolkov@ispras.ru>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <da42be1b-f442-6294-a163-84e1b971a651@ispras.ru>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <41535b54-6d50-fad8-139c-c6f569ffc89e@roeck-us.net>
Date: Mon, 7 Aug 2017 21:10:29 -0700
MIME-Version: 1.0
In-Reply-To: <da42be1b-f442-6294-a163-84e1b971a651@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/07/2017 06:22 AM, Anton Volkov wrote:
> Hello.
> 
> While searching for races in the Linux kernel I've come across "drivers/watchdog/pc87413_wdt.ko" module. Here is a question that I came up with while analyzing results. Lines are given using the info from Linux v4.12.
> 
> Consider the following case:
> 
> Thread 1:                          Thread 2:
> pc87413_init
>     misc_register(&pc87413_miscdev)
> -> pc87413_get_swc_base_addr       pc87413_open
>                                     -> pc87413_refresh
>                                        -> pc87413_swc_bank3
>       swc_base_addr = ...                  <read access to swc_base_addr>
>       (pc87413_wdt.c: line 133)            (pc87413_wdt.c: line 146)
> 
> So in this case preemptive registration of the device leads to a possibility of race between the initialization process and a callback to the registered device.
> 
> Is this race feasible from your point of view? And if it is, is it possible to move the device registration a bit further down in the pc87413_init function?
> 

Yes, the race is feasible, and it is possible to move the device registration function
(though the preferred solution would be to convert the driver to use the watchdog
subsystem). The code looks pretty bad as written.

Just not sure if it is worth bothering about it. I suspect no on is using that driver
anymore (the datasheet is from 2001). Might as well just declare it obsolete and
wait for someone to scream.

Guenter
