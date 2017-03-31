Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33035 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbdCaIKp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 04:10:45 -0400
Received: by mail-io0-f181.google.com with SMTP id f84so34935451ioj.0
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Mar 2017 01:10:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328154111.GC18046@red-moon>
References: <20170321163122.9183-1-fu.wei@linaro.org> <20170321163122.9183-12-fu.wei@linaro.org>
 <20170328154111.GC18046@red-moon>
From: Fu Wei <fu.wei@linaro.org>
Date: Fri, 31 Mar 2017 16:10:43 +0800
Message-ID: <CADyBb7uDyjhP2Pjtzh6pTN-0hkokB=KevY7V76G9qZOF-9-zoQ@mail.gmail.com>
Subject: Re: [PATCH v22 11/11] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lorenzo,

On 28 March 2017 at 23:41, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wr=
ote:
> On Wed, Mar 22, 2017 at 12:31:22AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This driver adds support for parsing SBSA Generic Watchdog timer
>> in GTDT, parse all info in SBSA Generic Watchdog Structure in GTDT,
>> and creating a platform device with that information.
>>
>> This allows the operating system to obtain device data from the
>> resource of platform device. The platform device named "sbsa-gwdt"
>> can be used by the ARM SBSA Generic Watchdog driver.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/acpi/arm64/gtdt.c | 94 ++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 94 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index f471873..5d167f0 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>>
>>  #include <clocksource/arm_arch_timer.h>
>>
>> @@ -59,6 +60,17 @@ static inline bool is_timer_block(void *platform_time=
r)
>>       return gh->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK;
>>  }
>>
>> +static inline bool is_non_secure_watchdog(void *platform_timer)
>> +{
>> +     struct acpi_gtdt_header *gh =3D platform_timer;
>> +     struct acpi_gtdt_watchdog *wd =3D platform_timer;
>> +
>> +     if (gh->type !=3D ACPI_GTDT_TYPE_WATCHDOG)
>> +             return false;
>> +
>> +     return !(wd->timer_flags & ACPI_GTDT_WATCHDOG_SECURE);
>> +}
>> +
>>  static int __init map_gt_gsi(u32 interrupt, u32 flags)
>>  {
>>       int trigger, polarity;
>> @@ -285,3 +297,85 @@ int __init acpi_arch_timer_mem_init(struct arch_tim=
er_mem *timer_mem,
>>
>>       return 0;
>>  }
>> +
>> +/*
>> + * Initialize a SBSA generic Watchdog platform device info from GTDT
>> + */
>> +static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
>> +                                     int index)
>> +{
>> +     struct platform_device *pdev;
>> +     int irq =3D map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
>> +
>> +     /*
>> +      * According to SBSA specification the size of refresh and control
>> +      * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 =E2=80=93=
 0xFFF).
>> +      */
>> +     struct resource res[] =3D {
>> +             DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
>> +             DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
>> +             DEFINE_RES_IRQ(irq),
>> +     };
>> +     int nr_res =3D ARRAY_SIZE(res);
>> +
>> +     pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
>> +              wd->refresh_frame_address, wd->control_frame_address,
>> +              wd->timer_interrupt, wd->timer_flags);
>> +
>> +     if (!(wd->refresh_frame_address && wd->control_frame_address)) {
>> +             pr_err(FW_BUG "failed to get the Watchdog base address.\n"=
);


+             acpi_unregister_gsi(wd->timer_interrupt);


>> +             return -EINVAL;
>
> You should unmap the gsi here.

yes, you are right, fixed it.

>
>> +     }
>> +
>> +     if (irq <=3D 0) {
>> +             pr_warn("failed to map the Watchdog interrupt.\n");
>> +             nr_res--;
>> +     }
>> +
>> +     /*
>> +      * Add a platform device named "sbsa-gwdt" to match the platform d=
river.
>> +      * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watc=
hdog
>> +      * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get =
device

+      * The platform driver can get device info below by matching this nam=
e.

>
> Nit: I would not hardcode drivers paths in comments.


OK, deleted it

>
>> +      * info below by matching this name.
>> +      */
>> +     pdev =3D platform_device_register_simple("sbsa-gwdt", index, res, =
nr_res);
>> +     if (IS_ERR(pdev)) {
>> +             acpi_unregister_gsi(wd->timer_interrupt);
>> +             return PTR_ERR(pdev);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int __init gtdt_sbsa_gwdt_init(void)
>> +{
>> +     int ret, i =3D 0;
>> +     void *platform_timer;
>> +     struct acpi_table_header *table;
>> +
>> +     if (acpi_disabled)
>> +             return 0;
>> +
>> +     if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
>> +             return -EINVAL;
>> +
>> +     ret =3D acpi_gtdt_init(table, NULL);
>> +     if (ret)
>> +             return ret;
>
> Ok, I missed previous versions reviews so I miss the background
> here and I apologise.
>
> I do not understand why you call acpi_gtdt_init() again (or better,
> why acpi_gtdt_init() does not return straight away) here if the
> stashed pointer in acpi_gtdt_desc is already set. I am not a big fan
> of the for_each_platform_timer macro either, here you can just read
> the ACPI_SIG_GTDT and parse its entries, I see no point in calling
> acpi_gtdt_init() again, there is nothing to stash for later probing,
> is there ?
>
> Or it is just to reuse common parsing code ? Regardless, if the
> acpi_gtdt_desc struct is already initialized acpi_gtdt_init() should
> just return or I am missing the point.
>
> I would like clarifications on the acpi_gtdt_init() call above please
> (plus GSI unmap fix), apart from that:
>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Actually, after the discussion in the 7th patch, I have tried to do
this, see if that can make the code simpler.
Then I found out that
(1) If we would like to reuse "for_each_platform_timer" (and
"next_platform_timer") to scan the GTDT for SBSA watchdog, we have to
re-initialize acpi_gtdt_desc, too.
     So we still need to explain that why we have to re-initialize
acpi_gtdt_desc.
(2) If we totally ignore acpi_gtdt_desc, and acpi_gtdt_init(), we
can't re-use  "for_each_platform_timer" (and "next_platform_timer") .
we have to re-write  the loop of scanning the GTDT for SBSA watchdog,

So may I suggest that maybe we can keep using acpi_gtdt_init, only add
the comment to explain why we have to re-initialize
acpi_gtdt_desc(Just what you have said in the 7th patch. Thanks for
your correction for the comment, I will use that ), this way maybe can
make the code simpler.

But If you still concern about this,  we still can discuss this at -rc1.

Great thanks for your help! :-)

>
>> +     for_each_platform_timer(platform_timer) {
>> +             if (is_non_secure_watchdog(platform_timer)) {
>> +                     ret =3D gtdt_import_sbsa_gwdt(platform_timer, i);
>> +                     if (ret)
>> +                             break;
>> +                     i++;
>> +             }
>> +     }
>> +
>> +     if (i)
>> +             pr_info("found %d SBSA generic Watchdog(s).\n", i);
>> +
>> +     return ret;
>> +}
>> +
>> +device_initcall(gtdt_sbsa_gwdt_init);
>> --
>> 2.9.3
>>



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
