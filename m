Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44748 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755066AbdDDWTA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 18:19:00 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v5 6/6] platform/x86: intel_pmc_ipc: use gcr mem base for
 S0ix counter read
References: <bf5a86829e9403d93e85270b2898b3c548417a05.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com>
 <8aad93502f17d05367588ea0c17b01b450a1385a.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vf7QTc3ZG285=P2PeA2QxGUPXt0Tu-Mr+7+81XVye_63A@mail.gmail.com>
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
Message-ID: <d13071a1-a7ab-0c93-1427-858e79a0b9e0@linux.intel.com>
Date: Tue, 4 Apr 2017 15:15:00 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf7QTc3ZG285=P2PeA2QxGUPXt0Tu-Mr+7+81XVye_63A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Andy,


On 04/04/2017 06:51 AM, Andy Shevchenko wrote:
> On Tue, Apr 4, 2017 at 3:24 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> To maintain the uniformity in accessing GCR registers, this patch
>> modifies the S0ix counter read function to use GCR address base
>> instead of ipc address base.
>>
> This one looks good.
>
> --- 8< --- 8< ---
>
> Overall, I do not like this spreading interface where we have more and
> more functions which use some global variable without clear
> understanding of device / initialization dependencies.
Agreed. This is added to list of issues that need to be fixed during the 
refactoring effort.
>
> Better approach would be something using opaque pointers and API which
> takes it as an input.
> I didn't investigate yet about something similar to UCLASS_SYSCON
> (this is nice model of dependency used in U-Boot) in Linux kernel, it
> would be cool to use it.
Will look into this and see whether we can use this design in our code..
>
> So, the priority number #2 (number #1 is to fix interrupt handling for
> Whiskey Cove) is to refactor this all mess.
I have created patches to fix #1, I am in process of testing them. Once 
I am satisfied , I will send it for review.

For #2, myself and Rajnessh created a initial proposal for refactoring 
task and we will share it with you in few days.
>
> Like we agreed it would be last series I'm going to apply without
> refactoring done.
:) Its our deal. Thanks.
>
> --- 8< --- 8< ---
>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
>> Tested-by: Shanth Murthy <shanth.murthy@intel.com>
>> ---
>>   arch/x86/include/asm/intel_pmc_ipc.h |  2 ++
>>   drivers/platform/x86/intel_pmc_ipc.c | 10 +++-------
>>   2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> Changes since v4:
>>   * Rebased on top of latest changes.
>>
>> Changes since v3:
>>   * Rebased on top of latest changes.
>>
>> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
>> index 8402efe..fac89eb 100644
>> --- a/arch/x86/include/asm/intel_pmc_ipc.h
>> +++ b/arch/x86/include/asm/intel_pmc_ipc.h
>> @@ -25,6 +25,8 @@
>>
>>   /* GCR reg offsets from gcr base*/
>>   #define PMC_GCR_PMC_CFG_REG            0x08
>> +#define PMC_GCR_TELEM_DEEP_S0IX_REG    0x78
>> +#define PMC_GCR_TELEM_SHLW_S0IX_REG    0x80
>>
>>   #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
>>
>> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
>> index 3d0d6f17..b61f569 100644
>> --- a/drivers/platform/x86/intel_pmc_ipc.c
>> +++ b/drivers/platform/x86/intel_pmc_ipc.c
>> @@ -57,10 +57,6 @@
>>   #define IPC_WRITE_BUFFER       0x80
>>   #define IPC_READ_BUFFER                0x90
>>
>> -/* PMC Global Control Registers */
>> -#define GCR_TELEM_DEEP_S0IX_OFFSET     0x1078
>> -#define GCR_TELEM_SHLW_S0IX_OFFSET     0x1080
>> -
>>   /* Residency with clock rate at 19.2MHz to usecs */
>>   #define S0IX_RESIDENCY_IN_USECS(d, s)          \
>>   ({                                             \
>> @@ -203,7 +199,7 @@ static inline u32 ipc_data_readl(u32 offset)
>>
>>   static inline u64 gcr_data_readq(u32 offset)
>>   {
>> -       return readq(ipcdev.ipc_base + offset);
>> +       return readq(ipcdev.gcr_mem_base + offset);
>>   }
>>
>>   static inline int is_gcr_valid(u32 offset)
>> @@ -906,8 +902,8 @@ int intel_pmc_s0ix_counter_read(u64 *data)
>>          if (!ipcdev.has_gcr_regs)
>>                  return -EACCES;
>>
>> -       deep = gcr_data_readq(GCR_TELEM_DEEP_S0IX_OFFSET);
>> -       shlw = gcr_data_readq(GCR_TELEM_SHLW_S0IX_OFFSET);
>> +       deep = gcr_data_readq(PMC_GCR_TELEM_DEEP_S0IX_REG);
>> +       shlw = gcr_data_readq(PMC_GCR_TELEM_SHLW_S0IX_REG);
>>
>>          *data = S0IX_RESIDENCY_IN_USECS(deep, shlw);
>>
>> --
>> 2.7.4
>>
>
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

