Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35698 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbdDDNtA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 09:49:00 -0400
MIME-Version: 1.0
In-Reply-To: <4d324041eea35fc04aca56b60c36035724cff2ba.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <bf5a86829e9403d93e85270b2898b3c548417a05.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAENHMvOyzbhDQzvpYFcxC9mvsfDGrco9RMy+rU=faT6RN_uW3A@mail.gmail.com> <4d324041eea35fc04aca56b60c36035724cff2ba.1491264643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Apr 2017 16:48:59 +0300
Message-ID: <CAHp75VdvQ4k+NDmtdw_67Hds2JMPDzPBf-ioZ-VDBzFNB5wOqg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] watchdog: iTCO_wdt: Add PMC specific noreboot
 update api
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
> In some SoCs, setting noreboot bit needs modification to
> PMC GC registers. But not all PMC drivers allow other drivers
> to memory map their GC region. This could create mem request
> conflict in watchdog driver. So this patch adds facility to allow
> PMC drivers to pass noreboot update function to watchdog
> drivers via platform data.

>         /* Set the NO_REBOOT bit: this disables reboots */
>         if (p->iTCO_version >= 2) {
> -               val32 = readl(p->gcs_pmc);
> -               val32 |= no_reboot_bit(p);
> -               writel(val32, p->gcs_pmc);
> +               if (p->update_noreboot_flag)
> +                       p->update_noreboot_flag(true);
> +               else {
> +                       val32 = readl(p->gcs_pmc);
> +                       val32 |= no_reboot_bit(p);
> +                       writel(val32, p->gcs_pmc);
> +               }

What I meant is to introduce helper(s) first and then fix this. Yes, I
understand it might increase work for backporting (if even needed),
but I still think it worth doing.

-- 
With Best Regards,
Andy Shevchenko
