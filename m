Return-path: <timur@codeaurora.org>
Message-ID: <5560E294.6040903@codeaurora.org>
Date: Sat, 23 May 2015 15:27:00 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Fu Wei <fu.wei@linaro.org>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Wei Fu <tekkamanninja@gmail.com>, G Gregory
 <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org, wim@iguana.be,
 Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
 Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555DFCD4.3040701@codeaurora.org> <CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com> <5560D7AC.50009@codeaurora.org> <5560DCB6.3090008@roeck-us.net>
In-Reply-To: <5560DCB6.3090008@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck wrote:
>
> However, the pretimeout concept assumes that there are two timers
> which can be set independently. As you had pointed out earlier,
> and as the specification seems to confirm, that is not the case here.
> As such, I don't really understand why and how the pretimeout / timeout
> concept would add any value here and not just make things more
> complicated than necessary. Maybe I am just missing something.

It might be possible to load a new value into the WOR register after the 
WS0 interrupt occurs.  That is, in the interrupt handler, we can do 
something like this:

	if (status & SBSA_GWDT_WCS_WS0)
		// write new WOR value,
		// then ping watchdog so that it's loaded

I'm not convinced that it's worth it, however.  It would require 
interrupts to still be working when WS0 times out, which somewhat 
defeats the purpose of a watchdog.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
