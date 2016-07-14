Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35002 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcGNUeH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2016 16:34:07 -0400
MIME-Version: 1.0
In-Reply-To: <1468432402-4872-5-git-send-email-fu.wei@linaro.org>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org> <1468432402-4872-5-git-send-email-fu.wei@linaro.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 14 Jul 2016 16:33:35 -0400
Message-ID: <CAP=VYLp0tfVehQkPquvDHx+GVUYPZw29u7w9HCaHKy+ND5Bj-Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	"tglx@linutronix.de" <tglx@linutronix.de>, marc.zyngier@arm.com,
	lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
	hanjun.guo@linaro.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linaro-acpi@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
	harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
	graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
	wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, wim@iguana.be,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	kvalo@codeaurora.org, mchehab@kernel.org, jslaby@suse.cz,
	christoffer.dall@linaro.org, julien.grall@arm.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 13, 2016 at 1:53 PM,  <fu.wei@linaro.org> wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patch adds support for parsing arch timer in GTDT,
> provides some kernel APIs to parse all the PPIs and
> always-on info in GTDT and export them.
>
> By this driver, we can simplify arm_arch_timer drivers, and
> separate the ACPI GTDT knowledge from it.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig           |   5 ++
>  drivers/acpi/Makefile          |   1 +
>  drivers/acpi/arm64/Kconfig     |  15 ++++
>  drivers/acpi/arm64/Makefile    |   1 +
>  drivers/acpi/arm64/acpi_gtdt.c | 170 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h           |   6 ++
>  6 files changed, 198 insertions(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index b7e2e77..1cdc7d2 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -521,4 +521,9 @@ config XPOWER_PMIC_OPREGION
>
>  endif
>
> +if ARM64
> +source "drivers/acpi/arm64/Kconfig"
> +
> +endif
> +
>  endif  # ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 251ce85..1a94ff7 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)     += acpi_extlog.o
>  obj-$(CONFIG_PMIC_OPREGION)    += pmic/intel_pmic.o
>  obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
>  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
> +obj-$(CONFIG_ARM64)    += arm64/
>
>  video-objs                     += acpi_video.o video_detect.o
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> new file mode 100644
> index 0000000..ff5c253
> --- /dev/null
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -0,0 +1,15 @@
> +#
> +# ACPI Configuration for ARM64
> +#
> +
> +menu "The ARM64-specific ACPI Support"
> +
> +config ACPI_GTDT
> +       bool "ACPI GTDT table Support"
> +       help
> +         GTDT (Generic Timer Description Table) provides information
> +         for per-processor timers and Platform (memory-mapped) timers
> +         for ARM platforms. Select this option to provide information
> +         needed for the timers init.
> +
> +endmenu
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> new file mode 100644
> index 0000000..466de6b
> --- /dev/null
> +++ b/drivers/acpi/arm64/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ACPI_GTDT)                += acpi_gtdt.o
> diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
> new file mode 100644
> index 0000000..9ee977d
> --- /dev/null
> +++ b/drivers/acpi/arm64/acpi_gtdt.c
> @@ -0,0 +1,170 @@
> +/*
> + * ARM Specific GTDT table Support
> + *
> + * Copyright (C) 2016, Linaro Ltd.
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *         Fu Wei <fu.wei@linaro.org>
> + *         Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Please do not use module.h in drivers that are using a
bool Kconfig setting.

Thanks,
Paul.
