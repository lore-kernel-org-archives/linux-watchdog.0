Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54175 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbIKCGF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 10 Sep 2015 22:06:05 -0400
Date: Thu, 10 Sep 2015 19:05:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jon Masters <jcm@redhat.com>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	hanjun.guo@linaro.org, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
	wim@iguana.be, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
	rjw@rjwysocki.net, dyoung@redhat.com, panand@redhat.com
Subject: Re: [PATCH v7 5/8] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150911020555.GB15719@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
 <1440435683-7343-6-git-send-email-fu.wei@linaro.org>
 <55F20461.20904@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55F20461.20904@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Sep 10, 2015 at 06:29:53PM -0400, Jon Masters wrote:
> On 08/24/2015 01:01 PM, fu.wei@linaro.org wrote:
> 
> > +	/*
> > +	 * Get the frequency of system counter from the cp15 interface of ARM
> > +	 * Generic timer. We don't need to check it, because if it returns "0",
> > +	 * system would panic in very early stage.
> > +	 */
> > +	gwdt->clk = arch_timer_get_cntfrq();
> 
> Just thinking out loud...
> 
> What happens later if we virtualize this device within KVM/QEMU/Xen and
> then live migrate to another system in which the frequency changes?
> 
I don't know, but I would suspect that we might end up in all kinds of
trouble if clocks can change like that, and not just in this driver.
Many drivers make the assumption that clock rates are not changed
under the hood. If it can happen, shouldn't there be a callback into
the drivers using the affected clock(s) ?

Also, it seems to me that changing a clock like that would be inherently
unsafe. For example, what will happen if the system is stopped and migrated
right after the clock frequency is read, but before the returned value
is used ? Can that happen ? Or does it only happen during suspend/resume
cycles, if it happens ?

Thanks,
Guenter
