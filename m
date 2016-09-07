Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36812 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbcIGJXo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Sep 2016 05:23:44 -0400
Received: by mail-oi0-f42.google.com with SMTP id w78so17187859oie.3
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Sep 2016 02:23:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609061635000.5647@nanos>
References: <1473168352-5156-1-git-send-email-fu.wei@linaro.org>
 <1473168352-5156-6-git-send-email-fu.wei@linaro.org> <alpine.DEB.2.20.1609061635000.5647@nanos>
From: Fu Wei <fu.wei@linaro.org>
Date: Wed, 7 Sep 2016 17:23:43 +0800
Message-ID: <CADyBb7uX79UP=mUxvP-EPGi56-46y2SCMPsWO=Uw-=N0GQERhA@mail.gmail.com>
Subject: Re: [PATCH v11 5/8] clocksource/drivers/arm_arch_timer: Simplify ACPI
 support code.
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Thomas

On 6 September 2016 at 22:36, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 6 Sep 2016, fu.wei@linaro.org wrote:
>> +     if (timer_count < 0)
>> +             pr_err("Failed to get platform timer info, skipping.\n");
>
> So this prints something about skipping. But then it continues as if
> nothing went wrong. That's either wrong or confusing or both.

yes, you are right, this info is confusing.
maybe we just delete the "skipping" ?

=E2=80=9Ctimer_count < 0=E2=80=9D is caused by some firmware bug, in gtdt.c=
:
----
int __init acpi_gtdt_init(struct acpi_table_header *table)
{
......
        if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
        pr_err(FW_BUG "Failed to retrieve timer info from firmware:
invalid data.\n");
        return -EINVAL;
......
}
----

But in this situation( without platform timers ), system still can work.
So I thing we just need to print a error.

>
>> -     arch_timer_init();
>> -     return 0;
>> +     return arch_timer_init();
>
> Thanks,
>
>         tglx



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
