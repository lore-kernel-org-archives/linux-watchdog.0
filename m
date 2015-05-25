Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33782 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbEYELT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 May 2015 00:11:19 -0400
Received: by obbnx5 with SMTP id nx5so46953886obb.0
        for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2015 21:11:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55629B15.2060102@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DB4C4.5090606@roeck-us.net>
	<555DD8EE.1060607@codeaurora.org>
	<20150521152838.GB16668@roeck-us.net>
	<CADyBb7tH+oa_efFTA0V7YksNN+8L+4xGtWuXpxp91SO3e_f9Vg@mail.gmail.com>
	<55629B15.2060102@codeaurora.org>
Date: Mon, 25 May 2015 12:11:19 +0800
Message-ID: <CADyBb7tRXi2ub9xQqEq2TNokxYMnRbgTAq5S+mpUh9W1iXfvWQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur.


On 25 May 2015 at 11:46, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> Once the Linux kernel has KVM support and is in hyp mode. we
>> may need to use arch_counter_get_cntpct.
>
>
> arch_counter_get_cntpct() does not appear to be valid for ARM64:
>
> http://lxr.free-electrons.com/source/arch/arm64/include/asm/arch_timer.h#L108

Great thank for correction, that make sense.

>
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, hosted by The Linux Foundation.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
