Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbdAaLnm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 31 Jan 2017 06:43:42 -0500
Date: Tue, 31 Jan 2017 11:42:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org,
        Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Timur Tabi <timur@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Len Brown <lenb@kernel.org>,
        "Abdulhamid, Harb" <harba@codeaurora.org>,
        Julien Grall <julien.grall@arm.com>,
        linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jon Masters <jcm@redhat.com>,
        Christopher Covington <cov@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        G Gregory <graeme.gregory@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Duran <leo.duran@amd.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Message-ID: <20170131114233.GB11191@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej>
 <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
 <20170125172505.GB29027@leverpostej>
 <CADyBb7syNx+HJ6t5JKPMnLqvq-98kPi1knuXU=SSe6_Uz6Gg1A@mail.gmail.com>
 <20170130174958.GA3496@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170130174958.GA3496@leverpostej>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 30, 2017 at 05:49:59PM +0000, Mark Rutland wrote:
> On Thu, Jan 26, 2017 at 01:49:03PM +0800, Fu Wei wrote:

> > And because Linux kernel is running on Non-secure EL1, so should we
> > skip "SECURE" timer in Linux?
> 
> I guess you mean by checking the GTx Common flags, to see if the timer
> is secure? Yes, we must skip those.
> 
> Looking further at this, the ACPI spec is sorely lacking any statement
> as to the configuration of CNTCTLBase.{CNTSAR,CNTTIDR,CNTACR}, so it's
> not clear if we can access anything in a frame, even if it is listed as
> being a non-secure timer.

Given CNTNSAR.NS<n> enables non-secure access to CNTACR<n>, I guess the
obvious interpretation is that for frames listed as non-secure, this has
been configured to permit non-secure access to the frame and associated
CNTACR<n>.

I will work to that assumption while reviewing, though I still believe
this needs to be clarified in the spec.

Thanks,
Mark.
