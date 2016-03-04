Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46882 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbcCDFcH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Mar 2016 00:32:07 -0500
Subject: Re: [RFC PATCH] watchdog: s3c2410_wdt: Add max and min timeout values
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>
References: <1456850717-3670-1-git-send-email-javier@osg.samsung.com>
 <56D62979.5040009@samsung.com> <56D7233B.50907@osg.samsung.com>
 <56D7838D.4060602@samsung.com> <56D79E1D.3030302@osg.samsung.com>
 <56D7C2A5.1050304@roeck-us.net> <56D82643.1090105@osg.samsung.com>
 <CAJKOXPe2GAkMGgZJR3FCRONMgb3AcrySczuzm_BehekrMnEbrw@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D91DD3.9010604@roeck-us.net>
Date: Thu, 3 Mar 2016 21:32:03 -0800
MIME-Version: 1.0
In-Reply-To: <CAJKOXPe2GAkMGgZJR3FCRONMgb3AcrySczuzm_BehekrMnEbrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/03/2016 04:26 AM, Krzysztof Kozlowski wrote:
> 2016-03-03 20:55 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>> Hello Guenter,
>>
>>
>> On 03/03/2016 01:50 AM, Guenter Roeck wrote:
>>> A watchdog driver using a non-static clock must register a clock change
>>> notifier
>>> to handle the clock rate change and update its settings accordingly.
>>>
>>> I would also argue that the maximum timeout should be set to the minimum
>>> possible value (probably associated with the highest possible frequency).
>>> All other cases might end up causing trouble if a clock frequency
>>> chance results in an enforced timeout change, since there is currently
>>> no mechanism to inform user space about such a change.
>>>
>>> Example: maximum possible timeout changes from 1 minute to 30 seconds.
>>> The timeout was set to 1 minute, and has to be reduced to 30 seconds.
>>> Very likely result is that the watchdog will reset the system because
>>> user space still believes that the timeout is 60 seconds and doesn't
>>> ping the watchdog often enough to prevent it.
>>>
>>
>> Agreed.
>>
>> In any case this discussion is not related to this patch since currently
>> in mainline the watchdog source clock is fixed and does not change.
>>
>> So, $SUBJECT solves the issue of not having the fixed .{min,max}_timeout
>> defined to allow the watchdog_timeout_invalid() function to check values
>> set by WDIOC_SETTIMEOUT and avoid calling the .set_timeout callback.
>>
>> If later someone tries to scale a parent clock used by many drivers, then
>> the submitter should make sure that no regressions are added by the patch.
>
> Sounds good. For this patch then:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Agreed.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

>
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

