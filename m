Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53395 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932173AbcHKK66 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Aug 2016 06:58:58 -0400
Date: Thu, 11 Aug 2016 11:58:48 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	rruigrok@codeaurora.org, harba@codeaurora.org,
	Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
	wei@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Leo Duran <leo.duran@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Message-ID: <20160811105848.GA25680@red-moon>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
 <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
 <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 11, 2016 at 06:22:03PM +0800, Fu Wei wrote:
> Hi Hanjun, Tomasz,
> 
> On 11 August 2016 at 18:15, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > Hi,
> >
> > On 2016/8/11 17:37, Tomasz Nowicki wrote:
> >>
> >> Hi Fu,
> >>
> >> Do you mind if I send IORT series where new drivers/acpi/arm64 directory
> >> would be introduced in first place ? This means your GTDT set would
> >> depend on IORT.
> >
> >
> > I think it's reasonable as the IORT for ITS is the key device enablement
> > for PCI MSI. I talked to Fuwei offline and he is fine with it.
> 
> That's no problem at all, will do.
> 
> Can I do this:
> (1)apply Tomasz's v8 patchset on the master branch of upstream kernel
> (2)rebase my v10 on the top of Tomasz's v8
> (3)git format-patch as v11, repost it
> 
> Is that OK for everyone? :-)

I do not think you need a v11 just to remove the drivers/acpi/arm64
directory creation, you need to get Daniel/Thomas review/ack on
the respective patches though, I do not see the point of churning
out another series just because drivers/acpi/arm64 is now created
in the IORT patch series. If v10 is ok you will rebase it on top of
Tomasz's series and mention the dependency in the respective pull
request.

If there is need for a v11 following Daniel/Thomas review yes,
you can proceed as above.

Lorenzo
