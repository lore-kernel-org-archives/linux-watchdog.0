Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56013 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbbEWUof (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 23 May 2015 16:44:35 -0400
Message-ID: <5560E6AE.1000109@roeck-us.net>
Date: Sat, 23 May 2015 13:44:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, Fu Wei <fu.wei@linaro.org>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
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
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555DFCD4.3040701@codeaurora.org> <CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com> <5560D7AC.50009@codeaurora.org> <5560DCB6.3090008@roeck-us.net> <5560E294.6040903@codeaurora.org>
In-Reply-To: <5560E294.6040903@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/23/2015 01:27 PM, Timur Tabi wrote:
> Guenter Roeck wrote:
>>
>> However, the pretimeout concept assumes that there are two timers
>> which can be set independently. As you had pointed out earlier,
>> and as the specification seems to confirm, that is not the case here.
>> As such, I don't really understand why and how the pretimeout / timeout
>> concept would add any value here and not just make things more
>> complicated than necessary. Maybe I am just missing something.
>
> It might be possible to load a new value into the WOR register after the WS0 interrupt occurs.  That is, in the interrupt handler, we can do something like this:
>
>      if (status & SBSA_GWDT_WCS_WS0)
>          // write new WOR value,
>          // then ping watchdog so that it's loaded
>
> I'm not convinced that it's worth it, however.  It would require interrupts to still be working when WS0 times out, which somewhat defeats the purpose of a watchdog.
>

If I understand the specification correctly, reloading the register
would result in another WS0, not in WS1. That isn't really what we
would want to happen.

Reloading the register would normally be done in the crashdump kernel,
if it is loaded, to give it time to actually take the crashdump.
But that is post-restart, not pre-restart.

Thanks,
Guenter

