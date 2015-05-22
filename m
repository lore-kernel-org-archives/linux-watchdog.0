Return-path: <timur@codeaurora.org>
Message-ID: <555F56FB.4030906@codeaurora.org>
Date: Fri, 22 May 2015 11:19:07 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>
CC: Hanjun Guo <hanjun.guo@linaro.org>, fu.wei@linaro.org,
 Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 tekkamanninja@gmail.com, graeme.gregory@linaro.org, al.stone@linaro.org,
 ashwin.chaugule@linaro.org, vgandhi@codeaurora.org, wim@iguana.be,
 jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1432197156-16947-7-git-send-email-fu.wei@linaro.org> <555F4236.7040206@linaro.org> <4095167.UOriXdSu53@wuerfel> <20150522150145.GA2930@roeck-us.net>
In-Reply-To: <20150522150145.GA2930@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/22/2015 10:01 AM, Guenter Roeck wrote:
>> >
> Tricky, though. Since teh driver uses arm specific clock functions,
> I don't think this can compile on a non-arm machine.

Any it doesn't need to.  This driver is for 64-bit ARM Server SOCs. 
There will never be any other kind of SOC that has an SBSA watchdog 
device in it.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
