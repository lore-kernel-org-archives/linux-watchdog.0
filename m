Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35643 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbEGTzf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 15:55:35 -0400
Received: by wgyo15 with SMTP id o15so53988303wgy.2
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 12:55:34 -0700 (PDT)
Date: Thu, 7 May 2015 20:55:29 +0100
From: Peter Griffin <peter.griffin@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 06/12] watchdog: bindings: Supply
 knowledge of a third supported device - clocksource
Message-ID: <20150507195529.GA28554@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
 <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150507191909.GC16220@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150507191909.GC16220@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lee,

On Thu, 07 May 2015, Lee Jones wrote:

<snip>

> > >  Required properties
> > >  
> > > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > > -				  "st,stih415-lpc" "st,stid127-lpc"
> > > +- compatible 	: Must be one of: "st,stih407-lpc"
> > 
> > The same comment as the RTC DT patch, you are removing the compatibles
> > documentation for the other supported platforms like stih416-lpc.
> > AFAIK they are required in the driver to get the correct sysconfig register.
> 
> That's intentional.  I haven't yet tested any of this IP on
> STiH41{5,6} & STiH127.  Due to lack of documentation, I'm not even
> sure if this IP even exists on some of the other platforms.  I will
> add them back when support is added to both driver and DTB and I've
> been able to test them.

That was kind of my point, the driver code AFAIK already contains support
for these SoC's.

I would either expect the patch to remove support from the DT docs AND the
driver, or leave it as is.

It seems odd to only change the DT docs, and become unaligned to the
code (this assumes I'm looking at the latest patchset here 
https://lkml.org/lkml/2015/3/4/1088 which includes support for these SoCs).

regards,

Peter.

