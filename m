Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35504 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbbEZPC5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 11:02:57 -0400
Received: by oihd6 with SMTP id d6so79883269oih.2
        for <linux-watchdog@vger.kernel.org>; Tue, 26 May 2015 08:02:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150526122858.GJ1565@arm.com>
References: <=fu.wei@linaro.org>
	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>
	<1432548193-19569-7-git-send-email-fu.wei@linaro.org>
	<20150526122858.GJ1565@arm.com>
Date: Tue, 26 May 2015 11:02:56 -0400
Message-ID: <CAJ5Y-eZfzrDtEL5gpZ1rRNUhr2dCZKuA-MMNcwV=TgFW_9rq=g@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Will,

On 26 May 2015 at 08:28, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, May 25, 2015 at 11:03:13AM +0100, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
>> and create a platform device with that information.
>> This platform device can be used by the ARM SBSA Generic
>> Watchdog driver.
>>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  arch/arm64/kernel/acpi.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 145 insertions(+)
>
> Why does this all need to be under arch/arm64? The GTDT really isn't
> architecture-specific, so I'd *much* rather it was parsed in the driver code
> itself, like we already do for the architected timer. The GIC is an
> exception because it's in the MADT, which we need to parse in the arch code
> to configure SMP properly.

I'm not really against refactoring the code. But the GTDT looks quite
specific to ARM..

---8<----
5.2.24 Generic Timer Description Table (GTDT)
This section describes the format of the Generic Timer Description
Table (GTDT), which provides
OSPM with information about a system’s Generic Timers configuration.
The Generic Timer (GT) is
a standard timer interface implemented on ARM processor-based systems.
The GT hardware
specification can be found at Links to ACPI-Related Documents
(http://uefi.org/acpi) under the
heading ARM Architecture. The GTDT provides OSPM with information
about a system's GT
interrupt configurations, for both per-processor timers, and platform
(memory-mapped) timers.
The GT specification defines the following per-processor timers:
• Secure privilege level 1 (EL1) timer,
• Non-Secure EL1 timer,
• Non-Secure privilege level 2 (EL2) timer,
• Virtual timer,
and the following Platform (memory-mapped) timers.
• GT Block
• Server Base System Architecture (SBSA) Generic Watchdog
---8<----

Thanks,
Ashwin.
