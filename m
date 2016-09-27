Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46035 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932914AbcI0CUE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Sep 2016 22:20:04 -0400
Subject: Re: [PATCH] watchdog: hpwdt: add support for iLO5
To: Brian Boylston <brian.boylston@hpe.com>,
        linux-watchdog@vger.kernel.org
References: <20160926185714.10866-1-brian.boylston@hpe.com>
Cc: linux-kernel@vger.kernel.org, wim@iguana.be, nigel.croxon@hpe.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d83bcb8c-cc77-bb7d-5fbe-ae62d7d2ffd1@roeck-us.net>
Date: Mon, 26 Sep 2016 19:20:00 -0700
MIME-Version: 1.0
In-Reply-To: <20160926185714.10866-1-brian.boylston@hpe.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/26/2016 11:57 AM, Brian Boylston wrote:
> iLO5 will offer the same watchdog timer as previous generations, but the
> PCI subsystem vendor ID will be PCI_VENDOR_ID_HP_3PAR (0x1590) instead of
> PCI_VENDOR_ID_HP (0x103c).  Add 0x1590 to the whitelist and be more
> specific when ignoring the 103c,1979 device.
>
> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 8f89bd8..70c7194 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -39,7 +39,7 @@
>  #include <asm/nmi.h>
>  #include <asm/frame.h>
>
> -#define HPWDT_VERSION			"1.3.3"
> +#define HPWDT_VERSION			"1.4.0"
>  #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
>  #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> @@ -814,7 +814,8 @@ static int hpwdt_init_one(struct pci_dev *dev,
>  	 * not run on a legacy ASM box.
>  	 * So we only support the G5 ProLiant servers and higher.
>  	 */
> -	if (dev->subsystem_vendor != PCI_VENDOR_ID_HP) {
> +	if (dev->subsystem_vendor != PCI_VENDOR_ID_HP &&
> +	    dev->subsystem_vendor != PCI_VENDOR_ID_HP_3PAR) {
>  		dev_warn(&dev->dev,
>  			"This server does not have an iLO2+ ASIC.\n");
>  		return -ENODEV;
> @@ -823,7 +824,8 @@ static int hpwdt_init_one(struct pci_dev *dev,
>  	/*
>  	 * Ignore all auxilary iLO devices with the following PCI ID
>  	 */
> -	if (dev->subsystem_device == 0x1979)
> +	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP &&
> +	    dev->subsystem_device == 0x1979)
>  		return -ENODEV;
>
>  	if (pci_enable_device(dev)) {
>

