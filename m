Return-path: <thomas.petazzoni@free-electrons.com>
Date: Fri, 5 Feb 2016 14:33:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Timur Tabi <timur@codeaurora.org>
Cc: Fu Wei <fu.wei@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Rob
 Herring <robh+dt@kernel.org>, =?UTF-8?B?UGF3ZcWC?= Moll
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Wim Van
 Sebroeck <wim@iguana.be>, Jon Corbet <corbet@lwn.net>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Suravee
 Suthikulpanit <Suravee.Suthikulpanit@amd.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Linaro ACPI Mailman List
 <linaro-acpi@lists.linaro.org>, rruigrok@codeaurora.org, "Abdulhamid, Harb"
 <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Dave
 Young <dyoung@redhat.com>, Pratyush Anand <panand@redhat.com>, G Gregory
 <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Hanjun Guo
 <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>, Leo Duran <leo.duran@amd.com>, Sudeep Holla
 <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half
 timeout panic support
Message-ID: <20160205143318.2de2815c@free-electrons.com>
In-Reply-To: <56B49EC7.4050306@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
	<1454519923-25230-6-git-send-email-fu.wei@linaro.org>
	<56B23883.7000501@codeaurora.org>
	<CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
	<56B23E99.1030604@codeaurora.org>
	<CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
	<56B2423B.1020109@codeaurora.org>
	<CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
	<56B24642.8090105@codeaurora.org>
	<CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
	<56B24AB5.3070001@codeaurora.org>
	<CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
	<56B2DEE4.7060901@roeck-us.net>
	<CADyBb7unAHEOMfruWS82RkHK6uwPAWCxUx9jqzSkiHU4LHDSeA@mail.gmail.com>
	<20160205140259.72a33699@free-electrons.com>
	<56B49EC7.4050306@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

On Fri, 5 Feb 2016 07:08:23 -0600, Timur Tabi wrote:

> > I'm quite certainly missing something completely obvious here, but how
> > can you get the WS1 interrupt*after*  raising a panic? Aren't all
> > interrupts disabled and the system fully halted once you get a panic(),
> > especially when raised from an interrupt handler? If that's the case,
> > how can the system continue to do things, such as receiving the WS1
> > interrupt and resetting ?
> 
> Typically, WS1 is not an interrupt.  Instead, it's a hard system-level 
> reset.

Ah, right, true. I missed that aspect because on my HW, triggering a
system-level reset on WS1 is optional. I can actually get an interrupt
on both WS0 and WS1, and no reset at all.

But a normal configuration indeed involves having the WS1 event
configured in HW to be a system-level reset.

So, OK, it makes sense. Thanks for the clarification!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
