Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47564 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993307AbcBTASl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Feb 2016 19:18:41 -0500
Subject: Re: [PATCH v2] watchdog: ni9x3x_wdt: Add NI 903x/913x watchdog driver
To: Kyle Roeschley <kyle.roeschley@ni.com>
References: <1455837991-9704-1-git-send-email-kyle.roeschley@ni.com>
 <56C6A7A9.7090105@roeck-us.net> <20160219171222.GA2072@senary>
Cc: david.madden@ni.com, joshc@ni.com, linux-watchdog@vger.kernel.org,
	wim@iguana.be
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56C7B0DE.7070605@roeck-us.net>
Date: Fri, 19 Feb 2016 16:18:38 -0800
MIME-Version: 1.0
In-Reply-To: <20160219171222.GA2072@senary>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/19/2016 09:12 AM, Kyle Roeschley wrote:
> On Thu, Feb 18, 2016 at 09:27:05PM -0800, Guenter Roeck wrote:
>> On 02/18/2016 03:26 PM, Kyle Roeschley wrote:
>>> Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
>>> time controllers.
>>>
>>> Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
>>> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
>>> ---
>>
>> This would be an optimal place for a change log.
>>
>> [ if any of my comments are duplicates, sorry, but a change log
>>    would help avoiding that ]
>>
>
> Sorry about that, I'll make sure to do so in the future.
>
>>>   Documentation/watchdog/watchdog-parameters.txt |   5 +
>>>   drivers/watchdog/Kconfig                       |  11 +
>>>   drivers/watchdog/Makefile                      |   1 +
>>>   drivers/watchdog/ni9x3x_wdt.c                  | 274 +++++++++++++++++++++++++
>>
>> The name and context make me wonder: Is this driver going to support
>> all watchdog devices for NI9[0-9]3[0-9] ?
>>
>> If not, it may be better to select one supported device,
>> whatever that may be, for the name, and describe in Kconfig
>> and the documentation which devices the driver is known to support.
>>
>
> All of the 9[2-9]3[0-9] devices but the 963x do not and cannot run Linux,
> so they won't be a problem. There is already a driver for the 963x watchdog in
> our tree which is currently third in line for upstreaming, so that should be
> fine as well. That would lead me to think 9x3x is fine, but if not then 903x is
> fine.
>

Please use 903x, if you don't mind. After all, 9x3x _does_ include 963x
and is thus misleading.

Thanks,
Guenter

