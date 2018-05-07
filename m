Return-Path: <john@phrozen.org>
Return-path: <john@phrozen.org>
Subject: Re: [PATCH] watchdog: ath79: fix maximum timeout
To: Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
References: <20180507131642.11440-1-john@phrozen.org>
 <319719c3-eeec-c75f-68c1-b6d15cf884c5@roeck-us.net>
From: John Crispin <john@phrozen.org>
Message-ID: <3c24c84f-baa1-2eef-4b5c-85d0e5803e7b@phrozen.org>
Date: Mon, 7 May 2018 15:40:57 +0200
MIME-Version: 1.0
In-Reply-To: <319719c3-eeec-c75f-68c1-b6d15cf884c5@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-watchdog@vger.kernel.org>



On 07/05/18 15:34, Guenter Roeck wrote:
> On 05/07/2018 06:16 AM, John Crispin wrote:
>> If the userland tries to set a timeout higher than the max_timeout,
>> then we should fallback to max_timeout.
>>
>
> We don't do that for drivers using the watchdog core, so we should not
> do it here either for consistency.
>
> Guenter

Hi,
thanks for the quick feedback. I'll mark the patch as "rejected by 
upstream due to subsystem consistency" inside OpenWrt.
     John
>
>> Signed-off-by: John Crispin <john@phrozen.org> > ---
>>   drivers/watchdog/ath79_wdt.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
>> index e2209bf5fa8a..c2fc6c3d0092 100644
>> --- a/drivers/watchdog/ath79_wdt.c
>> +++ b/drivers/watchdog/ath79_wdt.c
>> @@ -115,10 +115,14 @@ static inline void ath79_wdt_disable(void)
>>     static int ath79_wdt_set_timeout(int val)
>>   {
>> -    if (val < 1 || val > max_timeout)
>> +    if (val < 1)
>>           return -EINVAL;
>>   -    timeout = val;
>> +    if (val > max_timeout)
>> +        timeout = max_timeout;
>> +    else
>> +        timeout = val;
>> +
>>       ath79_wdt_keepalive();
>>         return 0;
>>
>
>
