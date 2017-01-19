Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752088AbdASLS1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 06:18:27 -0500
Date: Thu, 19 Jan 2017 11:16:28 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v20 13/17] acpi/arm64: Add GTDT table parse driver
Message-ID: <20170119111628.GC11176@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-14-fu.wei@linaro.org>
 <e69d80d1-0954-b1be-817e-c0be6fc24b77@linaro.org>
 <CADyBb7tdfw+wbTZbcnsaHRa=aG6i9acLp7rzMpfMs-vOHXL6pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7tdfw+wbTZbcnsaHRa=aG6i9acLp7rzMpfMs-vOHXL6pQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jan 19, 2017 at 06:32:55PM +0800, Fu Wei wrote:
> On 19 January 2017 at 17:11, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > On 2017/1/18 21:25, fu.wei@linaro.org wrote:
> >> From: Fu Wei <fu.wei@linaro.org>

> >> +       else if (!gtdt->platform_timer_count)
> >> +               pr_debug("No Platform Timer.\n");
> >> +       else
> >> +               timer_count = gtdt->platform_timer_count;
> >> +
> >> +       if (timer_count) {
> >> +               platform_timer = (void *)gtdt +
> >> gtdt->platform_timer_offset;
> >> +               if (platform_timer < (void *)table +
> >> +                                    sizeof(struct acpi_table_gtdt)) {
> >> +                       pr_err(FW_BUG "invalid timer data.\n");
> >
> >
> > It's ok but I didn't see other ACPI tables parsing did this check,
> > maybe we can just remove it :)
> 
> here, I want to make sure the FW is valid.
> Once there is a FW bug, we could just return with error.  :-)

Yes, please keep the check!

If anything, it would be nicer for the other ACPI code to verify things
a little more stringently.

Thanks,
Mark.
