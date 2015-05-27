Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51958 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbbE0KoO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 May 2015 06:44:14 -0400
Date: Wed, 27 May 2015 11:44:08 +0100
From: Will Deacon <will.deacon@arm.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tekkamanninja@gmail.com" <tekkamanninja@gmail.com>,
	"graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
	"al.stone@linaro.org" <al.stone@linaro.org>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"timur@codeaurora.org" <timur@codeaurora.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"vgandhi@codeaurora.org" <vgandhi@codeaurora.org>,
	"wim@iguana.be" <wim@iguana.be>, "jcm@redhat.com" <jcm@redhat.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH v3 6/6] ACPI: import watchdog info of GTDT into platform
 device
Message-ID: <20150527104408.GB29002@arm.com>
References: <=fu.wei@linaro.org>
 <1432548193-19569-1-git-send-email-fu.wei@linaro.org>
 <1432548193-19569-7-git-send-email-fu.wei@linaro.org>
 <20150526122858.GJ1565@arm.com>
 <CAJ5Y-eZfzrDtEL5gpZ1rRNUhr2dCZKuA-MMNcwV=TgFW_9rq=g@mail.gmail.com>
 <20150526151842.GP1565@arm.com>
 <20150526153613.GA22487@roeck-us.net>
 <CADyBb7uMh3vKktXa1VJJdchcCQPyOuZ=5ztxoujjyjmxWGhq5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7uMh3vKktXa1VJJdchcCQPyOuZ=5ztxoujjyjmxWGhq5w@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 26, 2015 at 05:27:33PM +0100, Fu Wei wrote:
> On 26 May 2015 at 23:36, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, May 26, 2015 at 04:18:42PM +0100, Will Deacon wrote:
> >> Sure, the device it describes may only ever exist on ARM systems, but by
> >> that logic then we should be moving lots of drivers back under arch/arm[64].
> >>
> > It is nt the driver, but its instantiation. The question here would be
> > how and where to instantiate the driver, not where the driver itself
> > is located. The driver itself is ACPI agnostic.
> 
> I really don't mind to refactor the code, If we can make this patch better.
> 
> But for now, I can't see the good reason to move ACPI-relevant code
> into a watchdog driver.

I don't really mind where you move it, just as long as it's outside of
arch/arm64.

> The reasons I put the code here are
> (1)SBSA watchdog only for ARM64
> (2)GTDT only for ARM, design for ARM,
> (3)For ARM Architecture, only ARM64 support ACPI.
> 
> For minimizing arch/arm64/kernel/acpi.c, we can't put the code here,
> and we had better keep these code outside the driver,
> 
> So do you have any suggestion for the better location of the GTDT code?

I don't understand why you can't do the same as
drivers/clocksource/arm_arch_timer.c and parse the table directly in the
driver. If there are objections from the driver/subsystem maintainers then
it sounds like we need a mechanical ACPI table -> platform device
conversion in the core, like we have for device-tree.

Will
