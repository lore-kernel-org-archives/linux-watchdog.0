Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:34051 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbbBYLT3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Feb 2015 06:19:29 -0500
Date: Wed, 25 Feb 2015 11:19:11 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
	kernel@stlinux.com, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, wim@iguana.be, linux@roeck-us.net,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH v3 7/8] rtc: st: add new driver for ST's
 LPC RTC
Message-ID: <20150225111910.GX8656@n2100.arm.linux.org.uk>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
 <1424260154-12868-8-git-send-email-lee.jones@linaro.org>
 <20150223101223.GA14142@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150223101223.GA14142@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 23, 2015 at 10:12:23AM +0000, Peter Griffin wrote:
> I think all the writel IO accessors in this driver can be replaced
> with the *_relaxed variant. This will avoid the overhead of taking a
> spinlock in the l2 outer cache part of writel.

You're really operating on old information.  With much improved L2 cache
support code which went in a year or so ago, for the popular L2 cache
controllers, we don't take a spinlock anymore - we just write to the
register directly.

The spinlock is only present for L2C-220 controllers, which are rare.

Moreover, taking the spinlock is only expensive if you have things like
lockdep enabled, otherwise it should be inline and will be fast.

However, using the _relaxed variants where we can get away with weaker
ordering of the writes to the device is a good thing nevertheless.  I'm
just pointing out that your reasoning above is wrong.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
