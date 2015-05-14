Return-path: <timur@codeaurora.org>
Message-ID: <5555347D.7050106@codeaurora.org>
Date: Thu, 14 May 2015 18:49:17 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>, Wim Van Sebroeck <wim@iguana.be>,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org> <3074350.inBBIzlShL@wuerfel> <5555027B.6010701@codeaurora.org> <20150514204505.GA10374@roeck-us.net> <55550D8E.6000408@codeaurora.org> <55553291.3050009@roeck-us.net>
In-Reply-To: <55553291.3050009@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck wrote:
>
> We still don't know if the registers are in host byte order or in little
> endian
> order. If registers are in host byte order, there is no need for a
> conversion.

Well, if I compile and boot a big-endian ARM64 kernel, then I don't 
expect the hardware devices to magically switch all their registers into 
big endian.  The devices will remain little-endian.

I presume that this is true on all ARM and ARM64 systems.  Switching the 
CPU into big-endian mode (when it normally would run in little-endian) 
does not also switch the hardware registers.

Therefore, if we want to support big-endian kernels on ARM64, then every 
readl/writel in every driver must use cpu_to_le32/etc.

I think this conversation has gone off-track.  I don't see how the SBSA 
watchdog device is any different from any other device on an ARM64 platform.

I think it's safe to say that the endian order is not specified 
anywhere, but on my hardware, everything is little-endian.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
