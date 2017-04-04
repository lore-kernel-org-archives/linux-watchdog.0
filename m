Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33452 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdDDNZ0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 09:25:26 -0400
MIME-Version: 1.0
In-Reply-To: <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com>
References: <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
 <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vf3bq7cGUmi2Oi_TkvkCTzJ1QDmKUoTXmJgkgbxUE+UfA@mail.gmail.com> <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Apr 2017 16:25:25 +0300
Message-ID: <CAHp75VdeZW6zAfoXsv6ZwQ9woyumj4s5n1ZSaPWoJQBdP5BNfw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] platform/x86: intel_pmc_ipc: fix gcr offset
To: Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Cc: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        David Box <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Please, STOP top-posting.

On Mon, Apr 3, 2017 at 4:51 AM, Sathyanarayanan Kuppuswamy Natarajan
<sathyaosid@gmail.com> wrote:
> Yes, just applying this patch will fix the existing offset issue.

Then the question how it was tested in both cases (before this change and now) ?

>
> On Sun, Apr 2, 2017 at 7:11 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Sat, Apr 1, 2017 at 2:27 AM, Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>> According to Broxton APL PMC spec, gcr mem region starts
>>> at offset 0x1000 from ipc mem base address. In this driver,
>>> PLAT_RESOURCE_GCR_OFFSET macro defines the offset of GCR
>>> memory region from IPC mem region. So we should use 0x1000(4K)
>>> as GCR offset. But currently this driver uses 0x1008 as GCT
>>> offset.This patch fixes this issue.
>>
>>
>> So, if I apply this one independently, would it fix an existin issue?
>>
>>>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>>  drivers/platform/x86/intel_pmc_ipc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Changes since v3:
>>>  * Updated the commit history
>>>
>>> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
>>> index 0651d47..0a33592 100644
>>> --- a/drivers/platform/x86/intel_pmc_ipc.c
>>> +++ b/drivers/platform/x86/intel_pmc_ipc.c
>>> @@ -82,7 +82,7 @@
>>>  /* exported resources from IFWI */
>>>  #define PLAT_RESOURCE_IPC_INDEX                0
>>>  #define PLAT_RESOURCE_IPC_SIZE         0x1000
>>> -#define PLAT_RESOURCE_GCR_OFFSET       0x1008
>>> +#define PLAT_RESOURCE_GCR_OFFSET       0x1000
>>>  #define PLAT_RESOURCE_GCR_SIZE         0x1000
>>>  #define PLAT_RESOURCE_BIOS_DATA_INDEX  1
>>>  #define PLAT_RESOURCE_BIOS_IFACE_INDEX 2
>>> --
>>> 2.7.4
>>>
>>
>>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>
>
>
> --
> --
>
> Sathya



-- 
With Best Regards,
Andy Shevchenko
