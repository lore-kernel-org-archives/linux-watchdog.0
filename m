Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36110 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbdDFVhz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Apr 2017 17:37:55 -0400
MIME-Version: 1.0
In-Reply-To: <f5fbaf426ad657e1f8cb8a15619602afd4e12efe.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <463a23bb1f44098dd0fe506346bae71282009e05.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3e7ca77c-2be5-5f89-f51f-faaca9f2d9ac@linux.intel.com> <f5fbaf426ad657e1f8cb8a15619602afd4e12efe.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Apr 2017 00:37:54 +0300
Message-ID: <CAHp75VcMS3V63eFVhWiM+ynoV7wOjbHb56brSSJ71CDcxS1fLg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS
 memory mapping failure
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

On Thu, Apr 6, 2017 at 1:54 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> iTCO_wdt driver need access to PMC_CFG GCR register to modify the
> noreboot setting. Currently, this is done by passing PMC_CFG reg
> address as memory resource to watchdog driver and allowing it directly
> modify the PMC_CFG register. But currently PMC driver also has
> requirement to memory map the entire GCR register space in this driver.
> This causes mem request failure in watchdog driver. So this patch fixes
> this issue by adding API to update noreboot flag and passes them
> to watchdog driver via platform data.

> +/* PMC_CFG_REG bit masks */
> +#define PMC_CFG_NO_REBOOT_MASK         BIT(4)

> +#define PMC_CFG_NO_REBOOT_ENABLE       BIT(4)
> +#define PMC_CFG_NO_REBOOT_DISABLE      0

I would go for those like
(1 << 4)
and
(0 << 4)
which for my opinion is better to get a picture.

> +static int update_no_reboot_bit(void *priv, bool set)
> +{
> +       if (set)
> +               return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
> +                                           PMC_CFG_NO_REBOOT_MASK,
> +                                           PMC_CFG_NO_REBOOT_ENABLE);
> +
> +       return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
> +                                   PMC_CFG_NO_REBOOT_MASK,
> +                                   PMC_CFG_NO_REBOOT_DISABLE);

u32 value = set ? PMC_CFG_NO_REBOOT_ENABLE : PMC_CFG_NO_REBOOT_DISABLE;

(also you may consider to use just *_EN and *_DIS)

return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
                                   PMC_CFG_NO_REBOOT_MASK,
                                   value);
> +}

-- 
With Best Regards,
Andy Shevchenko
