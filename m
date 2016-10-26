Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932550AbcJZMLV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Oct 2016 08:11:21 -0400
Subject: Re: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
To: Fu Wei <fu.wei@linaro.org>, Mark Rutland <mark.rutland@arm.com>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
 <20161020163719.GC27598@leverpostej>
 <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        G Gregory <graeme.gregory@linaro.org>,
        Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
        Wei Huang <wei@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Leo Duran <leo.duran@amd.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Julien Grall <julien.grall@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <57010864-b2f0-d230-3138-8ace484acb04@arm.com>
Date: Wed, 26 Oct 2016 13:11:14 +0100
MIME-Version: 1.0
In-Reply-To: <CADyBb7tLJpPiMqWs4KZE=uCpo3HX3WcNVju2UKNuPOR0+M4UDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 26/10/16 12:10, Fu Wei wrote:
> Hi Mark,
> 
> On 21 October 2016 at 00:37, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi,
>>
>> As a heads-up, on v4.9-rc1 I see conflicts at least against
>> arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
>> automatically, but this will need to be rebased before the next posting
>> and/or merging.
>>
>> On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei@linaro.org wrote:
>>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>>> +{
>>> +     int trigger, polarity;
>>> +
>>> +     if (!interrupt)
>>> +             return 0;
>>
>> Urgh.
>>
>> Only the secure interrupt (which we do not need) is optional in this
>> manner, and (hilariously), zero appears to also be a valid GSIV, per
>> figure 5-24 in the ACPI 6.1 spec.
>>
>> So, I think that:
>>
>> (a) we should not bother parsing the secure interrupt
> 
> If I understand correctly, from this point of view, kernel don't
> handle the secure interrupt.
> But the current arm_arch_timer driver still enable/disable/request
> PHYS_SECURE_PPI
> with PHYS_NONSECURE_PPI.
> That means we still need to parse the secure interrupt.
> Please correct me, if I misunderstand something? :-)

That's because we can use the per-cpu timer when 32bit Linux is running
on the secure side (and we cannot distinguish between secure and
non-secure at runtime). ACPI is 64bit only, and Linux on 64bit isn't
supported on the secure side, so only registering the non-secure timer
is perfectly acceptable.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
