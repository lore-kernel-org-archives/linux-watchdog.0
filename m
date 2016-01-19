Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60127 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbcASNSJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jan 2016 08:18:09 -0500
Subject: Re: [PATCH] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
To: Mason <slash.tmp@free.fr>, Wim Van Sebroeck <wim@iguana.be>
References: <569D421C.30504@free.fr> <569D4ACF.6020701@roeck-us.net>
 <569E10D8.2000509@free.fr>
Cc: Mans Rullgard <mans@mansr.com>, linux-watchdog@vger.kernel.org,
	Michael Turquette <mturquette@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <569E378E.2080703@roeck-us.net>
Date: Tue, 19 Jan 2016 05:18:06 -0800
MIME-Version: 1.0
In-Reply-To: <569E10D8.2000509@free.fr>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/19/2016 02:32 AM, Mason wrote:
> On 18/01/2016 21:27, Guenter Roeck wrote:
>
>> On 01/18/2016 11:50 AM, Mason wrote:
>>
>>> Requested by arm-soc maintainer Kevin Hilman in v9 review.
>>> http://article.gmane.org/gmane.linux.ports.arm.kernel/456331
>>
>> The reference should be after the '---' (it doesn't explain
>> the changes, but provides a reference to the change request),
>> and the explanation should be what you have after '---' below,
>> ie that the architecture is tango, that the 'x' is a wildcard,
>> and that it therefore makes more sense to use ARCH_TANGO
>> instead of ARCH_TANGOX.
>
> Hello Guenter,
>
> Thanks for the review.
>
> For the commit message, I am just following Michael's advice:
> (one of the clk maintainers)
>
> "Just a single line explaining that the change was requested by the
> arm-soc devs in the commit log is helpful. I typically reference these
> discussions in the commit log with a link"
>

I'd have expected that as a comment, not in the commit log.

Michael, is that something new ? It isn't really obvious in the drivers/clk
logs and appears to be quite unusual.

Guenter

> Note, I submitted the same patch to clk.
> http://article.gmane.org/gmane.linux.kernel.clk/3164
>
> I'd rather have the same commit message for all these trivial fixups.
>
>>> Can this fix be pushed into 4.5 ?
>>
>> Depends. Is the definition of ARCH_TANGO going to make it in ?
>
> Indeed.
>
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/mach-tango/Kconfig
>
> Regards.
>
>

