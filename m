Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41079 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbdCMRQg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Mar 2017 13:16:36 -0400
Date: Mon, 13 Mar 2017 10:16:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Johan Hovold <johan@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_usb: fix NULL-deref at probe
Message-ID: <20170313171633.GB16813@roeck-us.net>
References: <20170313124945.28923-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313124945.28923-1-johan@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 13, 2017 at 01:49:45PM +0100, Johan Hovold wrote:
> Make sure to check the number of endpoints to avoid dereferencing a
> NULL-pointer should a malicious device lack endpoints.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Note that I dropped Cc: stable from my reply since it is not appropriate
at this time.

Guenter

> ---
>  drivers/watchdog/pcwd_usb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index 99ebf6ea3de6..5615f4013924 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -630,6 +630,9 @@ static int usb_pcwd_probe(struct usb_interface *interface,
>  		return -ENODEV;
>  	}
>  
> +	if (iface_desc->desc.bNumEndpoints < 1)
> +		return -ENODEV;
> +
>  	/* check out the endpoint: it has to be Interrupt & IN */
>  	endpoint = &iface_desc->endpoint[0].desc;
>  
> -- 
> 2.12.0
> 
