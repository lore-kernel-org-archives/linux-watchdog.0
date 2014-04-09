Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:49815 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458AbaDIARi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Apr 2014 20:17:38 -0400
Message-ID: <5344919E.9030708@roeck-us.net>
Date: Tue, 08 Apr 2014 17:17:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: David Cohen <david.a.cohen@linux.intel.com>, wim@iguana.be,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
CC: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	gnomes@lxorguk.ukuu.org.uk, Eric Ernst <eric.ernst@intel.com>
Subject: Re: [PATCH 1/2] watchdog: add Intel MID watchdog driver support
References: <1396990744-10695-1-git-send-email-david.a.cohen@linux.intel.com> <1396990744-10695-2-git-send-email-david.a.cohen@linux.intel.com>
In-Reply-To: <1396990744-10695-2-git-send-email-david.a.cohen@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/08/2014 01:59 PM, David Cohen wrote:
> Add initial Intel MID watchdog driver support.
>
> This driver is an initial implementation of generic Intel MID watchdog
> driver. Currently it supports Intel Merrifield platform.

How does this compare with the existing SCU watchdog driver
(intel_scu_watchdog) ? The watchdog IPC message (0xf8) seems
to be the same, so there must be at least some overlap.
Would it be possible to have just one watchdog driver
serving the different SCU based devices ?

>
> Signed-off-by: Eric Ernst <eric.ernst@intel.com>
> Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
> ---
>   drivers/watchdog/Kconfig         |  12 +++
>   drivers/watchdog/Makefile        |   1 +
>   drivers/watchdog/intel-mid_wdt.c | 209 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 222 insertions(+)
>   create mode 100644 drivers/watchdog/intel-mid_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 79d25894343a..4da09b8b2f11 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -643,6 +643,18 @@ config INTEL_SCU_WATCHDOG
>
>   	  To compile this driver as a module, choose M here.
>
> +config INTEL_MID_WATCHDOG
> +	bool "Intel MID SCU Watchdog Mobile Platforms"
> +	depends on X86_INTEL_MID && WATCHDOG_CORE

All other watchdog drivers using the watchdog core use
	select WATCHDOG_CORE

so this one should do the same.

Guenter
