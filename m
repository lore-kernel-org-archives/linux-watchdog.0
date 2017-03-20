Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932354AbdCTSKU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Mar 2017 14:10:20 -0400
Date: Mon, 20 Mar 2017 18:09:50 +0000
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
Subject: Re: [PATCH v21 13/13] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
Message-ID: <20170320180949.GM31213@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-14-fu.wei@linaro.org>
 <20170317200153.GF15909@leverpostej>
 <CADyBb7uZV2Qe0ga4TTS_iis5MtwJ=u6PKYSV6ED103Cmh5_O3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7uZV2Qe0ga4TTS_iis5MtwJ=u6PKYSV6ED103Cmh5_O3g@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 21, 2017 at 01:57:58AM +0800, Fu Wei wrote:
> On 18 March 2017 at 04:01, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Feb 07, 2017 at 02:50:15AM +0800, fu.wei@linaro.org wrote:

> > I've not been able to find where the ACPI spec says that zero is not a
> > valid GSIV. This may simply be an oversight/ambiguity in the spec.
> >
> > Is there any statement to that effect?
> 
> you are right, zero is a  valid GSIV, I will delete this check. Thanks

That being the case, how does one describe a watchdog that does not have
an interrupt?

As I mentioned, I think this is an oversight/ambiguity in the spec tat
we should address.

> > My reading of SBSA is that there is one watchdog in the system.
> >
> > Is that not the case?
> 
> do you mean:
> ---------------
> 4.2.4 Watchdogs
> The base server system implements a Generic Watchdog as specified in
> APPENDIX A: Generic Watchdog.
> ---------------
> 
> I am not sure about that if this is saying "we only have one SBSA
> watchdog in a system"
> 
> would you let me know where mention it? Do I miss something?

My reading was that the 'a' above meant a single element. i.e.

	The base server system implements _a_ Generic Watchdog as
	specified in APPENDIX A: Generic Watchdog.

Subsequently in 4.2.5, it is stated:

	In this scenario, the system wakeup timer or generic watchdog is
	still required to send its interrupt.

... which only makes sense if there is a single watchdog in the system.

Perhaps this is an oversight in the specification.

Thanks,
Mark.
