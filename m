Return-Path: <lyude@redhat.com>
Return-path: <lyude@redhat.com>
Message-ID: <1516131863.18904.8.camel@redhat.com>
Subject: Re: [03/12] watchdog: sp5100_tco: Use request_muxed_region where
 possible
From: Lyude Paul <lyude@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?=
	 <zboszor@pr.hu>
Date: Tue, 16 Jan 2018 14:44:23 -0500
In-Reply-To: <1514149457-20273-4-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-4-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 2017-12-24 at 13:04 -0800, Guenter Roeck wrote:
> Use request_muxed_region for multiplexed IO memory regions.
> Also, SP5100_IO_PM_INDEX_REG/SP5100_IO_PM_DATA_REG are only
> used during initialization; it is unnecessary to keep the
> address range reserved.

Patches like this should probably be done at a rate of one patch/per
functional change so it's easier to bisect in the future if something breaksw.
Could you split this patch into two, one for switching over to
request_muxed_region() and the other for removing the release_region() calls?
> 
> Cc: Zoltán Böszörményi <zboszor@pr.hu>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/sp5100_tco.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 05f9d27a306a..11109ac959e2 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -379,8 +379,8 @@ static unsigned char sp5100_tco_setupdevice(void)
>  	}
>  
>  	/* Request the IO ports used by this driver */
> -	if (!request_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE,
> -			    dev_name)) {
> +	if (!request_muxed_region(SP5100_IO_PM_INDEX_REG,
> +				  SP5100_PM_IOPORTS_SIZE, dev_name)) {
>  		pr_err("I/O address 0x%04x already in use\n",
>  		       SP5100_IO_PM_INDEX_REG);
>  		goto exit;
> @@ -468,6 +468,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>  	 */
>  	tco_timer_stop();
>  
> +	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>  	/* Done */
>  	return 1;
>  
> @@ -521,7 +522,6 @@ static int sp5100_tco_init(struct platform_device *dev)
>  exit:
>  	iounmap(tcobase);
>  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>  	return ret;
>  }
>  
> @@ -535,7 +535,6 @@ static void sp5100_tco_cleanup(void)
>  	misc_deregister(&sp5100_tco_miscdev);
>  	iounmap(tcobase);
>  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>  }
>  
>  static int sp5100_tco_remove(struct platform_device *dev)
-- 
Cheers,
	Lyude Paul
