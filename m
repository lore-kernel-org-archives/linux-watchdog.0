Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45638 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbbIWN7H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Sep 2015 09:59:07 -0400
Subject: Re: [PATCH] watchdog: iTCO: Fix dependencies on I2C
To: Matt Fleming <matt@codeblueprint.co.uk>
References: <1441978088-27288-1-git-send-email-linux@roeck-us.net>
 <20150923103206.GC2867@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Fleming <matt.fleming@intel.com>,
	Lee Jones <lee.jones@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5602B025.8030109@roeck-us.net>
Date: Wed, 23 Sep 2015 06:59:01 -0700
MIME-Version: 1.0
In-Reply-To: <20150923103206.GC2867@codeblueprint.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/23/2015 03:32 AM, Matt Fleming wrote:
> On Fri, 11 Sep, at 06:28:08AM, Guenter Roeck wrote:
>> If I2C is built as module, the iTCO watchdog driver must be built as module
>> as well. I2C_I801 must only be selected if I2C is configured.
>>
>> This fixes the following build errors, seen if I2C=m and ITCO_WDT=y.
>>
>> i2c-i801.c:(.text+0x2bf055): undefined reference to `i2c_del_adapter'
>> i2c-i801.c:(.text+0x2c13e0): undefined reference to `i2c_add_adapter'
>> i2c-i801.c:(.text+0x2c17bd): undefined reference to `i2c_new_device'
>>
>> Fixes: 2a7a0e9bf7b3 ("watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint")
>> Cc: Matt Fleming <matt.fleming@intel.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/watchdog/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 55c4b5b0a317..75c358ce71a7 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -797,8 +797,9 @@ config ITCO_WDT
>>   	tristate "Intel TCO Timer/Watchdog"
>>   	depends on (X86 || IA64) && PCI
>>   	select WATCHDOG_CORE
>> +	depends on I2C || I2C=n
>>   	select LPC_ICH if !EXPERT
>> -	select I2C_I801 if !EXPERT
>> +	select I2C_I801 if !EXPERT && I2C
>>   	---help---
>>   	  Hardware driver for the intel TCO timer based watchdog devices.
>>   	  These drivers are included in the Intel 82801 I/O Controller
>
> Whoops, thanks for catching this Guenter. Are you going to send this
> to Linus?
>

Wim should do that.

> Reviewed-by: Matt Fleming <matt.fleming@intel.com>
>
Thanks for the review.

Guenter

