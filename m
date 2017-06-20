Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54622 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdFTOMy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Jun 2017 10:12:54 -0400
Date: Tue, 20 Jun 2017 07:12:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>
Subject: Re: [1/3, v2] usb: pci-quirks: Add a common mutex for the I/O port
 pair of SB800
Message-ID: <20170620141251.GA14290@roeck-us.net>
References: <20170403075133.12343-2-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170403075133.12343-2-zboszor@pr.hu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 03, 2017 at 09:51:31AM +0200, Zoltán Böszörményi wrote:
> This patch adds a common mutex in the USB PCI quirks code and starts
> using it to synchronize access to the I/O port pair 0xcd6 / 0xcd7 on
> SB800.
> 
> These I/O ports are also used by i2c-piix4 and sp5100_tco, the next
> two patches port these drivers to use this common mutex.
> 
> v2: No extra header and no wrapper for mutex_lock() / mutex_unlock()
> 

So now the callers have to declare the mutex in a source file, which results
in a checkpatch warning. This is not acceptable.

This is not my major issue with this patch, though. It creates an artificial
dependency between the watchdog driver, the i2c driver, and the USB host
code, which I think is a really bad idea.

Either the drivers accessing the IO region in question should use
request_muxed_region(), or there should be an explicit API, located somewhere
in core AMD kernel code, to access it.

Guenter

> Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>
> ---
>  drivers/usb/host/pci-quirks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index a9a1e4c..1ef0ada 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -279,6 +279,9 @@ bool usb_amd_prefetch_quirk(void)
>  }
>  EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
>  
> +DEFINE_MUTEX(sb800_mutex);
> +EXPORT_SYMBOL_GPL(sb800_mutex);
> +
>  /*
>   * The hardware normally enables the A-link power management feature, which
>   * lets the system lower the power consumption in idle states.
> @@ -314,11 +317,13 @@ static void usb_amd_quirk_pll(int disable)
>  	if (amd_chipset.sb_type.gen == AMD_CHIPSET_SB800 ||
>  			amd_chipset.sb_type.gen == AMD_CHIPSET_HUDSON2 ||
>  			amd_chipset.sb_type.gen == AMD_CHIPSET_BOLTON) {
> +		mutex_lock(&sb800_mutex);
>  		outb_p(AB_REG_BAR_LOW, 0xcd6);
>  		addr_low = inb_p(0xcd7);
>  		outb_p(AB_REG_BAR_HIGH, 0xcd6);
>  		addr_high = inb_p(0xcd7);
>  		addr = addr_high << 8 | addr_low;
> +		mutex_unlock(&sb800_mutex);
>  
>  		outl_p(0x30, AB_INDX(addr));
>  		outl_p(0x40, AB_DATA(addr));
