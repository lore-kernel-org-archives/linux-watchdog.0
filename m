Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44718 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbbE0DIT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 23:08:19 -0400
Message-ID: <5565351E.6050708@codeaurora.org>
Date: Tue, 26 May 2015 22:08:14 -0500
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
Subject: Re: [PATCH v3 6/6] ACPI: import watchdog info of GTDT into
 platform device
References: <=fu.wei@linaro.org> <1432548193-19569-1-git-send-email-fu.wei@linaro.org> <1432548193-19569-7-git-send-email-fu.wei@linaro.org> <55642EA8.5000003@linaro.org> <5564A0C7.1090306@codeaurora.org> <5565336D.6040904@linaro.org>
In-Reply-To: <5565336D.6040904@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hanjun Guo wrote:
>> I don't agree with this.  The GTDT should be parsed even if there's no
>> watchdog driver compiled for this kernel.  There are no other #ifdefs in
>> this file.
>
> So what's the point of parse GTDT and alloc memories for it if there
> is no watchdog driver compiled for the kernel?

I don't think it's normal policy to generate a platform only if one 
specific driver is enabled.

 > will the module insmod
> later even if the CONFIG_ARM_SBSA_WATCHDOG=n?

I think that actually can work, but it's not a good reason by itself.

> OK, that's good point. but what I proposed is some hint to which driver
> will use the data prepared in this file, we can easily understand it
> in this patchset, but if just review the code in this fiel, I think
> people will be confused without detail comments.

All anyone needs to is

	git grep "sbsa-gwdt"

And you'll find the driver.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
