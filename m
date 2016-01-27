Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36939 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbcA0FCu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Jan 2016 00:02:50 -0500
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
References: <20160125190942.GA6824@sophia>
 <20160125192810.2487661b@lxorguk.ukuu.org.uk> <56A6889E.60208@roeck-us.net>
 <56A6B198.2080205@gmail.com> <56A6CB48.4010402@roeck-us.net>
 <56A80391.40009@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A84F75.3050805@roeck-us.net>
Date: Tue, 26 Jan 2016 21:02:45 -0800
MIME-Version: 1.0
In-Reply-To: <56A80391.40009@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/26/2016 03:38 PM, William Breathitt Gray wrote:
> On 01/25/2016 08:26 PM, Guenter Roeck wrote:
>>> The manual for this motherboard does not provide much information about
>>> the Super I/O chip (no model number, etc.), and neither sensors-detect
>>> nor superiotool was able to detect it. I've sent an email to the
>>> motherboard company (WinSystems) requesting further information about
>>> the Super I/O chip and whether the watchdog timer is built-in to the
>>> Super I/O chip.
>>>
>>
>> Ah, I somehow thought you were associated with WinSystems, since you know
>> how to configure the chip.
>>
>> Did you get any useful output from sensors-detect or superiotool
>> (like 'unknown chip xxxx'), or did those tools find nothing ?
>
> Unfortunately, the sensors-detect only reported "No" for each Super I/O
> chip test, while the superiotool gave an unhelpful "No Super I/O chip
> detected" message.
>

Too bad. That suggests that the watchdog may in fact be implemented in the fpga.

> I haven't heard a response yet from WinSystems, but I'll give them a
> couple days before sending another email to their engineering
> department. For now, I'll submit a version 4 of this patch to get the
> minor updates I made out for review; for what its worth, I believe the
> dmi_match method will be sufficient until I get an update from
> WinSystems helping me get a proper check to identify the Super I/O chip.
>

I added v4 to my watchdog-next branch and will include it in my pull request
to Wim later in the release cycle. If there are enhancements (eg if WinSystems
comes back with an actual specification), we can implement those as incremental
improvements.

Thanks,
Guenter

