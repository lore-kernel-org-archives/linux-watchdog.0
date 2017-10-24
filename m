Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44339 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933055AbdJXN3i (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 24 Oct 2017 09:29:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id j3so14537180pga.1
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Oct 2017 06:29:38 -0700 (PDT)
Subject: Re: [PATCH 3/6] watchdog: da9062: reset board on watchdog timeout
To: Michael Grzeschik <mgr@pengutronix.de>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "wim@iguana.be" <wim@iguana.be>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Stefan Christ <s.christ@phytec.de>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
 <20171017153027.24665-4-m.grzeschik@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB70194131FC4@SW-EX-MBX02.diasemi.com>
 <20171020074351.65vum7hitlvi6ftf@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <33009041-ea58-e0b3-6a54-b699ef116264@roeck-us.net>
Date: Tue, 24 Oct 2017 06:29:36 -0700
MIME-Version: 1.0
In-Reply-To: <20171020074351.65vum7hitlvi6ftf@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/20/2017 12:43 AM, Michael Grzeschik wrote:
> On Wed, Oct 18, 2017 at 02:28:10PM +0000, Steve Twiss wrote:
>> Hi Michael,
>>
>> On 17 October 2017 16:30 Michael Grzeschik wrote:
>>
>>> To: linux-watchdog@vger.kernel.org
>>> Subject: [PATCH 3/6] watchdog: da9062: reset board on watchdog timeout
>>>
>>> From: Stefan Christ <s.christ@phytec.de>
>>>
>>> In the default fuse configuration the watchdog poweroffs the system
>>> instead of resetting it on a watchdog timeout. This patch changes the
>>> behavior. Now the board is reseted and reboots.
>>
>> We call the chip's fuze configuration the "OTP" (one-time programming).
>>
>>>
>>> Note: This patch requires that the config register CONFIG_I is
>>> configured as writable in the da9062 multi function device.
>>>
>>> Signed-off-by: Stefan Christ <s.christ@phytec.de>
>>> Signed-off-by: Christian Hemp <c.hemp@phytec.de>
>>> ---
>>>   drivers/watchdog/da9062_wdt.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/da9062_wdt.c
>>> b/drivers/watchdog/da9062_wdt.c
>>> index 4349a02215489..b95719b349e5c 100644
>>> --- a/drivers/watchdog/da9062_wdt.c
>>> +++ b/drivers/watchdog/da9062_wdt.c
>>> @@ -112,6 +112,20 @@ static int da9062_wdt_start(struct watchdog_device
>>> *wdd)
>>>   	unsigned int selector;
>>>   	int ret;
>>>
>>> +	/*
>>> +	 * Use da9062's SHUTDOWN mode instead of POWERDOWN for watchdog reset.
>>> +	 * On timeout the PMIC should reset the system, not powering it
>>> +	 * off.
>>> +	 */
>>> +	ret = regmap_update_bits(wdt->hw->regmap,
>>> +				 DA9062AA_CONFIG_I,
>>> +				 DA9062AA_WATCHDOG_SD_MASK,
>>> +				 DA9062AA_WATCHDOG_SD_MASK);
>>> +	if (ret)
>>> +		dev_err(wdt->hw->dev,
>>> +			"failed to set wdt reset mode. Expect poweroff on watchdog reset: %d\n",
>>> +			ret);
>>> +
>>
>> I am not quite understanding what you are trying to achieve.
>> It seems there could be be few different options here.
>>
>> If the watchdog is running from power on and if the platform hangs early in the start-up
>> sequence, then waiting to set WATCHDOG_SD in the DA9062 watchdog driver could be
>> too late to modify the chip's behaviour. If the watchdog tripped early, the system might
>> already be in POWERDOWN instead of SHUTDOWN before this point.
> 
> Agreed.
> 
>> If a software change to CONFIG_I is to be done, then this register could be modified very
>> early in the bootloader. If necessary, the Linux kernel driver can read the CONFIG_I register
>> and decide if it needs to modify its behaviour accordingly. In this case, write changes to
>> CONFIG_I would not be needed.
> 
> I will add that condition around it.
> 
>> The trivial option (for software at least) could be a different OTP: to enforce
>> WATCHDOG_SD in the hardware.
> 
> That is one god point. I will have a look into that.
> 
>> DA9062 Datasheet revision 3.4, 27-Jun-2017, page 59, Section 10.
>> A hyperlink to the latest datasheet can be found in the DA9062 binding file:
>> Documentation/devicetree/bindings/mfd/da9062.txt
> 
> On Page 59 of this document are only ordering informations.
> 
>> It doesn't seem correct to make this a permanent change in the general Linux kernel driver.
>> At the very least, something like this sould be protected by a device tree boolean.
> 
> Agreed. I will think adopt your ideas.
> 
Based on this exchange and since the CONFIG_I change is rejected, I'll drop this patch
from my queue for now.

Guenter
