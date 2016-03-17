Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from forward.webhostbox.net ([162.251.85.61]:33119 "EHLO
	forward.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324AbcCQNEn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 Mar 2016 09:04:43 -0400
Subject: Re: watchdog: octeon: missing FROZEN hot plug notifier actions
To: rcochran@linutronix.de
References: <20160316205105.GA14847@linutronix.de>
 <56EA21FE.6040009@roeck-us.net> <20160317080820.GA32637@linutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	rt@linutronix.de
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56EAAB5E.10703@roeck-us.net>
Date: Thu, 17 Mar 2016 06:04:30 -0700
MIME-Version: 1.0
In-Reply-To: <20160317080820.GA32637@linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/17/2016 01:08 AM, rcochran@linutronix.de wrote:
> On Wed, Mar 16, 2016 at 08:18:22PM -0700, Guenter Roeck wrote:
>> On 03/16/2016 01:51 PM, rcochran@linutronix.de wrote:
>>>
>>> In drivers/watchdog/octeon-wdt-main.c, the hot plug notifier callback,
>>> octeon_wdt_cpu_callback, does not handle events with CPU_TASKS_FROZEN
>>> set in the action code.
>>>
>>> Is this on purpose?  If so, then why is it done that way?
>>>
>>
>> What do you expect it to do ?
>
> I would expect that the driver handles FROZEN in the same way,
> enabling and disabling the watchdog interrupt on the hot plugged CPU.
> It looks like an oversight that FROZEN actions are ignored, but I
> wanted to be sure.
>
>> My understanding is that CPU_TASKS_FROZEN is related to suspend/resume operations,
>> which are not really common for typical applications using Octeon CPUs. If they now
>> are, it might be worthwhile thinking about adding suspend/resume support to the driver.
>
> Are they merely not common, or is suspend impossible on this machine?
> Even if the use case is uncommon, still the driver should be correct.
>
The default Octeon configuration at least enables CONFIG_PM and CONFIG_PM_SLEEP,
so one can argue that it should be supported. If you submit a patch, would you
be able to test your changes ?

Thanks,
Guenter

