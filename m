Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:59085 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527AbcAJAXx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 9 Jan 2016 19:23:53 -0500
Received: from uscpsbgex1.samsung.com
 (u122.gpu85.samsung.co.kr [203.254.195.122]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O0P00ENDNB2YO60@mailout1.w2.samsung.com> for
 linux-watchdog@vger.kernel.org; Sat, 09 Jan 2016 19:13:50 -0500 (EST)
Subject: arm/arm64 HARDLOCKUP Detector and PERF NMI support
References: <569199C0.9030500@samsung.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, mark.rutland@arm.com,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
From: Mario Smarduch <m.smarduch@samsung.com>
Cc: wim@iguana.be, Christoffer Dall <christoffer.dall@linaro.org>,
	linux-watchdog@vger.kernel.org
Message-id: <5691A23C.8060807@samsung.com>
Date: Sat, 09 Jan 2016 16:13:48 -0800
MIME-version: 1.0
In-reply-to: <569199C0.9030500@samsung.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I'm trying to get HARDLOCKUP detector to work on arm (on foundation
model and Juno, but armv7 should have the same issue). Turns out there is no
PERF NMI support (HAVE_PERF_EVENTS_NMI), which I guess would be PMU NMI - I
tested overflow on cycle counter and PMU interrupts can be masked. HARDLOCKUP
assumes perf interrupts are non-maskable and uses the PMU to program an NMI to
detect hard lockup and that in turn drives softlockup detection.

Is there something, someplace in ARM manuals that addresses this, searched the
manuals but couldn't find anything?

Or other approaches that I'm not aware off or have floated on the mailing list.

It's a pretty important feature for some environments.

- Mario





