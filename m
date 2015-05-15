Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51834 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbbEOQVI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 12:21:08 -0400
Message-ID: <55561CF1.9090308@codeaurora.org>
Date: Fri, 15 May 2015 11:21:05 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH] [v2] watchdog: introduce the ARM64 SBSA
 watchdog driver
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org> <5740260.iFKebBHUuJ@wuerfel> <5555E310.7040009@codeaurora.org> <3313221.o1XjNEFgtv@wuerfel>
In-Reply-To: <3313221.o1XjNEFgtv@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/15/2015 08:20 AM, Arnd Bergmann wrote:

> Do you get a sparse warning if you either leave the __le32, or if you
> turn it into u32?

After removing the cpu_to_le32 calls, but keeping the __le32 in the 
structs, I get no sparse warnings on my driver.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
