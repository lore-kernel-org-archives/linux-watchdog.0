Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35932 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756168AbdCTR6N (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:13 -0400
Received: by mail-it0-f42.google.com with SMTP id w124so96961742itb.1
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Mar 2017 10:58:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317200153.GF15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org> <20170206185015.12296-14-fu.wei@linaro.org>
 <20170317200153.GF15909@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Tue, 21 Mar 2017 01:57:58 +0800
Message-ID: <CADyBb7uZV2Qe0ga4TTS_iis5MtwJ=u6PKYSV6ED103Cmh5_O3g@mail.gmail.com>
Subject: Re: [PATCH v21 13/13] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark

On 18 March 2017 at 04:01, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Feb 07, 2017 at 02:50:15AM +0800, fu.wei@linaro.org wrote:
>> +static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
>> +                                     int index)
>> +{
>> +     struct platform_device *pdev;
>> +     int irq =3D map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
>> +     int no_irq =3D 1;
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
>> +
>> +     pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
>> +              wd->refresh_frame_address, wd->control_frame_address,
>> +              wd->timer_interrupt, wd->timer_flags);
>> +
>> +     if (!(wd->refresh_frame_address && wd->control_frame_address)) {
>> +             pr_err(FW_BUG "failed to get the Watchdog base address.\n"=
);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (!wd->timer_interrupt)
>> +             pr_warn(FW_BUG "failed to get the Watchdog interrupt.\n");
>
> I've not been able to find where the ACPI spec says that zero is not a
> valid GSIV. This may simply be an oversight/ambiguity in the spec.
>
> Is there any statement to that effect?

you are right, zero is a  valid GSIV, I will delete this check. Thanks

>
>> +     else if (irq <=3D 0)
>> +             pr_warn("failed to map the Watchdog interrupt.\n");
>> +     else
>> +             no_irq =3D 0;
>> +
>> +     /*
>> +      * Add a platform device named "sbsa-gwdt" to match the platform d=
river.
>> +      * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watc=
hdog
>> +      * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get =
device
>> +      * info below by matching this name.
>> +      */
>> +     pdev =3D platform_device_register_simple("sbsa-gwdt", index, res,
>> +                                            ARRAY_SIZE(res) - no_irq);
>
> This no_irq variable is messy and confusing.
>
> Get rid of no_irq, and replace it with nr_res, initialised to
> ARRAY_SIZE(res). If there's no interrupt, subtract one.

Sure, you are right ,will do

>
> [...]
>
>> +     for_each_platform_timer(platform_timer) {
>> +             if (is_watchdog(platform_timer)) {
>> +                     ret =3D gtdt_import_sbsa_gwdt(platform_timer, i);
>> +                     if (ret)
>> +                             break;
>> +                     i++;
>> +             }
>> +     }
>> +
>> +     if (i)
>> +             pr_info("found %d SBSA generic Watchdog(s).\n", i);
>
> My reading of SBSA is that there is one watchdog in the system.
>
> Is that not the case?

do you mean:
---------------
4.2.4 Watchdogs
The base server system implements a Generic Watchdog as specified in
APPENDIX A: Generic Watchdog.
---------------

I am not sure about that if this is saying "we only have one SBSA
watchdog in a system"

would you let me know where mention it? Do I miss something?

Thanks :-)

>
> [...]
>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index acb00b5..c899df1 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -219,6 +219,7 @@ config ARM_SBSA_WATCHDOG
>>       tristate "ARM SBSA Generic Watchdog"
>>       depends on ARM64
>>       depends on ARM_ARCH_TIMER
>> +     depends on ACPI_GTDT || !ACPI
>
> I don't think this is necessary.
>
> This series hasn't touched this driver code at all.

yes, since we are using "select ACPI_GTDT if ACPI" in ARM64, we don't this.
Thanks for pointing it out.
:-)

>
> Thanks,
> Mark.



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
