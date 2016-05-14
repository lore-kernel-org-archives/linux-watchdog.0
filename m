Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52177 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbcENRYY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 13:24:24 -0400
Subject: Re: [PATCH] watchdog: core: Fix circular locking dependency
To: Wim Van Sebroeck <wim@iguana.be>
References: <1461249494-24924-1-git-send-email-linux@roeck-us.net>
 <20160514164119.GE20158@spo001.leaseweb.nl> <57375B5B.8040809@roeck-us.net>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57375F49.2020300@roeck-us.net>
Date: Sat, 14 May 2016 10:24:25 -0700
MIME-Version: 1.0
In-Reply-To: <57375B5B.8040809@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/14/2016 10:07 AM, Guenter Roeck wrote:
> Hi Wim,
>
> On 05/14/2016 09:41 AM, Wim Van Sebroeck wrote:
>> Hi Guenter,
>>
>>> lockdep reports the following circular locking dependency.
>>>
>
> You are faster than me this time. I was just about to send you a pull request.
> Sorry for being late. The watchdog-next branch in my repository on kernel.org
> has all patches in my queue, in case you want to have a look.
>
> I'll rebase my branch to yours and see if anything is missing, then send
> you a pull request on top of it if needed.
>

All there. Looks like you picked it up right after I updated the branch
this morning.

>>
>> This patch has been added to linux-watchdog-next.
>>
>
> This patch should probably be tagged for v4.6.
>
Turns out it has a Fixes: tag, so an additional tag should not be necessary.

Thanks,
Guenter

