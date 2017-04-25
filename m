Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36869 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1432456AbdDYRiU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Apr 2017 13:38:20 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 1/6] platform/x86: intel_pmc_ipc: fix gcr offset
References: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75VcZAtpVDW2BbHZ5-3NZX4tgmz24U4=-oYTq-_h+eUTdFw@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>,
        David Box <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c1a6ee3d-ded0-fc6d-3f3e-d7f8b4c2e323@linux.intel.com>
Date: Tue, 25 Apr 2017 10:34:43 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VcZAtpVDW2BbHZ5-3NZX4tgmz24U4=-oYTq-_h+eUTdFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 04/25/2017 06:29 AM, Andy Shevchenko wrote:
> On Mon, Apr 10, 2017 at 1:00 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> According to Broxton APL spec, PMC MIMO resources for Global Control
>> Registers(GCR) are located at 4K(0x1000) offset from IPC base address.
>> In this driver, PLAT_RESOURCE_GCR_OFFSET macro defines the offset of GCR
>> region base address from IPC base address and its current value of
>> 0x1008 is incorrect because it points to location for PMC_CFG register
>> and not the GCR base address itself.
>>
>> GCR Base = IPC1 Base + 0x1000.
>>
>> This patch fixes this offset issue.
> The whole series has been pushed to testing, thanks.
Thanks Andy.
>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel_pmc_ipc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Changes since v6:
>>   *  Updated commit message
>>
>> Changes since v5:
>>   *  None
>>
>> Changes since v4:
>>   *  None
>>
>> Changes since v3:
>>   * Updated the commit history
>>
>> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
>> index 0651d47..0a33592 100644
>> --- a/drivers/platform/x86/intel_pmc_ipc.c
>> +++ b/drivers/platform/x86/intel_pmc_ipc.c
>> @@ -82,7 +82,7 @@
>>   /* exported resources from IFWI */
>>   #define PLAT_RESOURCE_IPC_INDEX                0
>>   #define PLAT_RESOURCE_IPC_SIZE         0x1000
>> -#define PLAT_RESOURCE_GCR_OFFSET       0x1008
>> +#define PLAT_RESOURCE_GCR_OFFSET       0x1000
>>   #define PLAT_RESOURCE_GCR_SIZE         0x1000
>>   #define PLAT_RESOURCE_BIOS_DATA_INDEX  1
>>   #define PLAT_RESOURCE_BIOS_IFACE_INDEX 2
>> --
>> 2.7.4
>>
>
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

