Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38929 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeLFR5b (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Dec 2018 12:57:31 -0500
Date: Thu, 6 Dec 2018 09:57:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog/hpwdt: Do not claim unsupported hardware
Message-ID: <20181206175724.GC11808@roeck-us.net>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
 <1544056943-79958-3-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544056943-79958-3-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 05, 2018 at 05:42:22PM -0700, Jerry Hoemann wrote:
> Do not claim when SSID 0x0289 as the watchdog features
> are not enabled/validated by the firmware.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index eecd014..c8e8055 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -52,6 +52,7 @@
>  
>  static const struct pci_device_id hpwdt_blacklist[] = {
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP, 0x1979) }, /* auxilary iLO */
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP_3PAR, 0x0289) },  /* CL */
>  	{0},			/* terminate list */
>  };
>  
> -- 
> 1.8.3.1
> 
