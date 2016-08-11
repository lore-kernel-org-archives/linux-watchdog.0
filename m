Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:32888 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbcHKK3N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Aug 2016 06:29:13 -0400
Received: by mail-oi0-f47.google.com with SMTP id c15so95017098oig.0
        for <linux-watchdog@vger.kernel.org>; Thu, 11 Aug 2016 03:29:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com> <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
From: Fu Wei <fu.wei@linaro.org>
Date: Thu, 11 Aug 2016 18:22:03 +0800
Message-ID: <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
	Timur Tabi <timur@codeaurora.org>,
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

Hi Hanjun, Tomasz,

On 11 August 2016 at 18:15, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Hi,
>
> On 2016/8/11 17:37, Tomasz Nowicki wrote:
>>
>> Hi Fu,
>>
>> Do you mind if I send IORT series where new drivers/acpi/arm64 directory
>> would be introduced in first place ? This means your GTDT set would
>> depend on IORT.
>
>
> I think it's reasonable as the IORT for ITS is the key device enablement
> for PCI MSI. I talked to Fuwei offline and he is fine with it.

That's no problem at all, will do.

Can I do this:
(1)apply Tomasz's v8 patchset on the master branch of upstream kernel
(2)rebase my v10 on the top of Tomasz's v8
(3)git format-patch as v11, repost it

Is that OK for everyone? :-)

>
> But both the GTDT patchset and IORT are in good shape now, can we
> targeting both of them for 4.9 kernel (since all go via tip tree)?
>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
