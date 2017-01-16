Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38160 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdAPMEU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 07:04:20 -0500
Received: by mail-it0-f42.google.com with SMTP id c7so20055248itd.1
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Jan 2017 04:04:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170116120123.GD5908@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org> <CADyBb7vbTLWKgmGe7jH=4OJx7sZ4Ck4iR-spvnHUrStF5XGxKw@mail.gmail.com>
 <20170116120123.GD5908@leverpostej>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 16 Jan 2017 20:04:19 +0800
Message-ID: <CADyBb7uqExeV81Co_-++2fGRZf+9Y-p23K+hh4B0R30jv5K6tw@mail.gmail.com>
Subject: Re: [PATCH v19 00/15] acpi, clocksource: add GTDT driver and GTDT
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

On 16 January 2017 at 20:01, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jan 16, 2017 at 02:26:54PM +0800, Fu Wei wrote:
>> Hi Mark,
>>
>> This v19 (I have mentioned it in my previous email) is the latest
>> patchset which can be applied on v4.10-rc4 directly.
>>
>> please review this patchset, thanks! :-)
>
> Thanks for the pointer; I will look at this shortly.

Great thanks, looking forward to your feedback! :-)

>
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
