Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32812 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbcFCVMx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Jun 2016 17:12:53 -0400
Date: Fri, 3 Jun 2016 17:12:44 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/4] gpio: Allow PC/104 devices on X86_64
Message-ID: <20160603211244.GA6831@sophia>
References: <cover.1464029828.git.vilhelm.gray@gmail.com>
 <d7320150373a0a04ba44b12c5c56d92370853316.1464029828.git.vilhelm.gray@gmail.com>
 <20160603205703.GC11253@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160603205703.GC11253@amd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jun 03, 2016 at 10:57:03PM +0200, Pavel Machek wrote:
>Hi!
>
>> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
>> drivers may be built for X86_64 architectures. This patch changes the
>> ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API, thus
>> allowing them to build for X86_64 as they are expected to.
>> 
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> ---
>>  drivers/gpio/Kconfig | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 48da857..dc6da77 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -530,7 +530,7 @@ menu "Port-mapped I/O GPIO drivers"
>>  
>>  config GPIO_104_DIO_48E
>>  	tristate "ACCES 104-DIO-48E GPIO support"
>> -	depends on ISA
>> +	depends on ISA_BUS_API
>>  	select GPIOLIB_IRQCHIP
>>  	help
>>  	  Enables GPIO support for the ACCES 104-DIO-48E series
>
>Should we do "depends on PC104" here, because that is what it really
>means, and have PC104 enabled when ISA_BUS_API is enabled or something
>like that?

Since the functionality remains the same, I'm a bit indifferent to that
change; as long as the driver builds for systems in which it's intended
to be used, I'm satisfied.

Differentiating between PC/104 and ISA may be a pointless endeavor
though since both buses appear the same to software. But if it is better
to differentiate between devices as such, then I see little harm in
adding a PC104 Kconfig option which follows the ISA_BUS_API Kconfig
option.

William Breathitt Gray
