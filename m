Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:53460 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758081AbdKOO6c (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 15 Nov 2017 09:58:32 -0500
Received: by mail-pf0-f195.google.com with SMTP id b6so16950103pff.10
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Nov 2017 06:58:32 -0800 (PST)
Date: Wed, 15 Nov 2017 06:58:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 1/2] watchdog: xen_wdt: use the watchdog subsystem
Message-ID: <20171115145829.GA18395@roeck-us.net>
References: <20171114162350.24283-1-rrendec@arista.com>
 <20171114162350.24283-2-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114162350.24283-2-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 14, 2017 at 04:23:49PM +0000, Radu Rendec wrote:
> Change the xen_wdt driver to use the watchdog subsystem instead of
> registering and manipulating the char device directly through the misc
> API. This is mainly getting rid of the "write" and "ioctl" methods and
> part of the watchdog control logic (which are all implemented by the
> watchdog subsystem).
> 
> Even though the watchdog subsystem supports registering and handling
> multiple watchdog devices at the same time, the xen_wdt driver has an
> inherent limitation of only one device due to the way the Xen hypervisor
> exposes watchdog functionality. However, the driver can now coexist with
> other watchdog devices (supported by different drivers).
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>
> ---
>  drivers/watchdog/xen_wdt.c | 254 +++++++++++----------------------------------
>  1 file changed, 59 insertions(+), 195 deletions(-)
> 
> diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
> index 5dd5c3494d55..4e00419bd47d 100644
> --- a/drivers/watchdog/xen_wdt.c
> +++ b/drivers/watchdog/xen_wdt.c
> @@ -9,9 +9,8 @@
>   *	2 of the License, or (at your option) any later version.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#define DRV_NAME	"wdt"
> +#define DRV_NAME	"xen_wdt"
> +#define DEV_NAME	"watchdog"

[ ... ]

>  
> +static const struct platform_device_id xen_wdt_id_table[] = {
> +	{ .name	= DEV_NAME },

I understand we are way into bikeshedding territory, and I was inclined
to let this just go, but this is way too generic for a platform device
ID, sorry.

Guenter
