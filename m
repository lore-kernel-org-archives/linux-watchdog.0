Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57687 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbbAKBOE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 10 Jan 2015 20:14:04 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YA76R-004AS3-SD
	for linux-watchdog@vger.kernel.org; Sun, 11 Jan 2015 01:14:04 +0000
Message-ID: <54B1CE58.4040407@roeck-us.net>
Date: Sat, 10 Jan 2015 17:14:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 3/8] watchdog: at91rm9200: use the regmap from mfd
References: <1420797094-9444-1-git-send-email-alexandre.belloni@free-electrons.com> <1420797094-9444-4-git-send-email-alexandre.belloni@free-electrons.com> <54B074B9.2090704@roeck-us.net> <20150110184146.GH2447@piout.net>
In-Reply-To: <20150110184146.GH2447@piout.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/10/2015 10:41 AM, Alexandre Belloni wrote:
> On 09/01/2015 at 16:39:21 -0800, Guenter Roeck wrote :
>> On 01/09/2015 01:51 AM, Alexandre Belloni wrote:
>>>   /* ......................................................................... */
>>> @@ -204,6 +201,7 @@ static struct miscdevice at91wdt_miscdev = {
>>>   static int at91wdt_probe(struct platform_device *pdev)
>>>   {
>>>   	int res;
>>> +	regmap_st = dev_get_drvdata(pdev->dev.parent);
>>>
>>
>> Is it guaranteed that parent is never NULL, and that the parent's
>> drvdata is always set ?
>>
>
> The only way to probe the driver left is to use platform_data. It is
> done from the MFD driver. If you prefer, I can test for NULL here and
> return.
>

I am fine if you are sure about that. The problem though is still the
check for double instantiation. Either the driver can not be instantiated
multiple times, and the check is no longer necessary, or it can, meaning
there must be some other means to instantiate it besides through the
mfd driver. And in that case you don't necessarily know if platform_data
is set.

>> Also, it seems that regmap_st will be overwritten if the device
>> is already open (see code below). That may not be a good idea.
>>
>
> I'm not sure what you meani, pdev->dev.parent and at91wdt_miscdev.parent
> are not the same thing. I didn't touch the code below but I believe
> there is no reason to pass in the probe twice and return -EBUSY.
>

Not sure I understand what my comment has to do with 'parent'.

The fact that the code checks if it has already been instantiated
suggests that the original author of the driver was concerned about
that case. Since you did not remove that check I have to assume that
this can still happen. If so, the second instantiation attempt will
overwrite regmap_st, since that variable is written prior to checking
for the dual instantiation.

Guenter

