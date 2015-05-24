Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55441 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbbEXOGt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 24 May 2015 10:06:49 -0400
Message-ID: <5561DAF3.8020805@roeck-us.net>
Date: Sun, 24 May 2015 07:06:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>
CC: Timur Tabi <timur@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555F4236.7040206@linaro.org>	<4095167.UOriXdSu53@wuerfel>	<556097D5.9050103@codeaurora.org>	<CADyBb7svbV6QdhzCsa9DiBLfyNpAJHkgm73VSKCieJioPwWHsw@mail.gmail.com>	<5560C85B.8040100@roeck-us.net>	<5560C8D3.40708@codeaurora.org>	<5560DA3F.3070707@roeck-us.net> <CADyBb7sW8GTJmRR2ysUAYtZ=mkSCFZBzXuor=puLck0Q983NMw@mail.gmail.com>
In-Reply-To: <CADyBb7sW8GTJmRR2ysUAYtZ=mkSCFZBzXuor=puLck0Q983NMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/24/2015 02:58 AM, Fu Wei wrote:
> Hi Guenter,
>
> Great thanks for your suggestion and review,
> I have some questions below , would you please help me out?
>
> On 24 May 2015 at 03:51, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 05/23/2015 11:37 AM, Timur Tabi wrote:
>>>
>>> Guenter Roeck wrote:
>>>>
>>>> I think it is quite unfortunate that the specification is not public.
>>>> We have heard many statements about what is in the spec or not.
>>>
>>>
>>> All you need to do is go to
>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0029b/index.html,
>>> get a free ARM account, and download the spec.
>>>
>> That helps - thanks a lot!
>>
>> Folks, please correct me if my understanding of the specification
>> is wrong.
>>
>> 1) Pretimeout
>>
>> The document suggests that
>>          WS1 = WS0 * 2
>
> Are you saying: the first timeout == the second timeout
>
> |-------------WS0
>                    |-------------WS1
>
> Sorry, could you let me know where is that suggestion??
> I have checked the SBSA again, but I can not find it.
> Maybe I really miss this part.
>

The document states:

"If both watchdog signals are deasserted and a timeout refresh occurs then WS0 is asserted.
  If WS0 is asserted and a timeout refresh occurs then WS1 is asserted."

There is no mention that programming both WOR and WCV would or even
could result in different timeouts for the two watchdog signals.

>> is in fact correct. In essence, there is just one counter,
>> not two. This means that a separate pretimeout does not really
>> make sense, since in practice the timeout would always be
>> twice the pretimeout,
>
> Yes, you are right, if we only use "WOR", then the first timeout ==
> the second timeout
>
>> and changing just one without affecting
>> the other is not really possible.
>
> although there is only one counter, and it is 32 bits wide.
> In SBSA,  we can see this:
> -------
> Note: the watchdog offset register is 32 bits wide. This gives a
> maximum watch period of around 10s at a system counter frequency of
> 400MHz.
> If a larger watch period is required then the compare value can be
> programmed directly into the compare value register.
> -------
> So for the first timeout, we can set the compare value register(WCV).
> Then the two timeouts are different. and the first timeout has not
> 10s(@400MHz) limit.
> just the the second timeout must use "WOR".
>

That is not how I read the specification. It only talks about
"timeout refresh". There is no indication that using both registers
would have the impact you describe.

Since there is no mention of different WS0 and WS1 timeout periods
in the specification, I am concerned that even _if_ a specific
implementation supports such different timeouts, it would be
implementation specific.

Maybe you and/or Timur can test this on the real systems you
have access to. It should be quite straightforward to test -
have the interrupt handler only print a message, program some
values into the watchdog, and see when WS0 and WS1 occur.

Thanks,
Guenter

