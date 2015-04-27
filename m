Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39098 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbbD0Mos (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 08:44:48 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YmiP1-001C9p-Br
	for linux-watchdog@vger.kernel.org; Mon, 27 Apr 2015 12:44:47 +0000
Message-ID: <553E2F1E.5070909@roeck-us.net>
Date: Mon, 27 Apr 2015 05:44:14 -0700
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
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <12253069.Jm7LIDAreu@wuerfel> <553D05DD.8080300@roeck-us.net> <2979294.WseZH0BUZW@wuerfel>
In-Reply-To: <2979294.WseZH0BUZW@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/27/2015 02:18 AM, Arnd Bergmann wrote:
> On Sunday 26 April 2015 08:35:57 Guenter Roeck wrote:
>> On 04/25/2015 01:11 PM, Arnd Bergmann wrote:
>>> On Friday 24 April 2015 12:08:54 Eric Anholt wrote:
>>>> +/*
>>>> + * We can't really power off, but if we do the normal reset scheme, and
>>>> + * indicate to bootcode.bin not to reboot, then most of the chip will be
>>>> + * powered off.
>>>> + */
>>>> +static void bcm2835_power_off(void)
>>>> +{
>>>> +       struct device_node *np =
>>>> +               of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
>>>> +       struct platform_device *pdev = of_find_device_by_node(np);
>>>> +       struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
>>>> +       u32 val;
>>>> +
>>>
>>> Instead of doing the lookup again here, I'd suggest using a static variable
>>> in the driver to store the device pointer for the device used on power_off.
>>>
>>> Make sure that the device remove callback assigns it back to NULL though
>>> and that the function checks for NULL pointer.
>>>
>>
>> Why would that be needed ?
>
> devices can be unbound from drivers through sysfs, or using dynamic DT
> updates. If one does that, the watchdog driver will correctly destroy
> all information it has about the device, so if the power_off function
> still uses that pointer, it will crash.
>
Without calling its remove function ? That sounds odd. Lots of drivers
would break if that was really the case.

Guenter

