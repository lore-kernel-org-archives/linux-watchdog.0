Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33015 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760794AbbKTQv7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 11:51:59 -0500
Subject: Re: [PATCH] watchdog: mtk_wdt: Use MODE_KEY when stopping the
 watchdog
To: Guenter Roeck <linux@roeck-us.net>,
	Nicolas Boichat <drinkcat@chromium.org>
References: <1447814701-23504-1-git-send-email-drinkcat@chromium.org>
 <564CA620.7080700@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <564F4FAB.8000703@gmail.com>
Date: Fri, 20 Nov 2015 17:51:55 +0100
MIME-Version: 1.0
In-Reply-To: <564CA620.7080700@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 18/11/15 17:24, Guenter Roeck wrote:
> On 11/17/2015 06:45 PM, Nicolas Boichat wrote:
>> WDT_MODE value need to be or-ed with MODE_KEY when setting
>> watchdog mode. Add it to mtk_wdt_stop function, so that the
>> watchdog can be stopped (e.g. during suspend).
>>
>> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

>
>> ---
>>   drivers/watchdog/mtk_wdt.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
>> index 6ad9df9..b751f43 100644
>> --- a/drivers/watchdog/mtk_wdt.c
>> +++ b/drivers/watchdog/mtk_wdt.c
>> @@ -123,6 +123,7 @@ static int mtk_wdt_stop(struct watchdog_device
>> *wdt_dev)
>>
>>       reg = readl(wdt_base + WDT_MODE);
>>       reg &= ~WDT_MODE_EN;
>> +    reg |= WDT_MODE_KEY;
>>       iowrite32(reg, wdt_base + WDT_MODE);
>>
>>       return 0;
>>
>
