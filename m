Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [208.91.199.152] ([208.91.199.152]:34864 "EHLO
	bh-25.webhostbox.net" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752326AbbEZPg6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 11:36:58 -0400
Date: Tue, 26 May 2015 08:36:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Will Deacon <will.deacon@arm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	"fu.wei@linaro.org" <fu.wei@linaro.org>,
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
Message-ID: <20150526153613.GA22487@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432548193-19569-1-git-send-email-fu.wei@linaro.org>
 <1432548193-19569-7-git-send-email-fu.wei@linaro.org>
 <20150526122858.GJ1565@arm.com>
 <CAJ5Y-eZfzrDtEL5gpZ1rRNUhr2dCZKuA-MMNcwV=TgFW_9rq=g@mail.gmail.com>
 <20150526151842.GP1565@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150526151842.GP1565@arm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 26, 2015 at 04:18:42PM +0100, Will Deacon wrote:
> On Tue, May 26, 2015 at 04:02:56PM +0100, Ashwin Chaugule wrote:
> > On 26 May 2015 at 08:28, Will Deacon <will.deacon@arm.com> wrote:
> > > On Mon, May 25, 2015 at 11:03:13AM +0100, fu.wei@linaro.org wrote:
> > >> From: Fu Wei <fu.wei@linaro.org>
> > >>
> > >> Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
> > >> and create a platform device with that information.
> > >> This platform device can be used by the ARM SBSA Generic
> > >> Watchdog driver.
> > >>
> > >> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > >> Tested-by: Timur Tabi <timur@codeaurora.org>
> > >> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> > >> ---
> > >>  arch/arm64/kernel/acpi.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++
> > >>  1 file changed, 145 insertions(+)
> > >
> > > Why does this all need to be under arch/arm64? The GTDT really isn't
> > > architecture-specific, so I'd *much* rather it was parsed in the driver code
> > > itself, like we already do for the architected timer. The GIC is an
> > > exception because it's in the MADT, which we need to parse in the arch code
> > > to configure SMP properly.
> > 
> > I'm not really against refactoring the code. But the GTDT looks quite
> > specific to ARM..
> > 
> > ---8<----
> > 5.2.24 Generic Timer Description Table (GTDT)
> > This section describes the format of the Generic Timer Description
> > Table (GTDT), which provides
> > OSPM with information about a system’s Generic Timers configuration.
> > The Generic Timer (GT) is
> > a standard timer interface implemented on ARM processor-based systems.
> > The GT hardware
> > specification can be found at Links to ACPI-Related Documents
> > (http://uefi.org/acpi) under the
> > heading ARM Architecture. The GTDT provides OSPM with information
> > about a system's GT
> > interrupt configurations, for both per-processor timers, and platform
> > (memory-mapped) timers.
> > The GT specification defines the following per-processor timers:
> > • Secure privilege level 1 (EL1) timer,
> > • Non-Secure EL1 timer,
> > • Non-Secure privilege level 2 (EL2) timer,
> > • Virtual timer,
> > and the following Platform (memory-mapped) timers.
> > • GT Block
> > • Server Base System Architecture (SBSA) Generic Watchdog
> > ---8<----
> 
> Sure, the device it describes may only ever exist on ARM systems, but by
> that logic then we should be moving lots of drivers back under arch/arm[64].
> 
It is nt the driver, but its instantiation. The question here would be
how and where to instantiate the driver, not where the driver itself
is located. The driver itself is ACPI agnostic.

What you are really saying is that you want the driver instantiation
to be moved into the driver.

Guenter
