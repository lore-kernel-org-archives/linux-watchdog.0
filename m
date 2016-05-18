Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38204 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcEREDb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 May 2016 00:03:31 -0400
Subject: Re: [PATCH 2/2] x86: Fix Apollo Lake Watchdog address in PMC driver
To: "Yong, Jonathan" <jonathan.yong@intel.com>,
	linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
 <1463541972-19758-3-git-send-email-jonathan.yong@intel.com>
Cc: qipeng.zha@intel.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <573BE985.1000306@roeck-us.net>
Date: Tue, 17 May 2016 21:03:17 -0700
MIME-Version: 1.0
In-Reply-To: <1463541972-19758-3-git-send-email-jonathan.yong@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/17/2016 08:26 PM, Yong, Jonathan wrote:
> The TCO I/O base is 40h rather than the usual 30h, and the re_reboot
> bit is at ACPIBASE+8.
>

Does this mean that the code never worked, or in other words that it was never tested,
or are there now other chips which used the old definitions which no longer work
after this patch has been applied ?

> Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
> ---
>   drivers/platform/x86/intel_pmc_ipc.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index 6f497e8..b86e1bc 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -85,7 +85,7 @@
>    * platform device and to export resources for those functions.
>    */
>   #define TCO_DEVICE_NAME			"iTCO_wdt"
> -#define SMI_EN_OFFSET			0x30
> +#define SMI_EN_OFFSET			0x40
>   #define SMI_EN_SIZE			4
>   #define TCO_BASE_OFFSET			0x60
>   #define TCO_REGS_SIZE			16
> @@ -94,6 +94,8 @@
>   #define TELEM_SSRAM_SIZE		240
>   #define TELEM_PMC_SSRAM_OFFSET		0x1B00
>   #define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
> +#define TCO_PMC_OFFSET			0x8
> +#define TCO_PMC_SIZE			0x4
>
>   static const int iTCO_version = 3;
>
> @@ -502,7 +504,7 @@ static struct resource tco_res[] = {
>
>   static struct itco_wdt_platform_data tco_info = {
>   	.name = "Apollo Lake SoC",
> -	.version = 3,
> +	.version = 5,
>   };
>
>   #define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
> @@ -572,8 +574,8 @@ static int ipc_create_tco_device(void)
>   	res->end = res->start + SMI_EN_SIZE - 1;
>
>   	res = tco_res + TCO_RESOURCE_GCR_MEM;
> -	res->start = ipcdev.gcr_base;
> -	res->end = res->start + ipcdev.gcr_size - 1;
> +	res->start = ipcdev.gcr_base + TCO_PMC_OFFSET;
> +	res->end = res->start + TCO_PMC_SIZE - 1;
>
>   	ret = platform_device_add_resources(pdev, tco_res, ARRAY_SIZE(tco_res));
>   	if (ret) {
>

