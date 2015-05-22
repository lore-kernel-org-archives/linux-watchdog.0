Return-path: <timur@codeaurora.org>
Message-ID: <555F3886.9020506@codeaurora.org>
Date: Fri, 22 May 2015 09:09:10 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
 linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
 al.stone@linaro.org, hanjun.guo@linaro.org,
 ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
 vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
 leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 1/7] clocksource: export "arch_timer_get_rate"
 for the other drivers
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-2-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

fu.wei@linaro.org wrote:
> Some devices get clock from system counter, like SBSA watchdog
> driver. They may need to get system counter rate.

We don't need this patch.  The watchdog driver can use 
arch_timer_get_cntfrq() instead of arch_timer_get_rate().  There's 
nothing wrong with arch_timer_get_cntfrq() since the SBSA driver is 
intended only for ARM64 server systems, and arch_timer_get_cntfrq() is 
always defined for such systems.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
