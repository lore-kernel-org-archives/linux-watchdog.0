Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:42361 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbBYO2L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Feb 2015 09:28:11 -0500
Received: by wesw62 with SMTP id w62so3935788wes.9
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Feb 2015 06:28:09 -0800 (PST)
Date: Wed, 25 Feb 2015 14:28:06 +0000
From: Peter Griffin <peter.griffin@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
	kernel@stlinux.com, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, wim@iguana.be, linux@roeck-us.net,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH v3 7/8] rtc: st: add new driver for ST's
 LPC RTC
Message-ID: <20150225142806.GA2160@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
 <1424260154-12868-8-git-send-email-lee.jones@linaro.org>
 <20150223101223.GA14142@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150225111910.GX8656@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150225111910.GX8656@n2100.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Russell,

On Wed, 25 Feb 2015, Russell King - ARM Linux wrote:

> On Mon, Feb 23, 2015 at 10:12:23AM +0000, Peter Griffin wrote:
> > I think all the writel IO accessors in this driver can be replaced
> > with the *_relaxed variant. This will avoid the overhead of taking a
> > spinlock in the l2 outer cache part of writel.
> 
> You're really operating on old information.  With much improved L2 cache
> support code which went in a year or so ago, for the popular L2 cache
> controllers, we don't take a spinlock anymore - we just write to the
> register directly.
> 
> The spinlock is only present for L2C-220 controllers, which are rare.
> 
> Moreover, taking the spinlock is only expensive if you have things like
> lockdep enabled, otherwise it should be inline and will be fast.
> 
> However, using the _relaxed variants where we can get away with weaker
> ordering of the writes to the device is a good thing nevertheless.  I'm
> just pointing out that your reasoning above is wrong.

Thanks for pointing this out, I wasn't aware until now that the spinlock
had been removed.

regards

Peter.

