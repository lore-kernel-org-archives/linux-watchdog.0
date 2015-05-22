Return-path: <timur@codeaurora.org>
Message-ID: <555F56BD.90305@codeaurora.org>
Date: Fri, 22 May 2015 11:18:05 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>
CC: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
 linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
 graeme.gregory@linaro.org, al.stone@linaro.org,
 ashwin.chaugule@linaro.org, linux@roeck-us.net, vgandhi@codeaurora.org,
 wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
 mark.rutland@arm.com
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1432197156-16947-7-git-send-email-fu.wei@linaro.org> <555F4236.7040206@linaro.org> <4095167.UOriXdSu53@wuerfel>
In-Reply-To: <4095167.UOriXdSu53@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/22/2015 09:55 AM, Arnd Bergmann wrote:

> While SBSA requires this watchdog device, nothing prevents SoC
> manufacturers from using the same design in something that is not
> a server.

The first "S" in SBSA stands for "Server".  I don't think it makes sense 
to put an SBSA watchdog device in a non-server SOC.

Frankly, I don't understand why people want to make this driver work on 
hardware that doesn't exist.  The SBSA is intended for 64-bit ARM 
Servers that use ACPI.  Yes, there are a couple of ARM64 servers that 
use device tree, but those are legacy platforms.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
