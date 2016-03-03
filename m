Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34265 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbcCCM01 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 07:26:27 -0500
MIME-Version: 1.0
In-Reply-To: <56D82643.1090105@osg.samsung.com>
References: <1456850717-3670-1-git-send-email-javier@osg.samsung.com>
	<56D62979.5040009@samsung.com>
	<56D7233B.50907@osg.samsung.com>
	<56D7838D.4060602@samsung.com>
	<56D79E1D.3030302@osg.samsung.com>
	<56D7C2A5.1050304@roeck-us.net>
	<56D82643.1090105@osg.samsung.com>
Date: Thu, 3 Mar 2016 21:26:26 +0900
Message-ID: <CAJKOXPe2GAkMGgZJR3FCRONMgb3AcrySczuzm_BehekrMnEbrw@mail.gmail.com>
Subject: Re: [RFC PATCH] watchdog: s3c2410_wdt: Add max and min timeout values
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	Kukjin Kim <kgene@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2016-03-03 20:55 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> Hello Guenter,
>
>
> On 03/03/2016 01:50 AM, Guenter Roeck wrote:
>> A watchdog driver using a non-static clock must register a clock change
>> notifier
>> to handle the clock rate change and update its settings accordingly.
>>
>> I would also argue that the maximum timeout should be set to the minimum
>> possible value (probably associated with the highest possible frequency).
>> All other cases might end up causing trouble if a clock frequency
>> chance results in an enforced timeout change, since there is currently
>> no mechanism to inform user space about such a change.
>>
>> Example: maximum possible timeout changes from 1 minute to 30 seconds.
>> The timeout was set to 1 minute, and has to be reduced to 30 seconds.
>> Very likely result is that the watchdog will reset the system because
>> user space still believes that the timeout is 60 seconds and doesn't
>> ping the watchdog often enough to prevent it.
>>
>
> Agreed.
>
> In any case this discussion is not related to this patch since currently
> in mainline the watchdog source clock is fixed and does not change.
>
> So, $SUBJECT solves the issue of not having the fixed .{min,max}_timeout
> defined to allow the watchdog_timeout_invalid() function to check values
> set by WDIOC_SETTIMEOUT and avoid calling the .set_timeout callback.
>
> If later someone tries to scale a parent clock used by many drivers, then
> the submitter should make sure that no regressions are added by the patch.

Sounds good. For this patch then:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
