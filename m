Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37603 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdCTFJl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 01:09:41 -0400
Received: by mail-it0-f43.google.com with SMTP id g138so82827115itb.0
        for <linux-watchdog@vger.kernel.org>; Sun, 19 Mar 2017 22:09:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317200346.GG15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org> <CADyBb7t_zrLetPQQ8=k8oN6iMHhuMHO8O3XTZqGYvTT9p0evKw@mail.gmail.com>
 <CADyBb7urVf87LTsyrtoaAExTeOZSBAvT91enGBK4cm6723q+1Q@mail.gmail.com> <20170317200346.GG15909@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 20 Mar 2017 13:09:39 +0800
Message-ID: <CADyBb7uinO7HVRusFa2hXFdKGXZ_5FnEb-7-S-xUNx=W2+NfCA@mail.gmail.com>
Subject: Re: [PATCH v21 00/13] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
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
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

On 18 March 2017 at 04:03, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Mar 09, 2017 at 11:47:16PM +0100, Fu Wei wrote:
>> Hi Mark, Marc,
>
> Hi,
>
>> I have tried to rebase all the 19(6+13) patches  on 4.11-rc1,
>> all the patchse can directly apply on  4.11-rc1,
>>
>> Could you help to review the patches, and see if there is anywhere I
>> can improve ?
>
> I'm sorry I have taken so long to review this posting.
>
> This is generally looking much better. I'm not sure about a few details
> relating to the watchdog, but I'm largely happy to pick up the rest of
> the series, if you can address my comments.

Great thanks for your review, I will post a new v22 ASAP(before your Tuesday).

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
