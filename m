Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39196 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbETNqN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 20 May 2015 09:46:13 -0400
Message-ID: <555C9020.6060908@roeck-us.net>
Date: Wed, 20 May 2015 06:46:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv8 01/10] watchdog: Rename watchdog_active to watchdog_hw_active
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi> <1432023969-20736-2-git-send-email-timo.kokkonen@offcode.fi> <555BDF22.2090208@roeck-us.net> <555C1D9F.4060600@offcode.fi>
In-Reply-To: <555C1D9F.4060600@offcode.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/19/2015 10:37 PM, Timo Kokkonen wrote:
> On 20.05.2015 04:10, Guenter Roeck wrote:
>> On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
>>> Before extending the watchdog core midlayer, it is useful to rename
>>> the watchdog_active function so that it states explicitly what it
>>> really does. That is, "active" watchdog means really that the watchdog
>>> hardware is running and needs pinging to prevent a watchdog reset
>>> taking place in near future.
>>>
>>> This is different to "watchdog open" state, which simply states that
>>> kernel is expecting the user space to keep the watchdog alive. These
>>> states might become different mainly because some hardware have
>>> limitations that prevent them from being stopped at will.
>>>
>>
>> I don't see why this is needed. If you need another state, per your
>> description, it would be "open" in addition to "active".
>
> Yes, the watchdog_is_open() is introduced on patch number two. The original watchdog_is_active() is really confusing. It doesn't really state what it means. Most of the drivers are using it to test whether the watchdog HW is active when going to suspend, but at least atmel watchdog was testing it to see whether the watchdog device is open from user space. The HW itself is always active in that driver.
>
> If we are about to distinguish between "device open from user space" and "hardware timer running", we better be clear about the naming. "watchdog_is_active" doesn't really tell what it does.
>
> This was originally suggested by Uwe Kleine-König. He also recommended changing the timeout parameter so that is would state more clearly that it is the SW timeout and not HW timeout. But I felt that it would have been too invasive to change the timeout parameter as well. The watchdog_is_active was not used very much so the change was easy.
>
> -Timo
>
You could just clarify what it means.

Anyway, I think I'll have to step back from this for a while.
As I mentioned, I think it is getting too invasive, which clouds
my judgment. I think I'll leave this patch set up to Wim to handle.

Guenter

