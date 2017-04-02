Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35891 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdDBN6q (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 2 Apr 2017 09:58:46 -0400
MIME-Version: 1.0
In-Reply-To: <1ca7187132bd2b98ca87d0829a3c76022f041924.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170331133728.GA23725@rajaneesh-OptiPlex-9010> <1ca7187132bd2b98ca87d0829a3c76022f041924.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Apr 2017 16:58:44 +0300
Message-ID: <CAHp75Vc0Mjk81TLDVwr9jkeeHqCvJ729aQLqg09zov7--AjKyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] platform/x86: intel_pmc_ipc: Add pmc gcr
 read/write/update api's
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>, sathyaosid@gmail.com,
        David Box <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 1, 2017 at 2:27 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> This patch adds API's to read/write/update PMC GC registers.
> PMC dependent devices like iTCO_WDT, Telemetry has requirement

iTCO_wdt

> to acces GCR registers. These API's can be used for this
> purpose.

> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c

> +static inline int is_gcr_valid(u32 offset)

Pointer to ipcdev should be a parameter to this function.

> +{
> +       if (!ipcdev.has_gcr_regs)
> +               return -EACCES;
> +
> +       if (offset > PLAT_RESOURCE_GCR_SIZE)
> +               return -EINVAL;
> +
> +       return 0;
> +}

> +/**
> + * intel_pmc_gcr_update() - Update PMC GCR register bits
> + * @offset:    offset of GCR register from GCR address base
> + * @mask:      bit mask for update operation
> + * @val:       update value
> + *

> + * Updates the bits of given GCR register as specified by
> + * mask and val

-> * @mask and @val.

You would need to refresh how to use kernel doc.

> + *
> + * Return:     negative value on error or 0 on success.
> + */

With Best Regards,
Andy Shevchenko
