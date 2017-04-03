Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yb0-f173.google.com ([209.85.213.173]:36700 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdDCBvG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 2 Apr 2017 21:51:06 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc0Mjk81TLDVwr9jkeeHqCvJ729aQLqg09zov7--AjKyw@mail.gmail.com>
References: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170331133728.GA23725@rajaneesh-OptiPlex-9010> <1ca7187132bd2b98ca87d0829a3c76022f041924.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vc0Mjk81TLDVwr9jkeeHqCvJ729aQLqg09zov7--AjKyw@mail.gmail.com>
From: Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Date: Sun, 2 Apr 2017 18:51:05 -0700
Message-ID: <CAENHMvPLE5KZMZ+NoU5fmNzDEoONz=SeAaSC=q8GfhFEHFOJ6g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] platform/x86: intel_pmc_ipc: Add pmc gcr
 read/write/update api's
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi Andy,

Thanks for your comments.

On Sun, Apr 2, 2017 at 6:58 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Apr 1, 2017 at 2:27 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> This patch adds API's to read/write/update PMC GC registers.
>> PMC dependent devices like iTCO_WDT, Telemetry has requirement
>
> iTCO_wdt
will fix it in next version.
>
>> to acces GCR registers. These API's can be used for this
>> purpose.
>
>> --- a/drivers/platform/x86/intel_pmc_ipc.c
>> +++ b/drivers/platform/x86/intel_pmc_ipc.c
>
>> +static inline int is_gcr_valid(u32 offset)
>
> Pointer to ipcdev should be a parameter to this function.

But ipcdev is a static variable, visible across this file. So there is
no point in passing it as parameter.

I just noticed that I am not holding the mutex lock in these
functions. I will fix it in next version.

>
>> +{
>> +       if (!ipcdev.has_gcr_regs)
>> +               return -EACCES;
>> +
>> +       if (offset > PLAT_RESOURCE_GCR_SIZE)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>
>> +/**
>> + * intel_pmc_gcr_update() - Update PMC GCR register bits
>> + * @offset:    offset of GCR register from GCR address base
>> + * @mask:      bit mask for update operation
>> + * @val:       update value
>> + *
>
>> + * Updates the bits of given GCR register as specified by
>> + * mask and val
>
> -> * @mask and @val.
>
> You would need to refresh how to use kernel doc.
-:) will fix it in next version.
>
>> + *
>> + * Return:     negative value on error or 0 on success.
>> + */
>
> With Best Regards,
> Andy Shevchenko



-- 
--

Sathya
