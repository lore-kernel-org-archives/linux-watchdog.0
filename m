Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdCQUE0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 16:04:26 -0400
Date: Fri, 17 Mar 2017 20:03:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Fu Wei <fu.wei@linaro.org>
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
Subject: Re: [PATCH v21 00/13] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Message-ID: <20170317200346.GG15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <CADyBb7t_zrLetPQQ8=k8oN6iMHhuMHO8O3XTZqGYvTT9p0evKw@mail.gmail.com>
 <CADyBb7urVf87LTsyrtoaAExTeOZSBAvT91enGBK4cm6723q+1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7urVf87LTsyrtoaAExTeOZSBAvT91enGBK4cm6723q+1Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 09, 2017 at 11:47:16PM +0100, Fu Wei wrote:
> Hi Mark, Marc,

Hi,

> I have tried to rebase all the 19(6+13) patches  on 4.11-rc1,
> all the patchse can directly apply on  4.11-rc1,
> 
> Could you help to review the patches, and see if there is anywhere I
> can improve ?

I'm sorry I have taken so long to review this posting.

This is generally looking much better. I'm not sure about a few details
relating to the watchdog, but I'm largely happy to pick up the rest of
the series, if you can address my comments.

Thanks,
Mark.
