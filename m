Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbdA3Rvf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 30 Jan 2017 12:51:35 -0500
Date: Mon, 30 Jan 2017 17:49:59 +0000
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
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Message-ID: <20170130174958.GA3496@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej>
 <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
 <20170125172505.GB29027@leverpostej>
 <CADyBb7syNx+HJ6t5JKPMnLqvq-98kPi1knuXU=SSe6_Uz6Gg1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7syNx+HJ6t5JKPMnLqvq-98kPi1knuXU=SSe6_Uz6Gg1A@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jan 26, 2017 at 01:49:03PM +0800, Fu Wei wrote:
> On 26 January 2017 at 01:25, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jan 25, 2017 at 02:46:12PM +0800, Fu Wei wrote:
> >> On 25 January 2017 at 01:24, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Jan 18, 2017 at 09:25:32PM +0800, fu.wei@linaro.org wrote:
> >> >> From: Fu Wei <fu.wei@linaro.org>

> > For CNT{,EL0}BaseN.CNTFRQ, I am very concerned by the wording in the
> > current ARMv8 ARM ARM. This does not match my understanding, nor does it
> > match the description in the ARMv7 ARM. I believe this may be a
> > documentation error, and I'm chasing that up internally.
> >
> > Either the currently logic in the driver which attempts to read
> > CNT{,EL0}BaseN.CNTFRQ is flawed, or the description in the ARM ARM is
> > erroneous.
> 
> Yes, those description did confuse me. :-(
> 
> But according to another document(ARMv8-A Foundation Platform User
> Guide  ARM DUI0677K),
> Table 3-2 ARMv8-A Foundation Platform memory map (continued)
> 
> AP_REFCLK CNTBase0, Generic Timer 64KB   S
> AP_REFCLK CNTBase1, Generic Timer 64KB   S/NS
> 
> Dose it means the timer frame 0 can be accessed in SECURE status  only,
> and the timer frame 1 can be accessed in both status?

That does appear to be what it says.

I assume in this case CNTCTLBase.CNTSAR<0> is RES0.

> And because Linux kernel is running on Non-secure EL1, so should we
> skip "SECURE" timer in Linux?

I guess you mean by checking the GTx Common flags, to see if the timer
is secure? Yes, we must skip those.

Looking further at this, the ACPI spec is sorely lacking any statement
as to the configuration of CNTCTLBase.{CNTSAR,CNTTIDR,CNTACR}, so it's
not clear if we can access anything in a frame, even if it is listed as
being a non-secure timer.

I think we need a stronger statement here. Otherwise, we will encounter
problems. Linux currently assumes that CNTCTLBase.CNTACR<N> is
writeable, given a non-secure frame N. This is only the case if
CNTCTLBase.CNTSAR.NS<N> == 1.

Thanks,
Mark.
