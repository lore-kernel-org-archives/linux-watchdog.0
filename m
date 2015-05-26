Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34473 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbbEZPfY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 11:35:24 -0400
Received: by oifu123 with SMTP id u123so41093857oif.1
        for <linux-watchdog@vger.kernel.org>; Tue, 26 May 2015 08:35:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150526151842.GP1565@arm.com>
References: <=fu.wei@linaro.org>
	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>
	<1432548193-19569-7-git-send-email-fu.wei@linaro.org>
	<20150526122858.GJ1565@arm.com>
	<CAJ5Y-eZfzrDtEL5gpZ1rRNUhr2dCZKuA-MMNcwV=TgFW_9rq=g@mail.gmail.com>
	<20150526151842.GP1565@arm.com>
Date: Tue, 26 May 2015 11:35:04 -0400
Message-ID: <CAJ5Y-eZBvf=pvVTmaPi8PfD1Q5RJeW9uKR-z_DgZRyKc0HfDBw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] ACPI: import watchdog info of GTDT into platform device
From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "fu.wei@linaro.org" <fu.wei@linaro.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tekkamanninja@gmail.com" <tekkamanninja@gmail.com>,
	"graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
	"al.stone@linaro.org" <al.stone@linaro.org>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"timur@codeaurora.org" <timur@codeaurora.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"vgandhi@codeaurora.org" <vgandhi@codeaurora.org>,
	"wim@iguana.be" <wim@iguana.be>, "jcm@redhat.com" <jcm@redhat.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 26 May 2015 at 11:18, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, May 26, 2015 at 04:02:56PM +0100, Ashwin Chaugule wrote:
>> On 26 May 2015 at 08:28, Will Deacon <will.deacon@arm.com> wrote:
>> > On Mon, May 25, 2015 at 11:03:13AM +0100, fu.wei@linaro.org wrote:
>> >> From: Fu Wei <fu.wei@linaro.org>
>> >>
>> >> Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
>> >> and create a platform device with that information.
>> >> This platform device can be used by the ARM SBSA Generic
>> >> Watchdog driver.
>> >>
>> >> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> >> Tested-by: Timur Tabi <timur@codeaurora.org>
>> >> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> >> ---
>> >>  arch/arm64/kernel/acpi.c | 145 +++++++++++++++++++++++++++++++++++=
++++++++++++
>> >>  1 file changed, 145 insertions(+)
>> >
>> > Why does this all need to be under arch/arm64? The GTDT really isn't
>> > architecture-specific, so I'd *much* rather it was parsed in the dri=
ver code
>> > itself, like we already do for the architected timer. The GIC is an
>> > exception because it's in the MADT, which we need to parse in the ar=
ch code
>> > to configure SMP properly.
>>
>> I'm not really against refactoring the code. But the GTDT looks quite
>> specific to ARM..
>>
>> ---8<----
>> 5.2.24 Generic Timer Description Table (GTDT)
>> This section describes the format of the Generic Timer Description
>> Table (GTDT), which provides
>> OSPM with information about a system=E2=80=99s Generic Timers configur=
ation.
>> The Generic Timer (GT) is
>> a standard timer interface implemented on ARM processor-based systems.
>> The GT hardware
>> specification can be found at Links to ACPI-Related Documents
>> (http://uefi.org/acpi) under the
>> heading ARM Architecture. The GTDT provides OSPM with information
>> about a system's GT
>> interrupt configurations, for both per-processor timers, and platform
>> (memory-mapped) timers.
>> The GT specification defines the following per-processor timers:
>> =E2=80=A2 Secure privilege level 1 (EL1) timer,
>> =E2=80=A2 Non-Secure EL1 timer,
>> =E2=80=A2 Non-Secure privilege level 2 (EL2) timer,
>> =E2=80=A2 Virtual timer,
>> and the following Platform (memory-mapped) timers.
>> =E2=80=A2 GT Block
>> =E2=80=A2 Server Base System Architecture (SBSA) Generic Watchdog
>> ---8<----
>
> Sure, the device it describes may only ever exist on ARM systems, but b=
y
> that logic then we should be moving lots of drivers back under arch/arm=
[64].

Sure. Not arguing about that. :) You said the GTDT isn't really arch
specific. That was a bit confusing.

>
> The ARM architecture says precisely *nothing* about ACPI, so we should
> try to keep arch/arm64/kernel/acpi.c to a minimum and not shovel all so=
rts
> of table conversion code in there for random peripherals.
>
> Will
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
