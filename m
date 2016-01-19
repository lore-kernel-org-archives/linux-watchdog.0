Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42340 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbcASOST (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jan 2016 09:18:19 -0500
Subject: Re: [watchdog-next] watchdog: pcwd_usb: fix compilation warning
To: Tomas Winkler <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1453211464-25503-1-git-send-email-tomas.winkler@intel.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <569E45A9.3040201@roeck-us.net>
Date: Tue, 19 Jan 2016 06:18:17 -0800
MIME-Version: 1.0
In-Reply-To: <1453211464-25503-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/19/2016 05:51 AM, Tomas Winkler wrote:
> In function ‘usb_pcwd_probe’:
> drivers/watchdog/pcwd_usb.c:611:12: warning: variable ‘maxp’ set but not
> used [-Wunused-but-set-variable]
>    int pipe, maxp;
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/pcwd_usb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index 1a11aedc4fe8..68952d9ccf83 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -608,7 +608,7 @@ static int usb_pcwd_probe(struct usb_interface *interface,
>   	struct usb_host_interface *iface_desc;
>   	struct usb_endpoint_descriptor *endpoint;
>   	struct usb_pcwd_private *usb_pcwd = NULL;
> -	int pipe, maxp;
> +	int pipe;
>   	int retval = -ENOMEM;
>   	int got_fw_rev;
>   	unsigned char fw_rev_major, fw_rev_minor;
> @@ -641,7 +641,6 @@ static int usb_pcwd_probe(struct usb_interface *interface,
>
>   	/* get a handle to the interrupt data pipe */
>   	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
> -	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
>
>   	/* allocate memory for our device and initialize it */
>   	usb_pcwd = kzalloc(sizeof(struct usb_pcwd_private), GFP_KERNEL);
>

