Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43024 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934937AbeCSQBf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:35 -0400
Date: Mon, 19 Mar 2018 09:01:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-acpi@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] ACPI / watchdog: Fix off-by-one error at resource
 assignment
Message-ID: <20180319160130.GA14863@roeck-us.net>
References: <20180319135149.25215-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319135149.25215-1-tiwai@suse.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 19, 2018 at 02:51:49PM +0100, Takashi Iwai wrote:
> The resource allocation in WDAT watchdog has off-one-by error, it sets
> one byte more than the actual end address.  This may eventually lead
> to unexpected resource conflicts.
> 
> Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/acpi/acpi_watchdog.c | 4 ++--
>  drivers/watchdog/wdat_wdt.c  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> index 11b113f8e367..ebb626ffb5fa 100644
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -74,10 +74,10 @@ void __init acpi_watchdog_init(void)
>  		res.start = gas->address;
>  		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>  			res.flags = IORESOURCE_MEM;
> -			res.end = res.start + ALIGN(gas->access_width, 4);
> +			res.end = res.start + ALIGN(gas->access_width, 4) - 1;
>  		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>  			res.flags = IORESOURCE_IO;
> -			res.end = res.start + gas->access_width;
> +			res.end = res.start + gas->access_width - 1;
>  		} else {
>  			pr_warn("Unsupported address space: %u\n",
>  				gas->space_id);
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 6d1fbda0f461..0da9943d405f 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -392,7 +392,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  
>  		memset(&r, 0, sizeof(r));
>  		r.start = gas->address;
> -		r.end = r.start + gas->access_width;
> +		r.end = r.start + gas->access_width - 1;
>  		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>  			r.flags = IORESOURCE_MEM;
>  		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> -- 
> 2.16.2
> 
