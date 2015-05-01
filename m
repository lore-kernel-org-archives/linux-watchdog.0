Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36759 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbEAXdP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 19:33:15 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YoKQk-002tAX-6h
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 23:33:14 +0000
Message-ID: <55440D32.7060300@roeck-us.net>
Date: Fri, 01 May 2015 16:33:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	linaro-acpi@lists.linaro.org
CC: linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH] watchdog: introduce the ARM64 SBSA watchdog
 driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org> <2851853.hEtA2CtVGn@wuerfel> <5543DECA.10006@codeaurora.org> <55440955.6050204@roeck-us.net> <55440AA3.2080707@codeaurora.org>
In-Reply-To: <55440AA3.2080707@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/01/2015 04:22 PM, Timur Tabi wrote:
> Guenter Roeck wrote:
>> Not really, at least not me. However, there is no other caller of
>> arch_timer_get_rate, except for the call setting arch_timer_rate.
>> This suggests that it might not be such a good idea to call
>> arch_timer_get_rate() and arch_timer_read_counter() in the first place.
>
> I don't know of any other way to convert seconds into watchdog ticks.
>
>> [ On a side note, arch_timer_get_rate() can return 0 if ARM_ARCH_TIMER
>>    is not configured. You'll need to check for that. ]
>
> Check the Kconfig for this driver.  It requires ARM_ARCH_TIMER.
>
>> It is hard to imagine that the watchdog would be the only driver which
>> needs this clock. Isn't there some clock API call that can be used
>> instead ?
>
> If there is, I'd love to know it.  There's no 'device' for this driver, so I don't think the clk API will work.
>
Maybe ask on the arm  mailing list ?

Guenter

>> As for acpi_parse_entries, we will need some feedback from the acpi
>> maintainers. If the intent is that this function can be called from
>> drivers, it should be exported.
>
> Agreed.
>

