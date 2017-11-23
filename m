Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:43736 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751678AbdKWMaF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 23 Nov 2017 07:30:05 -0500
Date: Thu, 23 Nov 2017 14:29:58 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, lee.jones@linaro.org, andy@infradead.org,
        souvik.k.chakravarty@intel.com, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
Subject: Re: [RFC v8 3/7] platform/x86: intel_pmc_ipc: Use regmap calls for
 GCR updates
Message-ID: <20171123122958.GD17418@kuha.fi.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d071033be09d6902884cb81aa0e5a1e1b5d5fcb0.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d071033be09d6902884cb81aa0e5a1e1b5d5fcb0.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Oct 29, 2017 at 02:49:56AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> This patch adds support for regmap based implementation for GCR
> read/write/update APIs.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/platform/x86/Kconfig         |   1 +
>  drivers/platform/x86/intel_pmc_ipc.c | 122 +++++++++++++----------------------
>  2 files changed, 46 insertions(+), 77 deletions(-)
> 
> Changes since v7:
>  * Fixed style issues.
> 
> Changes since v6:
>  * None
> 
> Changes since v5:
>  * None
> 
> Changes since v4:
>  * None
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 80b8795..45f4e79 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1054,6 +1054,7 @@ config PVPANIC
>  config INTEL_PMC_IPC
>  	tristate "Intel PMC IPC Driver"
>  	depends on ACPI
> +	select REGMAP_MMIO
>  	---help---
>  	This driver provides support for PMC control on some Intel platforms.
>  	The PMC is an ARC processor which defines IPC commands for communication
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index e36144c..df6af1f 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -35,6 +35,8 @@
>  #include <linux/acpi.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/spinlock.h>
> +#include <linux/mfd/core.h>

You already included that in the previous patch.


Thanks,

-- 
heikki
