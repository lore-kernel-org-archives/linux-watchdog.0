Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52847 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbdCMNmt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Mar 2017 09:42:49 -0400
Subject: Re: [PATCH] watchdog: pcwd_usb: fix NULL-deref at probe
To: Johan Hovold <johan@kernel.org>, Wim Van Sebroeck <wim@iguana.be>
References: <20170313124945.28923-1-johan@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a0515a2d-d219-d32d-b906-564bb789ce09@roeck-us.net>
Date: Mon, 13 Mar 2017 06:42:45 -0700
MIME-Version: 1.0
In-Reply-To: <20170313124945.28923-1-johan@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/13/2017 05:49 AM, Johan Hovold wrote:
> Make sure to check the number of endpoints to avoid dereferencing a
> NULL-pointer should a malicious device lack endpoints.
>

Is this theory or was it actually observed ?

Thanks,
Guenter

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
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
>

