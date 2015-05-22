Return-path: <timur@codeaurora.org>
Message-ID: <555F57B7.3040305@codeaurora.org>
Date: Fri, 22 May 2015 11:22:15 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
 linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
 graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org,
 ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
 wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
 mark.rutland@arm.com
Subject: Re: [PATCH v2 1/7] clocksource: export "arch_timer_get_rate" for
 the other drivers
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-2-git-send-email-fu.wei@linaro.org> <555F3886.9020506@codeaurora.org> <20150522151616.GA3272@roeck-us.net>
In-Reply-To: <20150522151616.GA3272@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/22/2015 10:16 AM, Guenter Roeck wrote:
> Doo bad that SBSA is not hardware independent enough to provide all
> the information needed to implement such a driver:-(.

The SBSA is designed and intended only for ARM Servers.  It has no value 
on non-ARM SOCs and and non-server SOCs.  The SBSA is just a way for 
64-bit ARM Server SOC vendors to re-use some drivers.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
