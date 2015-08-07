Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42798 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945904AbbHGRdt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 13:33:49 -0400
Message-ID: <55C4EBF8.5060004@roeck-us.net>
Date: Fri, 07 Aug 2015 10:33:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	support.opensource@diasemi.com, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] watchdog: da9063: Ping watchdog only during allowed
 time window
References: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>	 <55C4B473.90307@roeck-us.net> <1438967295.3638.41.camel@pengutronix.de>
In-Reply-To: <1438967295.3638.41.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Philipp,

On 08/07/2015 10:08 AM, Philipp Zabel wrote:
> Hi Guenter,
>
> Am Freitag, den 07.08.2015, 06:36 -0700 schrieb Guenter Roeck:
>> On 08/06/2015 09:36 AM, Philipp Zabel wrote:
>>> There is a cooldown period after watchdog timer setup, and also after each
>>> watchdog ping. If a ping is issued too early, the watchdog triggers the
>>> watchdog error condition and causes a system reset.
>>>
>>> The 256 ms period length is a best guess based on the same value being used
>>> for the DA9053 predecessor PMIC and experiments that have shown 200 ms are
>>> not enough to avoid the error.
>>>
>>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> Hi Philipp,
>>
>> instead of using this quite complex approach, would it be possible to use the
>> same approach as the da9062 driver ?
>>
>> I understand the downside, which is that the caller may end up sleeping,
>> but this should not happen too often.
>
> Depending on the userspace this can happen quite a lot ...
>
Your call, ultimately. I don't want to spend time reviewing the changes
as is, given they are quite substantial and will ultimately go away,
so we'll just have to wait for someone else to spend that time.

Thanks,
Guenter

>>   Also, I plan to move the enforcement
>> of a minimal time between heartbeats into the infrastructure, so this would
>> not least forever.
>
> ... but certainly taking care of this in the framework is better than
> doing it in the drivers.
>
> regards
> Philipp
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

