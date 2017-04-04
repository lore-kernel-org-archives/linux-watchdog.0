Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:1629 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754281AbdDDVgx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 17:36:53 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v4 1/5] platform/x86: intel_pmc_ipc: fix gcr offset
References: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
 <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vf3bq7cGUmi2Oi_TkvkCTzJ1QDmKUoTXmJgkgbxUE+UfA@mail.gmail.com>
 <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com>
 <CAHp75VdeZW6zAfoXsv6ZwQ9woyumj4s5n1ZSaPWoJQBdP5BNfw@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        David Box <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <3e7ca77c-2be5-5f89-f51f-faaca9f2d9ac@linux.intel.com>
Date: Tue, 4 Apr 2017 14:32:50 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VdeZW6zAfoXsv6ZwQ9woyumj4s5n1ZSaPWoJQBdP5BNfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 04/04/2017 06:25 AM, Andy Shevchenko wrote:
> Please, STOP top-posting.
>
> On Mon, Apr 3, 2017 at 4:51 AM, Sathyanarayanan Kuppuswamy Natarajan
> <sathyaosid@gmail.com> wrote:
>> Yes, just applying this patch will fix the existing offset issue.
> Then the question how it was tested in both cases (before this change and now) ?
iTCO_wdt is the only driver which uses this offset when calculating the 
address of PMC_CFG for setting/unsetting the no-reboot bit.

Without this change, instead of modifying the PMC_CFG(offset:0x1008) 
register, iTCO_wdt was modifying the address with offset 0x1010.
According to spec, offset 0x1010 is unused memory address. So modifying 
that area did not create any errors, but  its not functionally correct.

So with or without this change you will not see any error message. But 
its creating the functional issue of not modifying the no-reboot bit.

Currently, I tested this fix by duping the GCR registers and verified 
whether the no-reboot bit is modified or not.
>
>> On Sun, Apr 2, 2017 at 7:11 AM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Sat, Apr 1, 2017 at 2:27 AM, Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>> According to Broxton APL PMC spec, gcr mem region starts
>>>> at offset 0x1000 from ipc mem base address. In this driver,
>>>> PLAT_RESOURCE_GCR_OFFSET macro defines the offset of GCR
>>>> memory region from IPC mem region. So we should use 0x1000(4K)
>>>> as GCR offset. But currently this driver uses 0x1008 as GCT
>>>> offset.This patch fixes this issue.
>>>
>>> So, if I apply this one independently, would it fix an existin issue?
>>>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> ---
>>>>   drivers/platform/x86/intel_pmc_ipc.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> Changes since v3:
>>>>   * Updated the commit history
>>>>
>>>> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
>>>> index 0651d47..0a33592 100644
>>>> --- a/drivers/platform/x86/intel_pmc_ipc.c
>>>> +++ b/drivers/platform/x86/intel_pmc_ipc.c
>>>> @@ -82,7 +82,7 @@
>>>>   /* exported resources from IFWI */
>>>>   #define PLAT_RESOURCE_IPC_INDEX                0
>>>>   #define PLAT_RESOURCE_IPC_SIZE         0x1000
>>>> -#define PLAT_RESOURCE_GCR_OFFSET       0x1008
>>>> +#define PLAT_RESOURCE_GCR_OFFSET       0x1000
>>>>   #define PLAT_RESOURCE_GCR_SIZE         0x1000
>>>>   #define PLAT_RESOURCE_BIOS_DATA_INDEX  1
>>>>   #define PLAT_RESOURCE_BIOS_IFACE_INDEX 2
>>>> --
>>>> 2.7.4
>>>>
>>>
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>>
>>
>> --
>> --
>>
>> Sathya
>
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

