Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45498 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbbJ3TF1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 15:05:27 -0400
Date: Fri, 30 Oct 2015 19:05:14 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Timur Tabi <timur@codeaurora.org>
Cc: Fu Wei <fu.wei@linaro.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v8 1/5] Documentation: add sbsa-gwdt driver documentation
Message-ID: <20151030190514.GD30791@leverpostej>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-2-git-send-email-fu.wei@linaro.org>
 <20151027162257.GJ3091@leverpostej>
 <CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com>
 <CAOZdJXVan3xaYAS_+150nDO1ogWh+PtkQAZvwrHusJhY4R1a4A@mail.gmail.com>
 <CADyBb7sPqsoQdYBUpHY2HvZ+iT7ABa9NoCX7Jax1NKugYOy1zQ@mail.gmail.com>
 <5633BCA4.1050400@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5633BCA4.1050400@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 30, 2015 at 01:53:24PM -0500, Timur Tabi wrote:
> On 10/30/2015 01:35 PM, Fu Wei wrote:
> >>I think maybe Mark was asking why WS1 is optional, not the WS1
> >My answer is for "why WS1 is optional"!
> >
> >>>interrupt.  Maybe you can reword the documentation to make is clear
> >>>that
> >I didn't say : "only the*interrupt*  for WS1 is optional."
> 
> WS1 itself is not optional.  The spec says that WS0 and WS1 are
> separate events, and doesn't saying anything about either being
> optional.  The *interrupt* for WS1, however, is optional.

This is a moot point. The distintion between the signal and the
interrupt doens't matter here.

I was only asking why the interrupt was optional, and it seems per the
spec it's expected to be handed to an agent at a higher exception level.

That implies that the OS should only care about WS0, assuming that I've
understood correctly.

Thanks,
Mark.
