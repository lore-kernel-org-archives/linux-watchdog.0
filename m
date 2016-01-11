Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38506 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbcAKLZx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jan 2016 06:25:53 -0500
Received: by mail-wm0-f45.google.com with SMTP id b14so263027916wmb.1
        for <linux-watchdog@vger.kernel.org>; Mon, 11 Jan 2016 03:25:53 -0800 (PST)
Subject: Re: arm/arm64 HARDLOCKUP Detector and PERF NMI support
To: Mark Rutland <mark.rutland@arm.com>,
	Mario Smarduch <m.smarduch@samsung.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>
References: <569199C0.9030500@samsung.com> <5691A23C.8060807@samsung.com>
 <20160111102658.GB6499@leverpostej>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	wim@iguana.be, Christoffer Dall <christoffer.dall@linaro.org>,
	linux-watchdog@vger.kernel.org
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <5693913D.5060308@linaro.org>
Date: Mon, 11 Jan 2016 11:25:49 +0000
MIME-Version: 1.0
In-Reply-To: <20160111102658.GB6499@leverpostej>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/01/16 10:26, Mark Rutland wrote:
> Hi,
>
> On Sat, Jan 09, 2016 at 04:13:48PM -0800, Mario Smarduch wrote:
>> I'm trying to get HARDLOCKUP detector to work on arm (on foundation
>> model and Juno, but armv7 should have the same issue). Turns out there is no
>> PERF NMI support (HAVE_PERF_EVENTS_NMI), which I guess would be PMU NMI - I
>> tested overflow on cycle counter and PMU interrupts can be masked. HARDLOCKUP
>> assumes perf interrupts are non-maskable and uses the PMU to program an NMI to
>> detect hard lockup and that in turn drives softlockup detection.
>>
>> Is there something, someplace in ARM manuals that addresses this, searched the
>> manuals but couldn't find anything?
>>
>> Or other approaches that I'm not aware off or have floated on the mailing list.
>
> Russell and Daniel did some work [1,2] to use FIQs as NMIs on arm, for
> backtracing and PMU overflow.
 >
> For arm64 the kernel always runs on the non-secure side, so we don't
> expect to have access to FIQ. It's possible to implement NMIs using
> priorities (which it looks like Daniel was looking into [3]).

Thanks Mark.

The blog post is still pretty much describes my ambitions and the 
benefits these features can bring. It also has a link to a fairly 
elderly kernel that contains all the features fully integrated.

There are more patchsets for both ARM (if/f FIQ is available) and ARM64 
(if/f device has GICv3). However these only provide NMI backtrace.

arm:   http://thread.gmane.org/gmane.linux.kernel/2112583

arm64: http://thread.gmane.org/gmane.linux.kernel/2037735 (Mark's
        link to my git repo is more up to date than this patchset)

To get the hard lockup and profiling support upstream then my old code 
to integrate NMIs into the irq subsystem (which was just a cut down 
clone of the existing irq infrastructure) needs to be redesigned. 
However I decided to put the rewrite on ice until I get the foundational 
patches right.


Daniel.
