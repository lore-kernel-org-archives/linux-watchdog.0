Return-path: <timur@codeaurora.org>
Message-ID: <556097D5.9050103@codeaurora.org>
Date: Sat, 23 May 2015 10:08:05 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>
CC: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
 linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
 graeme.gregory@linaro.org, al.stone@linaro.org,
 ashwin.chaugule@linaro.org, linux@roeck-us.net,
 vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
 leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1432197156-16947-7-git-send-email-fu.wei@linaro.org> <555F4236.7040206@linaro.org> <4095167.UOriXdSu53@wuerfel>
In-Reply-To: <4095167.UOriXdSu53@wuerfel>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Arnd Bergmann wrote:
> I think it's a reasonable assumption that someone will sooner or later
> put that hardware into an ARM32 machine,

I'm going to have to disagree.  If they haven't done it by now, I can't 
imagine any ARM SOC vendor creating a 32-bit ARM SOC with an SBSA 
watchdog in it.  I can imagine a vendor trying to repurpose an existing 
32-bit ARM SOC for the server market, but that SOC won't have an SBSA 
watchdog in it.

 > or run a 32-bit kernel on
> a chip that has it.

That might happen, but I would be very surprised, and I would need to be 
convinced that it's useful.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
