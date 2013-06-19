Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55868 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934645Ab3FSPvC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Jun 2013 11:51:02 -0400
Date: Wed, 19 Jun 2013 08:51:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux@arm.linux.org.uk, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, patches@linaro.org,
	marc.zyngier@arm.com, olof@lixom.net,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: delete mpcore_wdt driver
Message-ID: <20130619155100.GB29516@roeck-us.net>
References: <4b48e037462c7d74452618e631f6cf077b7ce5de.1371654384.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b48e037462c7d74452618e631f6cf077b7ce5de.1371654384.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 19, 2013 at 08:38:58PM +0530, Viresh Kumar wrote:
> The only way this is usable is if a watchdog user binds to a particular CPU
> before opening this device, and remains bound to that user. But this doesn't fit
> the current watchdog model in linux.
> 
Side note: not really true. The application can run on any CPU. The driver would
call on_each_cpu_mask() to execute the ping on the correct/expected CPU, or
on_each_cpu() if each CPU needs a ping. So this is more a matter of driver coding.

> Interrupt request doesn't use the right API: The TWD watchdog uses a per-cpu
> interrupt (usually interrupt #30), and the GIC configuration should flag it as
> such. With this setup, request_irq() should fail, and the right API is
> request_percpu_irq(), together with enable_percpu_irq()/disable_percpu_irq().
> 
> Nothing ensures the userspace ioctl() will end-up kicking the watchdog on the
> right CPU.
> 
> There are no users of this driver since a long time and it makes more sense to
> get rid of it as nobody is looking to fix it.
> 
> In case somebody wakes up after this has been removed and needs it, please
> revert this driver and pick these updates (These were never pushed to mainline):
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/245998
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>
