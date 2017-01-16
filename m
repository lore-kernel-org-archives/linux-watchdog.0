Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbdAPMAt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 07:00:49 -0500
Date: Mon, 16 Jan 2017 11:59:40 +0000
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
Subject: Re: [PATCH v18 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Message-ID: <20170116115940.GC5908@leverpostej>
References: <20161208173319.6618-1-fu.wei@linaro.org>
 <20170113192920.GF2472@leverpostej>
 <CADyBb7vF0v2DwXA8fNUOTQcqriJK1Hp57_G8DKi0WO9FnvrB5w@mail.gmail.com>
 <CADyBb7ugz_YpxKQUsJbF1vdjm_Nzyh2mH8TZMPqj1cSHGSPCFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7ugz_YpxKQUsJbF1vdjm_Nzyh2mH8TZMPqj1cSHGSPCFw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 16, 2017 at 08:54:46AM +0800, Fu Wei wrote:
> On 14 January 2017 at 19:34, Fu Wei <fu.wei@linaro.org> wrote:
> > On 14 January 2017 at 03:29, Mark Rutland <mark.rutland@arm.com> wrote:

> >> Once v4.10-rc4 comes out this weekend, could you please rebase and
> >> repost this?
> >
> > Yes, of course.
> >
> > I have rebased v19 to the latest v4.10-rc3-e96f8f1, it dosen't need
> > any modification.
> > I will rebase it every day, and will repost it if it need any  modification.
> >
> > But for now, V19 works well with the master branch of upstream kernel.
> > Do I need to re-post it even if it doesn't need any improvement or
> > modification? :-)
> 
> I just fetched the latest mainline kernel, and rebase v19 on the top
> of 4.10-rc4.
> I have double checked it, V19 works well with  4.10-rc4.
> For rebasing,  it doesn't need any modification.

Ok. Assuming that the patches apply cleanly atop of v4.10-rc4, I will
look over this shortly.

Thanks for checking that!

Mark.
