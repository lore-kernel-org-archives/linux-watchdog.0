Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58816 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbcJJOSA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Oct 2016 10:18:00 -0400
Subject: Re: [PATCH] watchdog: it87_wdt: add IT8782_ID
To: Liu Qishuai <lqs@lqs.me>
References: <d9c1af52-1817-d356-0aeb-a5d7a1093fd9@lqs.me>
 <bb6ad10b-85f4-7d3c-8c22-ba3731480ac5@roeck-us.net>
 <22e78325-e0ca-f323-9150-7b180a12a328@lqs.me>
 <20161009151132.GA12710@roeck-us.net>
 <c0b13a11-a4f3-f948-925b-5212999504a4@lqs.me>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4ffd1155-2a41-c78a-6293-c79853e9e483@roeck-us.net>
Date: Mon, 10 Oct 2016 07:17:53 -0700
MIME-Version: 1.0
In-Reply-To: <c0b13a11-a4f3-f948-925b-5212999504a4@lqs.me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/10/2016 03:39 AM, Liu Qishuai wrote:
> The specification says the default value of WDT Timeout Enable bit is 0 (enable);
> maybe it's better to ensure the bit is set to 0 in case it was set to other values
> before Linux boots.
>

We have two options: Either clear the bit, or assume that it was disabled on purpose
because the HW does not support it and refuse to load the driver in that case.
I would suggest to clear the bit.

Thanks,
Guenter

>
> On 16/10/9 23:11, Guenter Roeck wrote:
>> On Sun, Oct 09, 2016 at 09:03:12PM +0800, Liu Qishuai wrote:
>>> Updated patch to disabled CIR probing on IT878x chips. (IT8783 has this issue too)
>>>
>>> Signed-off-by: Liu Qishuai <lqs@lqs.me>
>>>
>>
>> Looks better. One question - on IT8782, bit 7 of the control register (LDN 7,
>> 0x71) is defined as "WDT Timeout Enable(WTE)". Setting the bit to 1 disables
>> the timeout.
>>
>> Does this bit have to be cleared to 0 for the watchdog to work ?
>>
>> Thanks,
>> Guenter
>>
>>>
>>> diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
>>> index e54839b..a911cae 100644
>>> --- a/drivers/watchdog/it87_wdt.c
>>> +++ b/drivers/watchdog/it87_wdt.c
>>> @@ -13,7 +13,7 @@
>>>   *
>>>   *	Support of the watchdog timers, which are available on
>>>   *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
>>> - *	IT8728 and IT8783.
>>> + *	IT8728, IT8782 and IT8783.
>>>   *
>>>   *	This program is free software; you can redistribute it and/or
>>>   *	modify it under the terms of the GNU General Public License
>>> @@ -87,6 +87,7 @@
>>>  #define IT8721_ID	0x8721
>>>  #define IT8726_ID	0x8726	/* the data sheet suggest wrongly 0x8716 */
>>>  #define IT8728_ID	0x8728
>>> +#define IT8782_ID	0x8782
>>>  #define IT8783_ID	0x8783
>>>
>>>  /* GPIO Configuration Registers LDN=0x07 */
>>> @@ -606,6 +607,7 @@ static int __init it87_wdt_init(void)
>>>  {
>>>  	int rc = 0;
>>>  	int try_gameport = !nogameport;
>>> +	int try_cir = !nocir;
>>>  	u8  chip_rev;
>>>  	int gp_rreq_fail = 0;
>>>
>>> @@ -634,9 +636,14 @@ static int __init it87_wdt_init(void)
>>>  	case IT8720_ID:
>>>  	case IT8721_ID:
>>>  	case IT8728_ID:
>>> +		max_units = 65535;
>>> +		try_gameport = 0;
>>> +		break;
>>> +	case IT8782_ID:
>>>  	case IT8783_ID:
>>>  		max_units = 65535;
>>>  		try_gameport = 0;
>>> +		try_cir = 0;
>>>  		break;
>>>  	case IT8705_ID:
>>>  		pr_err("Unsupported Chip found, Chip %04x Revision %02x\n",
>>> @@ -676,7 +683,7 @@ static int __init it87_wdt_init(void)
>>>  	}
>>>
>>>  	/* If we haven't Gameport support, try to get CIR support */
>>> -	if (!nocir && !test_bit(WDTS_USE_GP, &wdt_status)) {
>>> +	if (try_cir && !test_bit(WDTS_USE_GP, &wdt_status)) {
>>>  		if (!request_region(CIR_BASE, 8, WATCHDOG_NAME)) {
>>>  			if (gp_rreq_fail)
>>>  				pr_err("I/O Address 0x%04x and 0x%04x already in use\n",
>

