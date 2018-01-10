Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:60517 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933087AbeAJJ5V (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 10 Jan 2018 04:57:21 -0500
Subject: Re: [PATCH v2 0/2] ARM: davinici: move watchdog restart from mach to
 drivers
To: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-watchdog@vger.kernel.org>
CC: Kevin Hilman <khilman@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>
References: <1515294615-5473-1-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <87c020cd-2453-9ffc-8daa-5fca1c1705c2@ti.com>
Date: Wed, 10 Jan 2018 15:25:19 +0530
MIME-Version: 1.0
In-Reply-To: <1515294615-5473-1-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sunday 07 January 2018 08:40 AM, David Lechner wrote:
> This series moves the watchdog restart code from arch/arm/mach-davinci
> to drivers/watchdog.
> 
> Tested working on LEGO MINDSTORMS EV3 (TI AM1808 processor).
> 
> v2 changes:
> * rebased on linux-davinci/master (fixed conflict with clock.h)
> 
> There is also still the unresolved question from Sekhar:
> 
>> Hi Wim,
>>
>> How do you want to handle this series? Patch 2/2 definitely needs to go
>> through my tree as it will clash with other code I am queuing.
>>
>> I can either take 1/2 also through ARM-SoC with your ack (preferred) or
>> if you give me an immutable commit/tag over v4.15-rc1, I can merge that
>> to preserve bisect-ability.

I see that 1/2 is already present in linux-next through commit 71d1f058844d.

At this time, I think the best way forward is to send 2/2 through my
tree. The only downside is if Linus merges ARM-SoC tree ahead of
watchdog tree, there will be a small period during merge window where
reset will be broken on DaVinci devices. I guess thats not such a big
issue (and I see no way around it except postponing 2/2 to v4.17).

I will be sending a pull request for 2/2 to ARM-SoC shortly and will
copy folks from this thread too.

Thanks,
Sekhar
