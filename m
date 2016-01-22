Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50636 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbcAVPlP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jan 2016 10:41:15 -0500
Subject: Re: [PATCH v2] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
To: Mason <slash.tmp@free.fr>
References: <56A0EABB.3090901@free.fr> <20160121204255.GA10214@roeck-us.net>
 <yw1xoacdn9wh.fsf@unicorn.mansr.com> <56A239D4.5050708@roeck-us.net>
 <56A241ED.1000201@free.fr>
Cc: Mans Rullgard <mans@mansr.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A24D98.8080407@roeck-us.net>
Date: Fri, 22 Jan 2016 07:41:12 -0800
MIME-Version: 1.0
In-Reply-To: <56A241ED.1000201@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/22/2016 06:51 AM, Mason wrote:
> On 22/01/2016 15:16, Guenter Roeck wrote:
>
>> On 01/22/2016 03:14 AM, Måns Rullgård wrote:
>>
>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>
>>>> On Thu, Jan 21, 2016 at 03:27:07PM +0100, Mason wrote:
>>>>> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>>>>
>>>>> This change was requested by arm-soc maintainer Kevin Hilman
>>>>> because the X in TANGOX is a wildcard.
>>>>
>>>> Not what I was looking for, but not worth arguing about it, so
>>>
>>> It would be better if the commit message simply mentioned the fact that
>>> the platform support uses ARCH_TANGO and this has to match.  The details
>>> of why it got named that way are less important.
>>>
>> Agreed. That is why I had asked to move that information after the "---".
>> But as I said, this is not worth an endless argument.
>
> As long as the patch makes it into v4.5, I don't mind a different
> commit message. You can reword as you wish.
>

Wim is the maintainer. If anything, he would have to do the rewording.

I would like you to keep one thing in mind, though, for your future patches.
Maintainers tend to be busy. It helps to make life easy for them.

Thanks,
Guenter

