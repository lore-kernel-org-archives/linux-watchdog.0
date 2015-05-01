Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36601 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbEAXbQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 19:31:16 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YoKOp-002s7k-JZ
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 23:31:15 +0000
Message-ID: <55440CBD.6000504@roeck-us.net>
Date: Fri, 01 May 2015 16:31:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	linaro-acpi@lists.linaro.org
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Vipul Gandhi <vgandhi@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH] watchdog: introduce the ARM64 SBSA watchdog
 driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <20150501174953.GB7712@roeck-us.net> <5543C921.9050800@codeaurora.org> <28676294.hhciQCjd9F@wuerfel> <5543DA53.8070702@codeaurora.org>
In-Reply-To: <5543DA53.8070702@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/01/2015 12:56 PM, Timur Tabi wrote:
> On 05/01/2015 02:24 PM, Arnd Bergmann wrote:
>> No, that is not a reasonable assumption to make. All the ARM64 server
>> systems we have today are using DT only and we will of course keep
>> supporting systems like that.
>
> This is what drives me crazy about Linux kernel development.  I've been doing this for 15 years, and I still get random emails that contradict everything I've been told to date.
>
> I was repeatedly told over the past year by multiple people that ARM64 server == ACPI, no ifs, ands, or buts.
>

I don't think anyone ever claimed that Linux development is free
of politics. Except for master politicians, of course.

>> This means we need a DT binding for the driver, and the ACPI portion
>> that creates the platform device should be split out from the main
>> driver.
>
> Well, someone who actually has a DT-based ARM64 server system (which is not me) should come up with such a definition.
>
> I'm hoping that my driver can be accepted without DT support, and that someone else who is interested in running my driver on an SBSA device tree platform can add what's missing.
>
I am perfectly fine with that. All I am asking for is flexibility on your part.

Even if you (and/or others) may personally believe that ACPI _is_ the
center of the universe, please be open to the possibility that others
may have a different opinion and/or different requirements. We should not
have to completely rewrite the driver to add devicetree support later on.

Note we still have to figure out how to instantiate the device based on
the acpi data. I have no idea how that should be done, but it seems
odd if it is really supposed to be done as you have implemented it.
Maybe that is the case, but if so I would like to get a confirmation
from an acpi maintainer.

Thanks,
Guenter

