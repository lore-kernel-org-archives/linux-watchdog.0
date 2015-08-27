Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32967 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbbH0Ng3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Aug 2015 09:36:29 -0400
Received: by pacti10 with SMTP id ti10so26735893pac.0
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2015 06:36:29 -0700 (PDT)
Message-ID: <55DF1257.9090303@linaro.org>
Date: Thu, 27 Aug 2015 21:36:23 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Fu Wei <fu.wei@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>, dyoung@redhat.com,
	panand@redhat.com, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v7 8/8] clocksource: simplify ACPI code in arm_arch_timer.c
References: <=fu.wei@linaro.org> <1440435683-7343-1-git-send-email-fu.wei@linaro.org> <1440435683-7343-9-git-send-email-fu.wei@linaro.org> <alpine.DEB.2.11.1508241942450.3873@nanos> <CADyBb7sVGePKtU45_DBGd74fykAPVshmbnRQJDDOrrvoHTGcKQ@mail.gmail.com> <alpine.DEB.2.11.1508252113590.15006@nanos> <55DEFC54.4090904@linaro.org> <alpine.DEB.2.11.1508271405330.15006@nanos> <55DF025F.2050102@linaro.org>
In-Reply-To: <55DF025F.2050102@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/27/2015 08:28 PM, Hanjun Guo wrote:
> On 08/27/2015 08:08 PM, Thomas Gleixner wrote:
>> On Thu, 27 Aug 2015, Hanjun Guo wrote:
>>> On 08/26/2015 03:17 AM, Thomas Gleixner wrote:
>>>> On Wed, 26 Aug 2015, Fu Wei wrote:
>>>>>>>    /* Initialize per-processor generic timer */
>>>>>>> -static int __init arch_timer_acpi_init(struct acpi_table_header
>>>>>>> *table)
>>>>>>> +void __init arch_timer_acpi_init(void)
>>>>>>>    {
>>>>>>
>>>>>> And how is that supposed to work when we have next generation CPUs
>>>>>> which implement a different timer? You break multisystem kernels that
>>>>>> way.
>>>
>>> Sorry, I think I missed some context here that I don't understand
>>> why the code here will break multisystem kernels? I'm trying to
>>> understand the problem here and update the code :)
>>>
>>>>>
>>>>> yes, you are right, If there is a  next generation CPUs  which
>>>>> implement a different timer, (maybe) this driver can not work.
>>>>> we may need a new timer driver.
>>>>>
>>>>> But,
>>>>> (1) for now,  aarch64  core always has the arch timer(this timer is
>>>>> part of aarch64 architecture).
>>>>> and the existing code make  ARM64 kernel "select ARM_ARCH_TIMER "
>>>>> (2) GTDT is designed for generic timer, so in this call "
>>>>> arch_timer_acpi_init"  we  parse the gtdt info.
>>>>> (3) once we have a ARM64 CPUs which implement a different timer, we
>>>>> may need to select a right timer in the config stage.
>>>>> and this timer may not be described in GTDT.  So we can implement
>>>>> another arch_timer_acpi_init by that time in new timer driver..
>>>>> if the new time still uses GTDT(or new version GTDT), we may need to
>>>>> update gtdt.c for new timer by that time.
>>>>
>>>> That's simply wrong. You want to build kernels which run on both cpus
>>>> and the selection of the timer happens at runtime depending on the
>>>> ACPI info. We do the same thing with device tree.
>>>
>>> I think the code can do that if I understand correctly. The code for
>>> now is that we only support arch timer on ARM64, and this patch set
>>> is adding SBSA watchdog timer support which need same function in
>>> arch timer, so we move that function to common place.
>>>
>>> We will load the driver (arch timer, memory mapped timer) when the
>>> ACPI table defines them, which when new timer is coming, that will
>>> defined in the ACPI table and load the driver as needed.
>>>
>>> Please correct me if I misse something, thanks.
>>
>> arch_timer_acpi_init() is called from the architecture boot code. So
>> how is that supposed to work with different timers?
>>
>> Are you going to have bla_timer_acpi_init() and foo_timer_acpi_init()
>> calls as well?
>>
>> Why not having a something like DT has: DECLARE_....
>>
>> and the arch_timer_acpi_init() using that to figure out which of the
>> timers to initialize.
>
> Ah, ok, I can fully understand you now, thanks for your patience.
>
> Yes, I agree with you, so this is not a problem for this patch, but
> for the code implementation of previous code. Actually we are on the
> road to do as you suggested, we introduced something like
> #define ACPI_DECLARE(table, name, table_id, subtable, data, fn) [1]
> in the GICv3 and GIC self probe patch set, and I said that
> infrastructure can be used as clock declare too, we just trying
> to not add such dependence on that patch set (it's still on discussion),
>
> [1]: https://lkml.org/lkml/2015/7/29/236
>
> If that is ok with you, we will introduce similar DECLARE_ thing
> for clock declare.

Or we can drop this patch from this patch set, and clean up this
patch when the ACPI_DECLARE() infrastructure is ready for upstream.

Thanks
Hanjun
