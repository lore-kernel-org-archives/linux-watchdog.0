Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14204 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752997AbdDDWL3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 18:11:29 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v5 2/6] platform/x86: intel_pmc_ipc: Add pmc gcr
 read/write/update api's
References: <bf5a86829e9403d93e85270b2898b3c548417a05.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com>
 <83d48f6907b3392e38ee251cf9fa6d518f139288.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75VcNucpd17Z8gsoxW7qDsyR7UkJG4n-82J6CpM3j_3V_Ew@mail.gmail.com>
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
Message-ID: <e8e453f6-8920-7081-7cd5-559856a33f6a@linux.intel.com>
Date: Tue, 4 Apr 2017 15:07:32 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VcNucpd17Z8gsoxW7qDsyR7UkJG4n-82J6CpM3j_3V_Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Andy,


On 04/04/2017 06:53 AM, Andy Shevchenko wrote:
> On Tue, Apr 4, 2017 at 3:24 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> This patch adds API's to read/write/update PMC GC registers.
>> PMC dependent devices like iTCO_wdt, Telemetry has requirement
>> to acces GCR registers. These API's can be used for this
>> purpose.
>> +/* GCR reg offsets from gcr base*/
>> +#define PMC_GCR_PMC_CFG_REG            0x08
>> +
>> --- a/drivers/platform/x86/intel_pmc_ipc.c
>> +++ b/drivers/platform/x86/intel_pmc_ipc.c
>> @@ -127,6 +127,7 @@ static struct intel_pmc_ipc_dev {
>>
>>          /* gcr */
>>          resource_size_t gcr_base;
>> +       void __iomem *gcr_mem_base;
>>          int gcr_size;
> Rearrange those lines to make __iomem pointer latter.
Will do it in next version. But the gcr_base resource pointer will be 
removed in next dependent patch. So I don't think it matters in the end.
>
>> +static inline int is_gcr_valid(u32 offset)
> Same comment as previously. It should take a pointer to struct
> intel_pmc_ipc_dev as a parameter.
This needs the driver cleanup. We can do it in refactoring patch.
>
>> +/**
>> + * intel_pmc_gcr_write() - Write PMC GCR register
>> + * @offset:    offset of GCR register from GCR address base
>> + * @data:      register update value
>> + *
>> + * Writes the PMC GCR register of given offset with given
>> + * value
> You have to use proper punctuation in the sentences in full Description section.
Will fix it in next version.
>
>> +/**
>> + * intel_pmc_gcr_update() - Update PMC GCR register bits
>> + * @offset:    offset of GCR register from GCR address base
>> + * @mask:      bit mask for update operation
>> + * @val:       update value
>> + *
>> + * Updates the bits of given GCR register as specified by
>> + * @mask and @val
> Ditto.
>
>> +int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
>> +{
>> +       u32 orig, tmp;
> One of them is redundant.
>
> I would go just with
> u32 value;
Will fix it in next version.
>
>> +       writel(tmp, ipcdev.gcr_mem_base + offset);
>> +
>> +       tmp = readl(ipcdev.gcr_mem_base + offset);
>> +
> Redundant.
>
>> +       if ((tmp & mask) != (val & mask)) {
> Why?! It the a case when writel() will fail? Needs to be commented.
Yes, I am checking whether the update is successful or  not. I can add a 
comment there to explain it.
>
>> +               ret = -EIO;
>> +               goto gcr_update_err;
>> +       }
>> +
>> +gcr_update_err:
> The keyword  'unlock' is missed in the label name.
"goto" to this label is only used when there is an error in update 
operation. Do you think we should still rename it to gcr_ipc_unlock ?
>
>> +       mutex_unlock(&ipclock);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

