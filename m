Return-path: <timur@codeaurora.org>
Message-ID: <5543DA53.8070702@codeaurora.org>
Date: Fri, 01 May 2015 14:56:03 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org
CC: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Wim Van Sebroeck <wim@iguana.be>,
 Vipul Gandhi <vgandhi@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH] watchdog: introduce the ARM64 SBSA watchdog
 driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <20150501174953.GB7712@roeck-us.net> <5543C921.9050800@codeaurora.org> <28676294.hhciQCjd9F@wuerfel>
In-Reply-To: <28676294.hhciQCjd9F@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/01/2015 02:24 PM, Arnd Bergmann wrote:
> No, that is not a reasonable assumption to make. All the ARM64 server
> systems we have today are using DT only and we will of course keep
> supporting systems like that.

This is what drives me crazy about Linux kernel development.  I've been 
doing this for 15 years, and I still get random emails that contradict 
everything I've been told to date.

I was repeatedly told over the past year by multiple people that ARM64 
server == ACPI, no ifs, ands, or buts.

> This means we need a DT binding for the driver, and the ACPI portion
> that creates the platform device should be split out from the main
> driver.

Well, someone who actually has a DT-based ARM64 server system (which is 
not me) should come up with such a definition.

I'm hoping that my driver can be accepted without DT support, and that 
someone else who is interested in running my driver on an SBSA device 
tree platform can add what's missing.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
