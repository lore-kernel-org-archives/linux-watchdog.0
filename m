Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33057 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbcENRHj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 13:07:39 -0400
Subject: Re: [PATCH] watchdog: core: Fix circular locking dependency
To: Wim Van Sebroeck <wim@iguana.be>
References: <1461249494-24924-1-git-send-email-linux@roeck-us.net>
 <20160514164119.GE20158@spo001.leaseweb.nl>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57375B5B.8040809@roeck-us.net>
Date: Sat, 14 May 2016 10:07:39 -0700
MIME-Version: 1.0
In-Reply-To: <20160514164119.GE20158@spo001.leaseweb.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On 05/14/2016 09:41 AM, Wim Van Sebroeck wrote:
> Hi Guenter,
>
>> lockdep reports the following circular locking dependency.
>>

You are faster than me this time. I was just about to send you a pull request.
Sorry for being late. The watchdog-next branch in my repository on kernel.org
has all patches in my queue, in case you want to have a look.

I'll rebase my branch to yours and see if anything is missing, then send
you a pull request on top of it if needed.

>
> This patch has been added to linux-watchdog-next.
>

This patch should probably be tagged for v4.6.

Thanks,
Guenter

