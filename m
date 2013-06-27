Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:52779 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752933Ab3F0UUk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Jun 2013 16:20:40 -0400
Date: Thu, 27 Jun 2013 22:20:30 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, patches@linaro.org,
	marc.zyngier@arm.com, olof@lixom.net,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: delete mpcore_wdt driver
Message-ID: <20130627202030.GA30876@spo001.leaseweb.com>
References: <4b48e037462c7d74452618e631f6cf077b7ce5de.1371654384.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b48e037462c7d74452618e631f6cf077b7ce5de.1371654384.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Viresh,

> The only way this is usable is if a watchdog user binds to a particular CPU
> before opening this device, and remains bound to that user. But this doesn't fit
> the current watchdog model in linux.
> 
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
> ---
>  Documentation/watchdog/watchdog-parameters.txt |   8 -
>  arch/arm/configs/spear13xx_defconfig           |   1 -
>  drivers/watchdog/Kconfig                       |   9 -
>  drivers/watchdog/Makefile                      |   1 -
>  drivers/watchdog/mpcore_wdt.c                  | 456 -------------------------
>  5 files changed, 475 deletions(-)
>  delete mode 100644 drivers/watchdog/mpcore_wdt.c

Added patch to linux-watchdog-next.

Kind regards,
Wim.

