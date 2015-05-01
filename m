Return-path: <timur@codeaurora.org>
Message-ID: <5543DECA.10006@codeaurora.org>
Date: Fri, 01 May 2015 15:15:06 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org
CC: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>,
 Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH] watchdog: introduce the ARM64 SBSA watchdog
 driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org> <2851853.hEtA2CtVGn@wuerfel>
In-Reply-To: <2851853.hEtA2CtVGn@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/01/2015 02:19 PM, Arnd Bergmann wrote:
> That should be fixed, we want normal drivers to be loadable modules.

The driver references three functions that are not exported:

ERROR: "acpi_parse_entries" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
ERROR: "arch_timer_get_rate" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
ERROR: "arch_timer_read_counter" [drivers/watchdog/arm_sbsa_wdt.ko] 
undefined!

I know what you're going to say.  You want me to move the ACPI platform 
code into some ACPI platform file, maybe /arch/arm64/kernel/acpi.c.  My 
concern is that there is currently no code for ACPI timers, so I don't 
have much of a starting point.  I'd hate to have to define support for 
all of ACPI timers just to get my driver merged.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
