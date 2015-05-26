Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43057 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbbEZQfX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 12:35:23 -0400
Message-ID: <5564A0C7.1090306@codeaurora.org>
Date: Tue, 26 May 2015 11:35:19 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Hanjun Guo <hanjun.guo@linaro.org>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, ashwin.chaugule@linaro.org, arnd@arndb.de,
	linux@roeck-us.net, vgandhi@codeaurora.org, wim@iguana.be,
	jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Subject: Re: [PATCH v3 6/6] ACPI: import watchdog info of GTDT into platform
 device
References: <=fu.wei@linaro.org> <1432548193-19569-1-git-send-email-fu.wei@linaro.org> <1432548193-19569-7-git-send-email-fu.wei@linaro.org> <55642EA8.5000003@linaro.org>
In-Reply-To: <55642EA8.5000003@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2015 03:28 AM, Hanjun Guo wrote:

>>       early_acpi_os_unmap_memory((char *)table, tbl_size);
>>   }
>
> please add
>
> #ifdef CONFIG_ARM_SBSA_WATCHDOG
> (acpi gtdt code)
> #endif

I don't agree with this.  The GTDT should be parsed even if there's no 
watchdog driver compiled for this kernel.  There are no other #ifdefs in 
this file.

>> +     * Add a platform device named "sbsa-gwdt" to match the platform
>> driver.
>> +     * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic
>> Watchdog
>> +     * The platform driver can get device info below by matching this
>> name.
>
> * The platform driver (drivers/watchdog/sbsa_gwdt.c) can get device info
> below by matching this name.
>
> Adding the file name which will help for review and maintain in my
> opinion.

Except it will cause problems if the driver is renamed or moved.  I 
don't think this is a good idea, either (sorry!)

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
