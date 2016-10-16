Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35160 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754862AbcJPPzo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Oct 2016 11:55:44 -0400
Subject: Re: [PATCH] watchdog: at91sam9: keep watchdog running in idle mode
To: Sylvain Rochet <sylvain.rochet@finsecur.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        linux-arm-kernel@lists.infradead.org
References: <1444163325-3041-1-git-send-email-sylvain.rochet@finsecur.com>
 <20151007110112.GD3485@piout.net>
 <20161016153316.rsrcgnki6kn7gola@finsecur.com>
 <67fe262e-31e4-b9dc-da71-af601079bfec@roeck-us.net>
Cc: stable@vger.kernel.org,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "wim@iguana.be" <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <59c665f8-de09-c11c-f62a-5064016cd8fd@roeck-us.net>
Date: Sun, 16 Oct 2016 08:55:41 -0700
MIME-Version: 1.0
In-Reply-To: <67fe262e-31e4-b9dc-da71-af601079bfec@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/16/2016 08:50 AM, Guenter Roeck wrote:
> On 10/16/2016 08:33 AM, Sylvain Rochet wrote:
>> Hi,
>>
>> On Wed, Oct 07, 2015 at 01:01:12PM +0200, Alexandre Belloni wrote:
>>> On 06/10/2015 at 22:28:45 +0200, Sylvain Rochet wrote :
>>>> Since turning on idle-halt in commit 5161b31dc39a (watchdog:
>>>> at91sam9_wdt: better watchdog support"), SoCs compatible with
>>>> at91sam9260-wdt not using a device tree no longer reboot if the watchdog
>>>> times out while the CPU is in idle state. Removing the
>>>> AT91_WDT_WDIDLEHLT flag that was set by default fixes this.
>>>>
>>>> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
>>>> Fixes: 5161b31dc39a ("watchdog: at91sam9_wdt: better watchdog support")
>>>> Cc: <stable@vger.kernel.org> # 3.14+
>>>
>>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>>
>>> However, we don't really care about that for kernels after 3.18 as no
>>> users are using pdata anymore.
>>> I think you could send a follow-up patch removing pdata support
>>> completely.
>>
>> Looks like this one falls through the cracks, it didn't reach mainline
>> and therefore wasn't applied to stable branches.
>>
> Possibly that happened because you did not copy the watchdog mailing list.
>

... and your other patches were not sent to the watchdog mailing list either,
so you should not expect them to be picked up either.

Seriously, how do you expect _any_ patch to be picked up if you neither copy
the subsystem mailing list nor the subsystem maintainer ?

Guenter

