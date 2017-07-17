Return-Path: <garsilva@embeddedor.com>
Return-path: <garsilva@embeddedor.com>
Subject: Re: [PATCH] watchdog: coh901327_wdt: constify watchdog_ops structure
To: Guenter Roeck <linux@roeck-us.net>,
 Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck <wim@iguana.be>
References: <20170708003330.GA15374@embeddedgus>
 <031cf1ab-7f1b-4e4d-adaf-efa6c3af8040@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <72fb7a2e-f075-57b0-72e2-6c16205eaf4e@embeddedor.com>
Date: Sun, 16 Jul 2017 23:03:50 -0500
MIME-Version: 1.0
In-Reply-To: <031cf1ab-7f1b-4e4d-adaf-efa6c3af8040@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 07/07/2017 08:45 PM, Guenter Roeck wrote:
> On 07/07/2017 05:33 PM, Gustavo A. R. Silva wrote:
>> Check for watchdog_ops structures that are only stored in the ops 
>> field of
>> a watchdog_device structure. This field is declared const, so 
>> watchdog_ops
>> structures that have this property can be declared as const also.
>>
>> This issue was detected using Coccinelle and the following semantic 
>> patch:
>>
>> @r
>> disable optional_qualifier@
>> identifier i;
>> position p;
>> @@
>> static struct watchdog_ops i@p = { ... };
>>
>> @ok@
>> identifier r.i;
>> struct watchdog_device e;
>> position p;
>> @@
>> e.ops = &i@p;
>>
>> @bad@
>> position p != {r.p,ok.p};
>> identifier r.i;
>> struct watchdog_ops e;
>> @@
>> e@i@p
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r.i;
>> @@
>> static
>> +const
>>   struct watchdog_ops i = { ... };
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Thank you, Guenter.

>> ---
>>   drivers/watchdog/coh901327_wdt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/coh901327_wdt.c 
>> b/drivers/watchdog/coh901327_wdt.c
>> index 38dd60f0..4410337 100644
>> --- a/drivers/watchdog/coh901327_wdt.c
>> +++ b/drivers/watchdog/coh901327_wdt.c
>> @@ -218,7 +218,7 @@ static const struct watchdog_info coh901327_ident 
>> = {
>>       .identity = DRV_NAME,
>>   };
>>   -static struct watchdog_ops coh901327_ops = {
>> +static const struct watchdog_ops coh901327_ops = {
>>       .owner = THIS_MODULE,
>>       .start = coh901327_start,
>>       .stop = coh901327_stop,
>>
>

-- 
Gustavo A. R. Silva
