Return-path: <justinpopo6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56CDCCB1.3050605@roeck-us.net>
References: <20160224161726.4888edd4@endymion>
	<56CDCCB1.3050605@roeck-us.net>
Date: Wed, 24 Feb 2016 09:08:35 -0800
Message-ID: <CAJx26kWgGmtgPrNXc7M96j0-FWsmTutJm4RoVZN32SStmYwYwg@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: Add hardware dependency to BCM7038 driver
From: Justin Chen <justinpopo6@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Feb 24, 2016 at 7:30 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/24/2016 07:17 AM, Jean Delvare wrote:
>>
>> The BCM7038 watchdog driver is specific to Broadcom ARM and MIPS
>> SoCs so do not present it on other architectures, unless
>> build-testing.
>>
>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Justin Chen <justinpopo6@gmail.com>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Chen <justinpopo6@gmail.com>
>
>
>> ---
>> Changes since v1:
>>   * Better dependencies, suggested by Justin, and updated the
>>     description accordingly.
>>   * Better option description, provided by Justin.
>>
>>   drivers/watchdog/Kconfig |    8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> --- linux-4.5-rc5.orig/drivers/watchdog/Kconfig 2016-02-24
>> 14:43:18.943460233 +0100
>> +++ linux-4.5-rc5/drivers/watchdog/Kconfig      2016-02-24
>> 15:42:49.756057691 +0100
>> @@ -1377,10 +1377,12 @@ config BCM7038_WDT
>>         tristate "BCM7038 Watchdog"
>>         select WATCHDOG_CORE
>>         depends on HAS_IOMEM
>> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>>         help
>> -        Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
>> -
>> -        Say 'Y or 'M' here to enable the driver.
>> +        Watchdog driver for the built-in hardware in Broadcom 7038 and
>> +        later SoCs used in set-top boxes.  BCM7038 was made public
>> +        during the 2004 CES, and since then, many Broadcom chips use this
>> +        watchdog block, including some cable modem chips.
>>
>>   config IMGPDC_WDT
>>         tristate "Imagination Technologies PDC Watchdog Timer"
>>
>
