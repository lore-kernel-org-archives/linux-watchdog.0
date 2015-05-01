Return-path: <timur@codeaurora.org>
Message-ID: <5543BAE7.5040909@codeaurora.org>
Date: Fri, 01 May 2015 12:41:59 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>,
 Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>,
 linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org> <5543B7D0.706@codeaurora.org> <20150501173209.GA7712@roeck-us.net>
In-Reply-To: <20150501173209.GA7712@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/01/2015 12:32 PM, Guenter Roeck wrote:
> devm_ioremap_resource already prints a message. For this reason, elsewhere in the
> kernel the check for !res before calling devm_ioremap_resource is being removed,
> leaving the error handling to devm_ioremap_resource. I would suggest to do the
> same here.

I see what you're saying, but I leave the error handling to 
devm_ioremap_resource(), then no one will know whether it's because the 
control address or the refresh address is missing.  The user will just 
see "invalid resource" and won't what resource is actually invalid.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
