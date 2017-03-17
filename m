Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7916 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdCQRaf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 13:30:35 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 3/4] watchdog: iTCO_wdt: Fix PMC GCR memory mapping
 failure
References: <b89221c652d06c3c07fdf2ec32fd4fc8930c64df.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2c41b3b6344f9cb455ac57e1e41aa229adb2867d.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170317114313.GE24582@rajaneesh-OptiPlex-9010>
 <0a68f91f-e396-90aa-8337-cad3aa28a0f7@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        david.e.box@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        wim@iguana.be
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b0d660b8-219a-ebd7-e7c4-cdd261e5a081@linux.intel.com>
Date: Fri, 17 Mar 2017 10:24:35 -0700
MIME-Version: 1.0
In-Reply-To: <0a68f91f-e396-90aa-8337-cad3aa28a0f7@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 03/17/2017 06:40 AM, Guenter Roeck wrote:
> On 03/17/2017 04:43 AM, Rajneesh Bhardwaj wrote:
>> On Thu, Mar 16, 2017 at 05:41:35PM -0700, Kuppuswamy Sathyanarayanan 
>> wrote:
>>> Currently, iTCO watchdog driver uses memory map to access
>>> PMC_CFG GCR register. But the entire GCR address space is
>>> already mapped in intel_scu_ipc driver. So remapping the
>>
>> intel_pmc_ipc driver.
>>
>>> GCR register in this driver causes the mem request failure in
>>> iTCO_wdt probe function. This patch fixes this issue by
>>> using PMC GCR read/write API's to access PMC_CFG register.
>>>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan 
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>>  drivers/watchdog/iTCO_wdt.c | 31 +++++++------------------------
>>>  1 file changed, 7 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
>>> index 3d0abc0..31abfc5 100644
>>> --- a/drivers/watchdog/iTCO_wdt.c
>>> +++ b/drivers/watchdog/iTCO_wdt.c
>>> @@ -68,6 +68,8 @@
>>>  #include <linux/io.h>            /* For inb/outb/... */
>>>  #include <linux/platform_data/itco_wdt.h>
>>>
>>> +#include <asm/intel_pmc_ipc.h>
>>> +
>>>  #include "iTCO_vendor.h"
>>>
>>>  /* Address definitions for the TCO */
>>> @@ -94,12 +96,6 @@ struct iTCO_wdt_private {
>>>      unsigned int iTCO_version;
>>>      struct resource *tco_res;
>>>      struct resource *smi_res;
>>> -    /*
>>> -     * NO_REBOOT flag is Memory-Mapped GCS register bit 5 (TCO 
>>> version 2),
>>> -     * or memory-mapped PMC register bit 4 (TCO version 3).
>>> -     */
>>
>> Better to retain this comment elsewhere.
>>
>>> -    struct resource *gcs_pmc_res;
>>> -    unsigned long __iomem *gcs_pmc;
>>>      /* the lock for io operations */
>>>      spinlock_t io_lock;
>>>      /* the PCI-device */
>>> @@ -176,9 +172,9 @@ static void iTCO_wdt_set_NO_REBOOT_bit(struct 
>>> iTCO_wdt_private *p)
>>>
>>>      /* Set the NO_REBOOT bit: this disables reboots */
>>>      if (p->iTCO_version >= 2) {
>>> -        val32 = readl(p->gcs_pmc);
>>> +        val32 = intel_pmc_gcr_read(PMC_GCR_PMC_CFG_REG);
>>
>> better to have protection and error handling, discussed in v2, 2/4.
>>
>> compiled and tested this on APL and i see iTCO_WDT driver loads fine. 
>> Since
>> it impacts core WDT functionality, need to be thoroughly tested on 
>> various
>> platforms.
>>
>
> I don't think I (or the watchdog mailing list) was copied on the 
> original patch.
Sorry. Its my mistake. I will fix it in next series update.
> Major immediate concern is that this introduces a dependency on 
> external code.
> The pmc_ipc driver's Kconfig entry states "This is not needed for PC-type
> machines". I don't know where the function is introduced, but I hope 
> this change
> does not require the pmc_ipc code to be present on such machines for 
> the watchdog
> to work. It would be bad if it does. If it doesn't, it appears that 
> the function
> should not be declared in asm/intel_pmc_ipc.h.
It should not create any compile time dependency with INTEL_PMC_IPC 
config option. If INTEL_PMC_IPC_CONFIG is disabled, we use
empty definitions for these calls defined in asm/intel_pmc_ipc.h

But iTCO_wdt driver already has runtime dependency with INTEL_PMIC_IPC 
if its version iTCO_version >= 2.

>
> Guenter
>
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

