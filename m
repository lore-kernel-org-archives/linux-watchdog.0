Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34850 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbcHRHsY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Aug 2016 03:48:24 -0400
Received: by mail-oi0-f52.google.com with SMTP id 4so13358108oih.2
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Aug 2016 00:48:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57B4B47E.5030100@codeaurora.org>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com> <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
 <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
 <20160811105848.GA25680@red-moon> <57B4B47E.5030100@codeaurora.org>
From: Fu Wei <fu.wei@linaro.org>
Date: Thu, 18 Aug 2016 15:48:23 +0800
Message-ID: <CADyBb7ujY0kEFq5zrWfEdS1JA=G39rKAdZC4mf2jfw=Gm8GnpA@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: Timur Tabi <timur@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
	wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur,

On 18 August 2016 at 03:01, Timur Tabi <timur@codeaurora.org> wrote:
> Lorenzo Pieralisi wrote:
>>
>> I do not think you need a v11 just to remove the drivers/acpi/arm64
>> directory creation, you need to get Daniel/Thomas review/ack on
>> the respective patches though, I do not see the point of churning
>> out another series just because drivers/acpi/arm64 is now created
>> in the IORT patch series. If v10 is ok you will rebase it on top of
>> Tomasz's series and mention the dependency in the respective pull
>> request.
>>
>> If there is need for a v11 following Daniel/Thomas review yes,
>> you can proceed as above.
>
>
> What's the latest on this patchset?  I really want them in 4.9.  Is
> everything queued up, or are still issues that need to be resolved.

we are trying to let Tomasz's series be merged first, then this patch set
will be rebased on the top of it.

If everyone is OK with this patchset, I guess  "in 4.9" is not a problem.

I don't see any suggestion and comment for now, will keep my eyes on it.

>
> Who will be merging these patches?

I think the clocksource maintainer will take care of it, and  GTDT patch
has got Rafael's ACK.

>
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
