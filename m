Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35626 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdDBOKD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 2 Apr 2017 10:10:03 -0400
MIME-Version: 1.0
In-Reply-To: <4e66c12e4576c56c675d049af8b063d3ccd65d17.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170331133728.GA23725@rajaneesh-OptiPlex-9010> <4e66c12e4576c56c675d049af8b063d3ccd65d17.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Apr 2017 17:10:02 +0300
Message-ID: <CAHp75VePsgzLq46GvndfQimzA=yRs0u_1Kz1mGXKS91jcqNzRw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] platform/x86: intel_pmc_ipc: Fix iTCO GCS memory
 mapping failure
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
> iTCO watchdog driver need access to PMC_CFG GCR register to modify

iTCO_wdt or use above in the rest of the series.

So, choose one and use it everywhere in your patch series.

> the no reboot setting. Currently, this is done by passing PMC_CFG reg
> address as memory resource to watchdog driver and allowing it directly
> modify the PMC_CFG register. But currently PMC driver also has
> requirement to memory map the entire GCR register space in this driver.
> This causes mem request failure in watchdog driver. So this patch fixes
> this issue by adding api to update noreboot flag and passes them
> to watchdog driver via platform data.


> +static int update_noreboot_bit(bool status)
> +{
> +       if (status)

> +               return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG, BIT(4),
> +                                           BIT(4));

BIT(4) is a magic. Moreover, it's used as mask and value here, you
might introduce temporary variables for better understanding what is
what.
As an example you may look at drivers/acpi/acpi_lpss.c (code related
to IOSF MBI interaction).

> +       else

Redundant.


-- 
With Best Regards,
Andy Shevchenko
