Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47425 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbEXQ6K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 24 May 2015 12:58:10 -0400
Message-ID: <5562031D.3040808@roeck-us.net>
Date: Sun, 24 May 2015 09:58:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>
CC: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555DFCD4.3040701@codeaurora.org>	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>	<5560D7AC.50009@codeaurora.org>	<5560DCB6.3090008@roeck-us.net>	<CADyBb7t7+aT=pF0we5umAGXJAJ0njU0zULFAZ-OHVpE0m=ueyg@mail.gmail.com>	<5561DD0B.1040008@roeck-us.net>	<CADyBb7t6YoauM6T==E8MmHDvE0R9B4n09cEQH3AKkQvOW1RiJw@mail.gmail.com>	<5561FAFF.1050602@roeck-us.net> <CADyBb7vAwXNFH50tFQUxoqWKx7VBLzo5xd7takBgdVYpJ_0d8g@mail.gmail.com>
In-Reply-To: <CADyBb7vAwXNFH50tFQUxoqWKx7VBLzo5xd7takBgdVYpJ_0d8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/24/2015 09:47 AM, Fu Wei wrote:
> Hi Guenter,
>
> On 25 May 2015 at 00:23, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 05/24/2015 08:50 AM, Fu Wei wrote:
>> [ ...]
>>
>>> Actually, I have added my thought at the head of sbsa_gwdt.c as a comment
>>> :
>>>
>>>     *
>>>    * Note: This SBSA Generic watchdog driver is compatible with
>>>    *       the pretimeout concept of Linux kernel.
>>>    *       The timeout and pretimeout are set by the different REGs.
>>>    *       The first watch period is set by writing WCV directly,
>>>    *       that can support more than 10s timeout at the maximum
>>>    *       system counter frequency.
>>>    *       The second watch period is set by WOR(32bit) which will be
>>> loaded
>>>    *       automatically by hardware, when WS0 is triggered.
>>>    *       This gives a maximum watch period of around 10s at the maximum
>>>    *       system counter frequency.
>>>    *       The System Counter shall run at maximum of 400MHz.
>>>    *       More details: DEN0029B - Server Base System Architecture (SBSA)
>>>    *
>>>    * Kernel/API:                         P---------| pretimeout
>>>    *               |-------------------------------T timeout
>>>    * SBSA GWDT:                          P--WOR---WS1 pretimeout
>>>    *               |-------WCV----------WS0~~~~~~~~T timeout
>>>    */
>>>
>>
>> Yes, but do we actually _know_ that it works that way, ie that WCV
>> drives WS0 and that WOR drives WS1 ? Unless I am missing something,
>> the specification doesn't say that, and it would have been a really
>> easy statement to make if that was the intent.
>
> yes, Suravee has tested it on Seattle B0 Soc, that works.
> But hope Suravee can provide more info about test, I will ping him later.
>
> According to SBSA,  that WCV  and WOR can both drive WS1 and WS0
>
> the timeout and pretimeout in my patchset have been tested on Seattle
> B0 and  Foundation model.
>
>>
>> My concern here is that the above behavior is not spelled out in
>> the document, meaning it is up to interpretation by the hardware
>> engineer implementing it, to the point where it appears that not
>> even two software engineers can agree how it is supposed to work.
>> Which is a really bad starting point :-(.
>
> Is that a real hardware teat can prove it works?
>
> or actually, SBSA say that it should work:
> -----------------
> Note: the watchdog offset register is 32 bits wide. This gives a
> maximum watch period of around 10s at a system
> counter frequency of 400MHz. If a larger watch period is required then
> the compare value can be programmed
> directly into the compare value register.
> -----------------
> offset register == WOR
> compare value register == WCV
>

Where does it say that WCV shall be associated with WS0 and that WOR
shall be associated with WS1 ? Guess I am missing that part.

Thanks,
Guenter

