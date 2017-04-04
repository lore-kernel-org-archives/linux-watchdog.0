Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35431 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753540AbdDDNx6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 09:53:58 -0400
MIME-Version: 1.0
In-Reply-To: <83d48f6907b3392e38ee251cf9fa6d518f139288.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <bf5a86829e9403d93e85270b2898b3c548417a05.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com> <83d48f6907b3392e38ee251cf9fa6d518f139288.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Apr 2017 16:53:57 +0300
Message-ID: <CAHp75VcNucpd17Z8gsoxW7qDsyR7UkJG4n-82J6CpM3j_3V_Ew@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] platform/x86: intel_pmc_ipc: Add pmc gcr
 read/write/update api's
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 4, 2017 at 3:24 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> This patch adds API's to read/write/update PMC GC registers.
> PMC dependent devices like iTCO_wdt, Telemetry has requirement
> to acces GCR registers. These API's can be used for this
> purpose.

> +/* GCR reg offsets from gcr base*/
> +#define PMC_GCR_PMC_CFG_REG            0x08
> +

> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -127,6 +127,7 @@ static struct intel_pmc_ipc_dev {
>
>         /* gcr */
>         resource_size_t gcr_base;

> +       void __iomem *gcr_mem_base;
>         int gcr_size;

Rearrange those lines to make __iomem pointer latter.

> +static inline int is_gcr_valid(u32 offset)

Same comment as previously. It should take a pointer to struct
intel_pmc_ipc_dev as a parameter.

> +/**
> + * intel_pmc_gcr_write() - Write PMC GCR register
> + * @offset:    offset of GCR register from GCR address base
> + * @data:      register update value
> + *
> + * Writes the PMC GCR register of given offset with given
> + * value

You have to use proper punctuation in the sentences in full Description section.

> +/**
> + * intel_pmc_gcr_update() - Update PMC GCR register bits
> + * @offset:    offset of GCR register from GCR address base
> + * @mask:      bit mask for update operation
> + * @val:       update value
> + *
> + * Updates the bits of given GCR register as specified by
> + * @mask and @val

Ditto.

> +int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
> +{

> +       u32 orig, tmp;

One of them is redundant.

I would go just with
u32 value;

> +       writel(tmp, ipcdev.gcr_mem_base + offset);
> +
> +       tmp = readl(ipcdev.gcr_mem_base + offset);

> +

Redundant.

> +       if ((tmp & mask) != (val & mask)) {

Why?! It the a case when writel() will fail? Needs to be commented.

> +               ret = -EIO;
> +               goto gcr_update_err;
> +       }
> +

> +gcr_update_err:

The keyword  'unlock' is missed in the label name.

> +       mutex_unlock(&ipclock);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);

-- 
With Best Regards,
Andy Shevchenko
