Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45611 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbbD0N3O (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 09:29:14 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1Ymj61-001fu7-4y
	for linux-watchdog@vger.kernel.org; Mon, 27 Apr 2015 13:29:13 +0000
Message-ID: <553E398E.7060305@roeck-us.net>
Date: Mon, 27 Apr 2015 06:28:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-arm-kernel@lists.infradead.org,
	Eric Anholt <eric@anholt.net>, linux-watchdog@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling
 to the WDT driver.
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <2979294.WseZH0BUZW@wuerfel> <553E2F1E.5070909@roeck-us.net> <2465337.STuvDNQht6@wuerfel>
In-Reply-To: <2465337.STuvDNQht6@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/27/2015 05:48 AM, Arnd Bergmann wrote:
> On Monday 27 April 2015 05:44:14 Guenter Roeck wrote:
>> On 04/27/2015 02:18 AM, Arnd Bergmann wrote:
>>> On Sunday 26 April 2015 08:35:57 Guenter Roeck wrote:
>>>> On 04/25/2015 01:11 PM, Arnd Bergmann wrote:
>>>>> On Friday 24 April 2015 12:08:54 Eric Anholt wrote:
>>>>>> +/*
>>>>>> + * We can't really power off, but if we do the normal reset scheme, and
>>>>>> + * indicate to bootcode.bin not to reboot, then most of the chip will be
>>>>>> + * powered off.
>>>>>> + */
>>>>>> +static void bcm2835_power_off(void)
>>>>>> +{
>>>>>> +       struct device_node *np =
>>>>>> +               of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
>>>>>> +       struct platform_device *pdev = of_find_device_by_node(np);
>>>>>> +       struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
>>>>>> +       u32 val;
>>>>>> +
>>>>>
>>>>> Instead of doing the lookup again here, I'd suggest using a static variable
>>>>> in the driver to store the device pointer for the device used on power_off.
>>>>>
>>>>> Make sure that the device remove callback assigns it back to NULL though
>>>>> and that the function checks for NULL pointer.
>>>>>
>>>>
>>>> Why would that be needed ?
>>>
>>> devices can be unbound from drivers through sysfs, or using dynamic DT
>>> updates. If one does that, the watchdog driver will correctly destroy
>>> all information it has about the device, so if the power_off function
>>> still uses that pointer, it will crash.
>>>
>> Without calling its remove function ? That sounds odd. Lots of drivers
>> would break if that was really the case.
>
> I'm not sure what you mean now. The remove function gets called to
> do the final cleanup, and afterwards the device is deleted, so the
> remove function should make sure that no global variables point to
> the device any more.
>
> This is not a concern for most other drivers, because they do not
> keep global pointers to device structures.
>

The pointer to the power-off handler is removed in the device remove callback,
and thus won't be called after the device is unbound.

Ultimately this is similar the the current code, which assumes that the
call to of_find_device_by_node(np) never fails.

Guenter

