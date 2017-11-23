Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47043 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbdKWRIP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 23 Nov 2017 12:08:15 -0500
Subject: Re: [RFC v8 2/7] platform/x86: intel_pmc_ipc: Use MFD framework to
 create dependent devices
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, lee.jones@linaro.org, andy@infradead.org,
        souvik.k.chakravarty@intel.com, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d7b0fadb708a50e6d9ccf92f106d6939314ccf0f.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20171123114927.GC17418@kuha.fi.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3c5f1a99-5cc5-fe51-fc99-596b0f792978@roeck-us.net>
Date: Thu, 23 Nov 2017 09:08:11 -0800
MIME-Version: 1.0
In-Reply-To: <20171123114927.GC17418@kuha.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/23/2017 03:49 AM, Heikki Krogerus wrote:
> Hi,
> 
> On Sun, Oct 29, 2017 at 02:49:55AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently, we have lot of repetitive code in dependent device resource
>> allocation and device creation handling code. This logic can be improved if
>> we use MFD framework for dependent device creation. This patch adds this
>> support.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel_pmc_ipc.c | 398 ++++++++++++-----------------------
>>   1 file changed, 139 insertions(+), 259 deletions(-)
>>
>> Changes since v7:
>>   * Fixed style issues.
>>
>> Changes since v6:
>>   * Fixed style issues.
>>   * Used Andy's modified version.
>>
>> Changes since v5:
>>   * Changed the order of patches in this patchlist.
>>
>> Changes since v4:
>>   * Changed the order of patches in this patchlist.
>>
>> Changes since v3:
>>   * Changed PLATFORM_DEVID_AUTO to PLATFORM_DEVID_NONE in mfd device creation.
>>   * Fixed error in resource initalization logic in ipc_create_punit_device.
>>   * Removed mfd cell id initialization.
>>
>> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
>> index e03fa314..e36144c 100644
>> --- a/drivers/platform/x86/intel_pmc_ipc.c
>> +++ b/drivers/platform/x86/intel_pmc_ipc.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/errno.h>
>>   #include <linux/init.h>
>>   #include <linux/device.h>
>> +#include <linux/mfd/core.h>
>>   #include <linux/pm.h>
>>   #include <linux/pci.h>
>>   #include <linux/platform_device.h>
>> @@ -88,6 +89,7 @@
>>   #define PLAT_RESOURCE_ISP_IFACE_INDEX	5
>>   #define PLAT_RESOURCE_GTD_DATA_INDEX	6
>>   #define PLAT_RESOURCE_GTD_IFACE_INDEX	7
>> +#define PLAT_RESOURCE_MEM_MAX_INDEX	8
>>   #define PLAT_RESOURCE_ACPI_IO_INDEX	0
>>   
>>   /*
>> @@ -106,8 +108,6 @@
>>   #define TELEM_SSRAM_SIZE		240
>>   #define TELEM_PMC_SSRAM_OFFSET		0x1B00
>>   #define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
>> -#define TCO_PMC_OFFSET			0x8
>> -#define TCO_PMC_SIZE			0x4
>>   
>>   /* PMC register bit definitions */
>>   
>> @@ -124,26 +124,10 @@ static struct intel_pmc_ipc_dev {
>>   	int cmd;
>>   	struct completion cmd_complete;
>>   
>> -	/* The following PMC BARs share the same ACPI device with the IPC */
>> -	resource_size_t acpi_io_base;
>> -	int acpi_io_size;
>> -	struct platform_device *tco_dev;
>> -
>>   	/* gcr */
>>   	void __iomem *gcr_mem_base;
>>   	bool has_gcr_regs;
>>   	spinlock_t gcr_lock;
>> -
>> -	/* punit */
>> -	struct platform_device *punit_dev;
>> -
>> -	/* Telemetry */
>> -	resource_size_t telem_pmc_ssram_base;
>> -	resource_size_t telem_punit_ssram_base;
>> -	int telem_pmc_ssram_size;
>> -	int telem_punit_ssram_size;
>> -	u8 telem_res_inval;
>> -	struct platform_device *telemetry_dev;
>>   } ipcdev;
>>   
>>   static char *ipc_err_sources[] = {
>> @@ -508,7 +492,7 @@ static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	ret = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_pmc_ipc",
>>   				pmc);
>>   	if (ret) {
>> -		dev_err(&pdev->dev, "Failed to request irq\n");
>> +		dev_err(&pdev->dev, "Failed to request IRQ\n");
>>   		return ret;
>>   	}
>>   
>> @@ -593,44 +577,6 @@ static const struct attribute_group intel_ipc_group = {
>>   	.attrs = intel_ipc_attrs,
>>   };
>>   
>> -static struct resource punit_res_array[] = {
>> -	/* Punit BIOS */
>> -	{
>> -		.flags = IORESOURCE_MEM,
>> -	},
>> -	{
>> -		.flags = IORESOURCE_MEM,
>> -	},
>> -	/* Punit ISP */
>> -	{
>> -		.flags = IORESOURCE_MEM,
>> -	},
>> -	{
>> -		.flags = IORESOURCE_MEM,
>> -	},
>> -	/* Punit GTD */
>> -	{
>> -		.flags = IORESOURCE_MEM,
>> -	},
>> -	{
>> -		.flags = IORESOURCE_MEM,
>> -	},
>> -};
>> -
>> -#define TCO_RESOURCE_ACPI_IO		0
>> -#define TCO_RESOURCE_SMI_EN_IO		1
>> -#define TCO_RESOURCE_GCR_MEM		2
>> -static struct resource tco_res[] = {
>> -	/* ACPI - TCO */
>> -	{
>> -		.flags = IORESOURCE_IO,
>> -	},
>> -	/* ACPI - SMI */
>> -	{
>> -		.flags = IORESOURCE_IO,
>> -	},
>> -};
>> -
>>   static struct itco_wdt_platform_data tco_info = {
>>   	.name = "Apollo Lake SoC",
>>   	.version = 5,
>> @@ -638,234 +584,177 @@ static struct itco_wdt_platform_data tco_info = {
>>   	.update_no_reboot_bit = update_no_reboot_bit,
>>   };
>>   
>> -#define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
>> -#define TELEMETRY_RESOURCE_PMC_SSRAM	1
>> -static struct resource telemetry_res[] = {
>> -	/*Telemetry*/
>> -	{
>> -		.flags = IORESOURCE_MEM,
>> -	},
>> -	{
>> -		.flags = IORESOURCE_MEM,
>> -	},
>> -};
>> -
>> -static int ipc_create_punit_device(void)
>> +static int ipc_create_punit_device(struct platform_device *pdev)
>>   {
>> -	struct platform_device *pdev;
>> -	const struct platform_device_info pdevinfo = {
>> -		.parent = ipcdev.dev,
>> -		.name = PUNIT_DEVICE_NAME,
>> -		.id = -1,
>> -		.res = punit_res_array,
>> -		.num_res = ARRAY_SIZE(punit_res_array),
>> +	struct resource punit_res[PLAT_RESOURCE_MEM_MAX_INDEX];
>> +	struct mfd_cell punit_cell;
>> +	struct resource *res;
> 
> That's where you have the bug I reported earlier. You would need to
> introduce those structures as static struct..
> 
> But instead of fixing those, drop them and introduce the resources and
> the cells out side of these functions:
> 
> static struct resource punit_resources[PLAT_RESOURCE_MEM_MAX_INDEX];
> static struct resource telemetry_resources[2];
> static struct resource wdt_resources[2];
> 
> static struct mfd_cell pmc_cell[] = {
>          {
>                  .name = "intel_punit_ipc",
>                  .resources = punit_resources,
>                  .num_resources = PLAT_RESOURCE_MEM_MAX_INDEX,
>                  .ignore_resource_conflicts = true,
>          },
>          {
>                  .name = "intel_telemetry",
>                  .resources = telemetry_resources,
>                  .num_resources = 2,
>                  .ignore_resource_conflicts = true,
>          },
>          {
>                  .name = "iTCO_wdt",
>                  .resources = wdt_resources,
>                  .num_resources = 2,
>                  .ignore_resource_conflicts = true,
>                  .platform_data = &tco_info,
>                  .pdata_size = sizeof(tco_info),
>          },
> };
> 
> Note that I'm not using the definitions for the name strings on
> purpose. Please get rid of those definitions while at it.
> 
> Use these functions - ipc_create_punit/wdt/telemetry_device() - to just
> collect the resources. Then you call devm_mfd_add_devices() only ones
> in ipc_create_pmc_devices(). That should make this driver a bit more
> easier to read and understand.
> 
>> +	int mindex, pindex = 0;
>> +
>> +	for (mindex = 0; mindex <= PLAT_RESOURCE_MEM_MAX_INDEX; mindex++) {
>> +
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, mindex);
>> +
>> +		switch (mindex) {
>> +		/* Get PUNIT resources */
>> +		case PLAT_RESOURCE_BIOS_DATA_INDEX:
>> +		case PLAT_RESOURCE_BIOS_IFACE_INDEX:
>> +			/* BIOS resources are required, so return error if not
>> +			 * available
>> +			 */
>> +			if (!res) {
>> +				dev_err(&pdev->dev,
>> +					"Failed to get PUNIT MEM resource %d\n",
>> +					pindex);
>> +				return -ENXIO;
>> +			}
>> +		case PLAT_RESOURCE_ISP_DATA_INDEX:
>> +		case PLAT_RESOURCE_ISP_IFACE_INDEX:
>> +		case PLAT_RESOURCE_GTD_DATA_INDEX:
>> +		case PLAT_RESOURCE_GTD_IFACE_INDEX:
>> +			/* if valid resource found, copy the resource to PUNIT
>> +			 * resource
>> +			 */
>> +			if (res)
>> +				memcpy(&punit_res[pindex], res, sizeof(*res));
>> +			punit_res[pindex].flags = IORESOURCE_MEM;
>> +			dev_dbg(&pdev->dev, "PUNIT memory res: %pR\n",
>> +				&punit_res[pindex]);
> 
> I don't see how is that useful information?
> 
>> +			pindex++;
>> +			break;
>>   		};
>> +	}
>>   
>> -	pdev = platform_device_register_full(&pdevinfo);
>> -	if (IS_ERR(pdev))
>> -		return PTR_ERR(pdev);
>> -
>> -	ipcdev.punit_dev = pdev;
>> +	/* Create PUNIT IPC MFD cell */
>> +	punit_cell.name = PUNIT_DEVICE_NAME;
>> +	punit_cell.num_resources = ARRAY_SIZE(punit_res);
>> +	punit_cell.resources = punit_res;
>> +	punit_cell.ignore_resource_conflicts = 1;
>>   
>> -	return 0;
>> +	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
>> +				    &punit_cell, 1, NULL, 0, NULL);
>>   }
>>   
>> -static int ipc_create_tco_device(void)
>> +static int ipc_create_wdt_device(struct platform_device *pdev)
>>   {
>> -	struct platform_device *pdev;
>> +	static struct resource wdt_ipc_res[2];
>>   	struct resource *res;
>> -	const struct platform_device_info pdevinfo = {
>> -		.parent = ipcdev.dev,
>> -		.name = TCO_DEVICE_NAME,
>> -		.id = -1,
>> -		.res = tco_res,
>> -		.num_res = ARRAY_SIZE(tco_res),
>> -		.data = &tco_info,
>> -		.size_data = sizeof(tco_info),
>> -		};
>> +	static struct mfd_cell wdt_cell;
>>   
>> -	res = tco_res + TCO_RESOURCE_ACPI_IO;
>> -	res->start = ipcdev.acpi_io_base + TCO_BASE_OFFSET;
>> -	res->end = res->start + TCO_REGS_SIZE - 1;
>> +	/* If we have ACPI based watchdog use that instead, othewise create
>> +	 * a MFD cell for iTCO watchdog
>> +	 */
>> +	if (acpi_has_watchdog())
>> +		return 0;
>>   
>> -	res = tco_res + TCO_RESOURCE_SMI_EN_IO;
>> -	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
>> -	res->end = res->start + SMI_EN_SIZE - 1;
>> +	/* Get iTCO watchdog resources */
>> +	res = platform_get_resource(pdev, IORESOURCE_IO,
>> +				    PLAT_RESOURCE_ACPI_IO_INDEX);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "Failed to get WDT resource\n");
>> +		return -ENXIO;
>> +	}
>>   
>> -	pdev = platform_device_register_full(&pdevinfo);
>> -	if (IS_ERR(pdev))
>> -		return PTR_ERR(pdev);
>> +	wdt_ipc_res[0].start = res->start + TCO_BASE_OFFSET;
>> +	wdt_ipc_res[0].end = res->start +
>> +		TCO_BASE_OFFSET + TCO_REGS_SIZE - 1;
>> +	wdt_ipc_res[0].flags = IORESOURCE_IO;
>> +	wdt_ipc_res[1].start = res->start + SMI_EN_OFFSET;
>> +	wdt_ipc_res[1].end = res->start +
>> +		SMI_EN_OFFSET + SMI_EN_SIZE - 1;
>> +	wdt_ipc_res[1].flags = IORESOURCE_IO;
>>   
>> -	ipcdev.tco_dev = pdev;
>> +	dev_dbg(&pdev->dev, "watchdog res 0: %pR\n", &wdt_ipc_res[0]);
>> +	dev_dbg(&pdev->dev, "watchdog res 1: %pR\n", &wdt_ipc_res[1]);
> 
> That definitely is not useful information. Please drop all dev_dbg
> calls from these patches.
> 
>> -	return 0;
>> +	wdt_cell.name = TCO_DEVICE_NAME;
>> +	wdt_cell.platform_data = &tco_info;
>> +	wdt_cell.pdata_size = sizeof(tco_info);
>> +	wdt_cell.num_resources = ARRAY_SIZE(wdt_ipc_res);
>> +	wdt_cell.resources = wdt_ipc_res;
>> +	wdt_cell.ignore_resource_conflicts = 1;
>> +
>> +	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
>> +				    &wdt_cell, 1, NULL, 0, NULL);

Whatever you do, don't tell the mfd maintainer that you are doing this.
You are not supposed to call mfd functions from outside the mfd directory.

Guenter

>>   }
>>   
>> -static int ipc_create_telemetry_device(void)
>> +static int ipc_create_telemetry_device(struct platform_device *pdev)
>>   {
>> -	struct platform_device *pdev;
>> +	struct resource telemetry_ipc_res[2];
>> +	struct mfd_cell telemetry_cell;
> 
> This is also broken. I'm attaching a diff with the changes to this
> patch I used when I tested this on my Broxton board.
> 
> 
> Thanks,
> 

