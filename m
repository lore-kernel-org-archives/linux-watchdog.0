Return-path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>, Murilo Opsfelder Araujo <mopsfelder@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS dependencies
In-Reply-To: <2c95ae14-06a7-d3c2-aabb-1e164eb6b6e9@roeck-us.net>
References: <20170527012256.6005-1-mopsfelder@gmail.com> <2c95ae14-06a7-d3c2-aabb-1e164eb6b6e9@roeck-us.net>
Date: Mon, 29 May 2017 12:08:16 +1000
Message-ID: <87zidw76un.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck <linux@roeck-us.net> writes:

> On 05/26/2017 06:22 PM, Murilo Opsfelder Araujo wrote:
>> drivers/watchdog/wdrtas.c uses symbols defined in arch/powerpc/kernel/rtas.c,
>> which are exported iff CONFIG_PPC_RTAS is selected. Building wdrtas.c without
>> setting CONFIG_PPC_RTAS throws the following errors:
>> 
>>      ERROR: ".rtas_token" [drivers/watchdog/wdrtas.ko] undefined!
>>      ERROR: "rtas_data_buf" [drivers/watchdog/wdrtas.ko] undefined!
>>      ERROR: "rtas_data_buf_lock" [drivers/watchdog/wdrtas.ko] undefined!
>>      ERROR: ".rtas_get_sensor" [drivers/watchdog/wdrtas.ko] undefined!
>>      ERROR: ".rtas_call" [drivers/watchdog/wdrtas.ko] undefined!
>> 
>> This was identified during a randconfig build where CONFIG_WATCHDOG_RTAS=m and
>> CONFIG_PPC_RTAS was not set. Logs are here:
>> 
>>      http://kisskb.ellerman.id.au/kisskb/buildresult/12982152/
>> 
>> This patch fixes the issue by selecting CONFIG_PPC_RTAS when
>> CONFIG_WATCHDOG_RTAS is set.
>> 
>> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
>> ---
>>   drivers/watchdog/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 8b9049d..5d872145 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1689,6 +1689,7 @@ config MEN_A21_WDT
>>   config WATCHDOG_RTAS
>>   	tristate "RTAS watchdog"
>>   	depends on PPC_RTAS || (PPC64 && COMPILE_TEST)
>> +	select PPC_RTAS
>
> This can not at the same time depend on PPC_RTAS and select it.
> Guess we'll have to drop COMPILE_TEST entirely.

We could stub out the RTAS pieces it needs. But I don't think it buys us
much, for compile testing you may as well just build a config which has
PPC_RTAS enabled, there are several.

So I think it should just depend on PPC_RTAS.

Murilo can you send a v2?

cheers
