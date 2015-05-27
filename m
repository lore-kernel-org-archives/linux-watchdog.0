Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36394 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbbE0DBK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 23:01:10 -0400
Received: by pdfh10 with SMTP id h10so105301370pdf.3
        for <linux-watchdog@vger.kernel.org>; Tue, 26 May 2015 20:01:09 -0700 (PDT)
Message-ID: <5565336D.6040904@linaro.org>
Date: Wed, 27 May 2015 11:01:01 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, fu.wei@linaro.org,
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
References: <=fu.wei@linaro.org> <1432548193-19569-1-git-send-email-fu.wei@linaro.org> <1432548193-19569-7-git-send-email-fu.wei@linaro.org> <55642EA8.5000003@linaro.org> <5564A0C7.1090306@codeaurora.org>
In-Reply-To: <5564A0C7.1090306@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2015年05月27日 00:35, Timur Tabi wrote:
> On 05/26/2015 03:28 AM, Hanjun Guo wrote:
>
>>>       early_acpi_os_unmap_memory((char *)table, tbl_size);
>>>   }
>>
>> please add
>>
>> #ifdef CONFIG_ARM_SBSA_WATCHDOG
>> (acpi gtdt code)
>> #endif
>
> I don't agree with this.  The GTDT should be parsed even if there's no
> watchdog driver compiled for this kernel.  There are no other #ifdefs in
> this file.

So what's the point of parse GTDT and alloc memories for it if there
is no watchdog driver compiled for the kernel? will the module insmod
later even if the CONFIG_ARM_SBSA_WATCHDOG=n?

>
>>> +     * Add a platform device named "sbsa-gwdt" to match the platform
>>> driver.
>>> +     * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic
>>> Watchdog
>>> +     * The platform driver can get device info below by matching this
>>> name.
>>
>> * The platform driver (drivers/watchdog/sbsa_gwdt.c) can get device info
>> below by matching this name.
>>
>> Adding the file name which will help for review and maintain in my
>> opinion.
>
> Except it will cause problems if the driver is renamed or moved.  I
> don't think this is a good idea, either (sorry!)

OK, that's good point. but what I proposed is some hint to which driver
will use the data prepared in this file, we can easily understand it
in this patchset, but if just review the code in this fiel, I think
people will be confused without detail comments.

Thanks
Hanjun
