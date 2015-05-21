Return-path: <timur@codeaurora.org>
Message-ID: <555DD8EE.1060607@codeaurora.org>
Date: Thu, 21 May 2015 08:09:02 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, fu.wei@linaro.org,
 Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
 al.stone@linaro.org, hanjun.guo@linaro.org,
 ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
 wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
 mark.rutland@arm.com
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-7-git-send-email-fu.wei@linaro.org> <555DB4C4.5090606@roeck-us.net>
In-Reply-To: <555DB4C4.5090606@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck wrote:
>>
>> +static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +    u64 timeleft = sbsa_gwdt_get_wcv(wdd) - arch_counter_get_cntvct();
>> +
>
> Still not happy about the use of arch_counter_get_cntvct
> instead of using the clock subsystem. I am quite sure this could be done,
> possibly through arch_sys_counter, though at this point I am getting wary
> of bringing it up, so I guess I'll just let it go.

You made the same comment with my driver, and I keep asking for 
clarification.  The clk_get_sys() API does not work on my system, 
because there are not clocks defined.  That must be an ACPI limitation 
that I can't fix.

The alternative to arch_counter_get_cntvct() is 
arch_timer_read_counter(), which is not exported.  So we have two choices,

1) Continue to use arch_counter_get_cntvct(), which works on all ARM64 
platforms that this driver supports anyway

2) Export arch_timer_read_counter()

I prefer option #1.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
