Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53416 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbFCT30 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Jun 2015 15:29:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org,
	ashwin.chaugule@linaro.org, vgandhi@codeaurora.org, wim@iguana.be,
	jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
	rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
Date: Wed, 03 Jun 2015 21:29:12 +0200
Message-ID: <7870088.TdP6RHCoCB@wuerfel>
In-Reply-To: <556F4D29.1080001@codeaurora.org>
References: <=fu.wei@linaro.org> <20150603182503.GD6460@roeck-us.net> <556F4D29.1080001@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 03 June 2015 13:53:29 Timur Tabi wrote:
> On 06/03/2015 01:25 PM, Guenter Roeck wrote:
> > In general the idea here would be to use a crashdump kernel, which,
> > when loaded, would reset the watchdog before it fires. This kernel
> > would then write a core dump to a specified location.
> 
> What is the mechanism for resetting the watchdog?  The only code that 
> knows about the hardware registers is this driver.  Does the crashdump 
> kernel call the watchdog stop function?

It might or might not, depending on what you want to achieve. In most
cases, I'd expect the crashdump kernel to have it enabled if we want
to let the user set a pretimeout, but that is a policy question that
is not for the kernel to decide.

> > If arm64 doesn't support a crashdump kernel, it might still be possible
> > to log the backtrace somewhere (eg in nvram using pstore if that is
> > supported via acpi or efi).
> 
> I think it's expected that the firmware support a crash dump mechanism 
> of some kind.  But if we're talking about firmware support, then why 
> bother with the panic() in the first place?

panic() is what triggers all the crash dump or pstore mechanisms, it
has to do that anyway.

> > Is there reason to believe that this all won't work on arm64 ?
> 
> No, but I'm still trying to figure out why pre-timeout is valuable.  If 
> we don't disable WS1, then we risk having the hardware reset before we 
> can take advantage of what the panic() offers.  In which case, what's 
> the point of pre-timeout?

The timeouts are both configurable, so the sysadmin has to make sure that
the time between them is long enough to do whatever is necessary.

	Arnd
