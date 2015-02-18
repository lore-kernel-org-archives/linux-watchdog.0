Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:38485 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751103AbbBRNvL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 08:51:11 -0500
Message-ID: <54E498CB.8010100@offcode.fi>
Date: Wed, 18 Feb 2015 15:51:07 +0200
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Boris Brezillon <boris.brezillon@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCHv3 0/2] watchdog: Introduce "early-timeout-sec" property
References: <54B53160.6060309@roeck-us.net>	<cover.1424262664.git.timo.kokkonen@offcode.fi> <20150218141655.0445958d@bbrezillon>
In-Reply-To: <20150218141655.0445958d@bbrezillon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Boris,

Thanks for your comments. I will resend tomorrow!

-Timo

On 18.02.2015 15:16, Boris Brezillon wrote:
> Hi Timo,
>
> Could you send new versions of this in their own thread (not in reply
> to previous versions), and increment the version in patch 1 and 2 ?
>
> Could you also summarize what has changed between each versions in this
> cover letter ?
>
> Best Regards,
>
> Boris
>
> On Wed, 18 Feb 2015 14:57:20 +0200
> Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
>
>> Currently we have no means to adjust the watchdog behavior on early
>> start up before user space has opened the device. The generic behavior
>> among the watchdog drivers is to not start the watchdog at all (or
>> disable it, if possible, or in case at91sam9_wdt, start a kernel timer
>> that keeps on pinging the watchdog on behalf of user space until a
>> watchdog daemon opens it). This unfortunately opens a time window
>> between starting the driver and starting the user space watchdog
>> daemon where a crash of the kernel or user space might prevent the
>> watchdog from ever resetting the device at all. This is obviously bad
>> on production systems.
>>
>> Introduce a new device tree property that, when set, changes the
>> watchdog driver behavior in such way that there no longer is any
>> window where crash is not caught by the watchdog.
>>
>> This is the third version of this patch. Previous versions of the
>> patch were using an atmel specific property name. This patch uses a
>> generic name instead as the functionality itself has nothing atmel
>> related. I am also introducing watchdog.txt for describing the generic
>> watchdog device tree bindings as there was no such file before.
>>
>> Timo Kokkonen (2):
>>    devicetree: Document generic watchdog properties
>>    at91sam9_wdt: Allow watchdog to reset device at early boot
>>
>>   .../devicetree/bindings/watchdog/watchdog.txt         | 19 +++++++++++++++++++
>>   drivers/watchdog/at91sam9_wdt.c                       |  9 ++++++++-
>>   2 files changed, 27 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.txt
>>
>
>
>

