Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37383 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbcAZB0f (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jan 2016 20:26:35 -0500
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
References: <20160125190942.GA6824@sophia>
 <20160125192810.2487661b@lxorguk.ukuu.org.uk> <56A6889E.60208@roeck-us.net>
 <56A6B198.2080205@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A6CB48.4010402@roeck-us.net>
Date: Mon, 25 Jan 2016 17:26:32 -0800
MIME-Version: 1.0
In-Reply-To: <56A6B198.2080205@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/25/2016 03:36 PM, William Breathitt Gray wrote:
> On 01/25/2016 03:42 PM, Guenter Roeck wrote:
>> On 01/25/2016 11:28 AM, One Thousand Gnomes wrote:
>>> If ask for 299 seconds surely I should get 300 not 240 ?
>>> (Whether to round off or round up is an interesting question for the
>>> middle range - does it go off early or late - I'd have said late but...)
>>>
>>
>> Matter of endless discussion. Some argue that the value should be rounded
>> up, some argue that it should be rounded down, some argue that it should
>> be rounded to the closest match. Each camp has its own valid arguments.
>> I usually leave it up to the driver's author to decide, with a slight
>> preference to never select a value larger than requested.
>
> I implemented it to round down simply because it was the simplest
> solution (i.e. integer truncation). Although I see merit in an
> implementation that rounds to the closest valid value, I'll keep the
> current implementation for now due to its simplicity; if enough users of
> the driver prefer a different implementation, then I'll add it in a
> later patch.
>
>>> Is there no ACPI entry for it ?
>>>
>> Same here. As long as the board is identified, I tend to leave it up
>> to the driver author to decide _how_ to identify it.
>>
>> Only question for me would be if the watchdog timer is implemented
>> in a Super-IO chip, and if so, if it would be possible to use the chip
>> identification instead of a DMI (or ACPI) entry to instantiate the driver.
>
> I do not believe there is an ACPI entry for it. Interestingly, the
> watchdog timer BIOS configuration option for this motherboard is listed
> under the Super I/O menu; perhaps this watchdog timer is implemented in
> the Super I/O chip.
>
Normally it is. Question is which one.

> The manual for this motherboard does not provide much information about
> the Super I/O chip (no model number, etc.), and neither sensors-detect
> nor superiotool was able to detect it. I've sent an email to the
> motherboard company (WinSystems) requesting further information about
> the Super I/O chip and whether the watchdog timer is built-in to the
> Super I/O chip.
>

Ah, I somehow thought you were associated with WinSystems, since you know
how to configure the chip.

Did you get any useful output from sensors-detect or superiotool
(like 'unknown chip xxxx'), or did those tools find nothing ?

Thanks,
Guenter

