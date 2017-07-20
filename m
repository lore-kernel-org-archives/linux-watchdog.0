Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:53764 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932172AbdGTDWk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Jul 2017 23:22:40 -0400
Subject: Re: [PATCH] watchdog: imx2_wdt: use new_timeout value to override the
 old
To: Guenter Roeck <linux@roeck-us.net>, <wim@iguana.be>
CC: <jinyanjiang@gmail.com>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20170720024533.70081-1-yanjiang.jin@windriver.com>
 <b433d1ff-0d89-fbd9-3e2d-04bd278371fb@roeck-us.net>
From: yjin <yanjiang.jin@windriver.com>
Message-ID: <72fd5906-49f3-9e87-f6a9-2757103e7535@windriver.com>
Date: Thu, 20 Jul 2017 11:22:16 +0800
MIME-Version: 1.0
In-Reply-To: <b433d1ff-0d89-fbd9-3e2d-04bd278371fb@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 2017年07月20日 11:18, Guenter Roeck wrote:
> On 07/19/2017 07:45 PM, yanjiang.jin@windriver.com wrote:
>> From: Yanjiang Jin <yanjiang.jin@windriver.com>
>>
>> Without this patch we couldn't change the timeout value of imx2_wdt.
>>
>> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
>> ---
>>   drivers/watchdog/imx2_wdt.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>> index 4874b0f..6cfeee6 100644
>> --- a/drivers/watchdog/imx2_wdt.c
>> +++ b/drivers/watchdog/imx2_wdt.c
>> @@ -178,6 +178,9 @@ static int imx2_wdt_set_timeout(struct 
>> watchdog_device *wdog,
>>         regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
>>                  WDOG_SEC_TO_COUNT(new_timeout));
>> +
>> +    wdog->timeout = new_timeout;
>> +
>
> I must be missing something. That very same code is already in line 177,
> added with commit 30dd4a8f08b57 ("watchdog: imx2_wdt: also set 
> wdog->timeout
> to new_timeout") back in 2015.
>
> Did you see this in an older kernel, maybe ?

Oh, I missed this. I did use the older kernel to validate it. Thanks for 
your reminder, please ignore my patch.
Thanks again!

Regards!
Yanjiang
>
> Guenter

