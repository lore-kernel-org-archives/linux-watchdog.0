Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54021 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758964AbcAKK1U (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jan 2016 05:27:20 -0500
Date: Mon, 11 Jan 2016 10:26:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mario Smarduch <m.smarduch@samsung.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	wim@iguana.be, Christoffer Dall <christoffer.dall@linaro.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: arm/arm64 HARDLOCKUP Detector and PERF NMI support
Message-ID: <20160111102658.GB6499@leverpostej>
References: <569199C0.9030500@samsung.com>
 <5691A23C.8060807@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5691A23C.8060807@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Sat, Jan 09, 2016 at 04:13:48PM -0800, Mario Smarduch wrote:
> I'm trying to get HARDLOCKUP detector to work on arm (on foundation
> model and Juno, but armv7 should have the same issue). Turns out there is no
> PERF NMI support (HAVE_PERF_EVENTS_NMI), which I guess would be PMU NMI - I
> tested overflow on cycle counter and PMU interrupts can be masked. HARDLOCKUP
> assumes perf interrupts are non-maskable and uses the PMU to program an NMI to
> detect hard lockup and that in turn drives softlockup detection.
> 
> Is there something, someplace in ARM manuals that addresses this, searched the
> manuals but couldn't find anything?
> 
> Or other approaches that I'm not aware off or have floated on the mailing list.

Russell and Daniel did some work [1,2] to use FIQs as NMIs on arm, for
backtracing and PMU overflow.

For arm64 the kernel always runs on the non-secure side, so we don't
expect to have access to FIQ. It's possible to implement NMIs using
priorities (which it looks like Daniel was looking into [3]).

Thanks,
Mark.

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/353795/
[2] http://www.linaro.org/blog/core-dump/debugging-arm-kernels-using-nmifiq/
[3] https://git.linaro.org/people/daniel.thompson/linux.git/shortlog/refs/heads/dev/arm64_nmi-v5
