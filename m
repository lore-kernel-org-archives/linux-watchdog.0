Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1508241942450.3873@nanos>
References: <=fu.wei@linaro.org>
	<1440435683-7343-1-git-send-email-fu.wei@linaro.org>
	<1440435683-7343-9-git-send-email-fu.wei@linaro.org>
	<alpine.DEB.2.11.1508241942450.3873@nanos>
Date: Wed, 26 Aug 2015 01:19:45 +0800
Message-ID: <CADyBb7sVGePKtU45_DBGd74fykAPVshmbnRQJDDOrrvoHTGcKQ@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] clocksource: simplify ACPI code in arm_arch_timer.c
From: Fu Wei <fu.wei@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>, dyoung@redhat.com, panand@redhat.com,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Thomas,


On 25 August 2015 at 01:50, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 25 Aug 2015, fu.wei@linaro.org wrote:
>
> You Cc the world and some more on your patch, but you fail to add the
> maintainers of the clocksource code to the Cc list. Sigh.

my fault
So sorry for that, I will add the maintainers of clocksource into cc list.

>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch update arm_arch_timer driver to use the function
>> provided by the new GTDT driver of ACPI.
>> By this way, arm_arch_timer.c can be simplified, and separate
>> all the ACPI GTDT knowledge from this timer driver.
>
> That's not a proper changelog and this patch want's to be split in two:
>
> 1) Implement the new ACPI function
>
> 2) Make use of it

Yes, you are right , will improve this

>
>> index 0aa135d..99505bb 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -817,68 +817,30 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>>                      arch_timer_mem_init);
>>
>>  #ifdef CONFIG_ACPI
>> -static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
>> -{
>> -     int trigger, polarity;
>> -
>> -     if (!interrupt)
>> -             return 0;
>> -
>> -     trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
>> -                     : ACPI_LEVEL_SENSITIVE;
>> -
>> -     polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
>> -                     : ACPI_ACTIVE_HIGH;
>> -
>> -     return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>> -}
>> -
>>  /* Initialize per-processor generic timer */
>> -static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>> +void __init arch_timer_acpi_init(void)
>>  {
>
> And how is that supposed to work when we have next generation CPUs
> which implement a different timer? You break multisystem kernels that
> way.

yes, you are right, If there is a  next generation CPUs  which
implement a different timer, (maybe) this driver can not work.
we may need a new timer driver.

But,
(1) for now,  aarch64  core always has the arch timer(this timer is
part of aarch64 architecture).
and the existing code make  ARM64 kernel "select ARM_ARCH_TIMER "
(2) GTDT is designed for generic timer, so in this call "
arch_timer_acpi_init"  we  parse the gtdt info.

(3) once we have a ARM64 CPUs which implement a different timer, we
may need to select a right timer in the config stage.
and this timer may not be described in GTDT.  So we can implement
another arch_timer_acpi_init by that time in new timer driver..
if the new time still uses GTDT(or new version GTDT), we may need to
update gtdt.c for new timer by that time.

but before we really have this new timer, I think this code is OK to use.

Do I understand your comment correctly? :-)

>
> Thanks,
>
>         tglx



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
