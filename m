Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CADyBb7uX79UP=mUxvP-EPGi56-46y2SCMPsWO=Uw-=N0GQERhA@mail.gmail.com>
References: <1473168352-5156-1-git-send-email-fu.wei@linaro.org>
 <1473168352-5156-6-git-send-email-fu.wei@linaro.org> <alpine.DEB.2.20.1609061635000.5647@nanos>
 <CADyBb7uX79UP=mUxvP-EPGi56-46y2SCMPsWO=Uw-=N0GQERhA@mail.gmail.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Tue, 13 Sep 2016 17:22:42 +0800
Message-ID: <CADyBb7v-b1bKGBdH6J78UhfCcQd=BJLFoZ16GNgmrd2EucjYDA@mail.gmail.com>
Subject: Re: [PATCH v11 5/8] clocksource/drivers/arm_arch_timer: Simplify ACPI
 support code.
To: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org,
	"Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, Wei Huang <wei@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi Thomas, Daniel,

For these  arm_arch_timer patches, do you have any other suggestion or comm=
ent?
I have deleted "skipping" in the error message.

I have prepared v12 (rebase to rc6 and on the top of IORT v11),
should I send it now (if you are OK with my arm_arch_timer patches ),
or anything I can do to improve this patchset ?

Thanks.

On 7 September 2016 at 17:23, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Thomas
>
> On 6 September 2016 at 22:36, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Tue, 6 Sep 2016, fu.wei@linaro.org wrote:
>>> +     if (timer_count < 0)
>>> +             pr_err("Failed to get platform timer info, skipping.\n");
>>
>> So this prints something about skipping. But then it continues as if
>> nothing went wrong. That's either wrong or confusing or both.
>
> yes, you are right, this info is confusing.
> maybe we just delete the "skipping" ?
>
> =E2=80=9Ctimer_count < 0=E2=80=9D is caused by some firmware bug, in gtdt=
.c:
> ----
> int __init acpi_gtdt_init(struct acpi_table_header *table)
> {
> ......
>         if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
>         pr_err(FW_BUG "Failed to retrieve timer info from firmware:
> invalid data.\n");
>         return -EINVAL;
> ......
> }
> ----
>
> But in this situation( without platform timers ), system still can work.
> So I thing we just need to print a error.
>
>>
>>> -     arch_timer_init();
>>> -     return 0;
>>> +     return arch_timer_init();
>>
>> Thanks,
>>
>>         tglx
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
