Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbdAQMhC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 17 Jan 2017 07:37:02 -0500
Date: Tue, 17 Jan 2017 12:29:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Timur Tabi <timur@codeaurora.org>
Cc: Fu Wei <fu.wei@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Subject: Re: [PATCH v19 10/15] clocksource/drivers/arm_arch_timer: Refactor
 the timer init code to prepare for GTDT
Message-ID: <20170117122921.GE11939@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-11-fu.wei@linaro.org>
 <20170116183032.GL5908@leverpostej>
 <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
 <b977f47b-a85e-d4d5-666c-b8c9cd21c25e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b977f47b-a85e-d4d5-666c-b8c9cd21c25e@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 17, 2017 at 06:18:12AM -0600, Timur Tabi wrote:
> Fu Wei wrote:
> >if (i >= ARCH_TIMER_MEM_MAX_FRAMES) {
> >        pr_err(FW_BUG "too many frames, ARMv8 spec only allows 8.\n");
> 
> pr_err(FW_BUG "too many frames, ARMv8 spec only allows %u.\n",
> 	ARCH_TIMER_MEM_MAX_FRAMES);

While I don't see ARCH_TIMER_MEM_MAX_FRAMES changing, this would be
nicer to ensure the result obviously matches.

As for wording, I'd perfer:

	pr_err(FW_BUG "too many frames, only %u are permitted.\n",
	       ARCH_TIMER_MEM_MAX_FRAMES);

... so as to avoid any confusion between spec versions and so on. We can
reconsider the message if/when that changes.

Thanks,
Mark.
