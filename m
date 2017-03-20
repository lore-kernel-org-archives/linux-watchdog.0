Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754195AbdCTKmX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 06:42:23 -0400
Date: Mon, 20 Mar 2017 10:41:54 +0000
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
Subject: Re: [PATCH v21 01/13] clocksource: arm_arch_timer: introduce two
 functions to get the frequency from mmio and sysreg.
Message-ID: <20170320104153.GA18585@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-2-fu.wei@linaro.org>
 <20170317180513.GB15909@leverpostej>
 <CADyBb7vZ4G+q1y6w6OVQ7i-ZiTtcdx_w2BOSWqy=2jWhAV6Hmw@mail.gmail.com>
 <CADyBb7vawnjnL6Phxc_owTnEK0qf95cYAUWPga9axGqEWc46Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7vawnjnL6Phxc_owTnEK0qf95cYAUWPga9axGqEWc46Ww@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 20, 2017 at 05:43:29PM +0800, Fu Wei wrote:
> On 20 March 2017 at 15:36, Fu Wei <fu.wei@linaro.org> wrote:
> > On 18 March 2017 at 02:05, Mark Rutland <mark.rutland@arm.com> wrote:
> >> On Tue, Feb 07, 2017 at 02:50:03AM +0800, fu.wei@linaro.org wrote:

> >>> +static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
> >>> +{
> >>> +     /*
> >>> +      * Try to get the frequency from the CNTFRQ of timer frame registers.
> >>> +      * Note: please verify cntbase in caller.
> >>> +      */
> >>> +     return readl_relaxed(cntbase + CNTFRQ);
> >>> +}
> >>
> >> Wrapping the MMIO read makes sense if we're going to do this in more
> >> than one place, so I'm happy with this wrapper.
> >>
> >> If you can s/arch_timer_get_mmio_freq/arch_timer_get_cntfrq/, and drop
> >
> > sorry, May I guess that is
> > "s/arch_timer_get_mmio_freq/arch_timer_get_mmio_cntfrq/"
> > or
> > "s/arch_timer_get_mmio_freq/arch_timer_mem_get_cntfrq/"
> >
> > which one do you prefer? :-)
> 
> keeping using arch_timer_get_cntfrq();  for per-CPU arch timer, then
> 
> +static u32 arch_timer_mem_get_cntfrq(void __iomem *cntbase)
> +{
> +       return readl_relaxed(cntbase + CNTFRQ);
> +}
> +

That looks perfect to me.

Sorry for the confusion above!

Mark.
