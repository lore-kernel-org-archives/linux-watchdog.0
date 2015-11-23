Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54874 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbbKWPrG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 10:47:06 -0500
Subject: Re: [PATCH v2] watchdog: add Alphascale asm9260-wdt driver
To: Oleksij Rempel <linux@rempel-privat.de>,
	Rob Herring <robh@kernel.org>
References: <20151027023132.GA1270@roeck-us.net>
 <1446714416-22587-1-git-send-email-linux@rempel-privat.de>
 <1446714416-22587-2-git-send-email-linux@rempel-privat.de>
 <20151105204301.GA15806@rob-hp-laptop> <5652BC30.7060803@rempel-privat.de>
 <5652BFA5.9010101@roeck-us.net> <5652E1A7.2090108@rempel-privat.de>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	devicetree@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565334F5.7020803@roeck-us.net>
Date: Mon, 23 Nov 2015 07:47:01 -0800
MIME-Version: 1.0
In-Reply-To: <5652E1A7.2090108@rempel-privat.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/23/2015 01:51 AM, Oleksij Rempel wrote:

>>>>
>>>> Seems like this should be a generic wdog property.
>>>>
>>>
>>> what do you mean?
>>> Using "mode" instead of "alphascale,mode" and implement it in WD
>>> framework?
>>>
>>
>> You should still read the property in the driver, even it if is made
>> generic.
>> The watchdog framework can't really use the information, most drivers don't
>> support selecting the mode. We can consider moving it into the framework
>> if/when it benefits other drivers.
>>
>> On a side note, I would suggest "software" and "hardware" instead of sw
>> / hw,
>> but that is just a personal preference.
>
> Ok, then i will leave it for now as is. If "mode" will be introduced, it
> can brake compatibility. Using "alphascale,mode" feels save :)
>
Not sure I understand. Using a generic property name doesn't mean anything
about its implementation. Devicetree properties are supposed to be OS and
implementation independent, no ?

Guenter

