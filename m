Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:47816 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbcCCCbF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2016 21:31:05 -0500
Subject: Re: [RFC PATCH] watchdog: s3c2410_wdt: Add max and min timeout values
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1456850717-3670-1-git-send-email-javier@osg.samsung.com>
 <56D62979.5040009@samsung.com> <56D7233B.50907@osg.samsung.com>
 <56D7838D.4060602@samsung.com> <56D79E1D.3030302@osg.samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56D7A1DF.9030805@samsung.com>
Date: Thu, 03 Mar 2016 11:30:55 +0900
MIME-version: 1.0
In-reply-to: <56D79E1D.3030302@osg.samsung.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03.03.2016 11:14, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 03/02/2016 09:21 PM, Krzysztof Kozlowski wrote:
>> On 03.03.2016 02:30, Javier Martinez Canillas wrote:
> 
> [snip]
> 
>>>>>
>>>>> +    wdt->wdt_device.min_timeout = 1;
>>>>> +    wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt->clock);
>>>>
>>>> Can the frequency of clock change? E.g. with devfreq? No problem if it
>>>> goes lower but if it gets higher than initial, then the problem will
>>>> appear again.
>>>>
> 
> I think both cases are problematic since low scaling will meant that the
> watchdog will support a bigger timeout than what was set as maximum (this
> will be a regression) and going up will mean that the maximum timeout is
> bigger than what the watchdog supports (the same issue without this patch).

Yes, both cases are bad.

>> The problem will be more severe if the watchdog got configured on 50 MHz
>> and then devfreq bumps the clock to 100 MHz...
>>
> 
> So, what do you propose? We could for example set a maximum timeout on
> probe
> as $SUBJECT do and also update the maximum timeout again on the
> .set_timeout
> callback in case the clock rate changed. 

Or print warning and don't care... :)

> I think that is kind of hacky
> but I
> can't think of another way to guard about the frequency being changed.

First of all your patch does not introduce any kind of regression on its
own. Since we are at the topic of watchdog I am just looking for doing
this properly. We can merge the patches now and fix stuff later.

Second, I think there won't be any issues with current mainline code
(and devfreq). I don't care about out of tree code.

Third, it would be good to confirm that watchdog clock really changes
frequency with devfreq...

BR,
KRzysztof

