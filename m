Return-path: <timur@codeaurora.org>
Message-ID: <55573785.5040405@codeaurora.org>
Date: Sat, 16 May 2015 07:26:45 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>, Arnd Bergmann <arnd@arndb.de>
CC: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 tekkamanninja@gmail.com, graeme.gregory@linaro.org,
 al.stone@linaro.org, hanjun.guo@linaro.org,
 ashwin.chaugule@linaro.org, linux@roeck-us.net,
 vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
 leo.duran@amd.com, corbet@lwn.net
Subject: Re: [PATCH 5/6] Watchdog: introdouce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1431689090-3125-1-git-send-email-fu.wei@linaro.org> <1431689090-3125-2-git-send-email-fu.wei@linaro.org> <2621121.Z4lZCvqDlK@wuerfel> <555731B1.3070805@linaro.org>
In-Reply-To: <555731B1.3070805@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Fu Wei wrote:

> yes. you are right. According to SBSA doc, the clocksource of SBSA watchdog is System Counter.
> And System Counter is in (arm_)arch_timer. So I think we should do
>
> 	depends on ARM_ARCH_TIMER
>
> and use the relevant interface :
>
> 	clk = arch_timer_get_rate();
>
> will improve it, thanks for your suggestion!

If you use arch_timer_get_rate(), then you will not be able to compile 
the driver as a module.

The clock API doesn't work for me, either, because no clocks are defined 
(clk_get_sys() always fails).

That's why I use arch_timer_get_cntfrq().

>> I would probably drop the various pr_debug() calls here. Once the driver
>> works fine, they are normally not that useful any more.
>
> yes, for this drive, if it works fine, we can drop it, but I keep these info for some reason:
> (1)they can help engineer debug GTDT table or DTS, if the info of watchdog goes wrong.

Any engineer will add his own printks when debugging.  You don't need to 
do that job for someone else.  You just have too many pr_debug() statements.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
