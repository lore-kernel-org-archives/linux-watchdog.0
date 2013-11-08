Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57568 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab3KHOYs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Nov 2013 09:24:48 -0500
Message-ID: <527CF42E.10608@roeck-us.net>
Date: Fri, 08 Nov 2013 06:24:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch v2] watchdog: pcwd_usb: overflow in usb_pcwd_send_command()
References: <20131108092419.GA22389@elgon.mountain>
In-Reply-To: <20131108092419.GA22389@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/08/2013 01:24 AM, Dan Carpenter wrote:
> We changed "buf" from being an array of 6 chars to being a pointer this
> sizeof(buf) needs to be updated as well.
>
> Fixes: 2ddb8089a7e5 ('watchdog: pcwd_usb: Use allocated buffer for usb_control_msg')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: Fix the bug that Guenter Roeck pointed out in v1.
>
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index 53598e8..b731b5d 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -258,8 +258,8 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
>
>   	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
>   			HID_REQ_SET_REPORT, HID_DT_REPORT,
> -			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
> -			USB_COMMAND_TIMEOUT) != sizeof(buf)) {
> +			0x0200, usb_pcwd->interface_number, buf, 6,
> +			USB_COMMAND_TIMEOUT) != 6) {
>   		dbg("usb_pcwd_send_command: error in usb_control_msg for "
>   				"cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);
>   	}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

