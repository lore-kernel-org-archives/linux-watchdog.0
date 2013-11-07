Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:40530 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751758Ab3KGHrQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Nov 2013 02:47:16 -0500
Date: Thu, 7 Nov 2013 08:47:05 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] watchdog: pcwd_usb: overflow in usb_pcwd_send_command()
Message-ID: <20131107074705.GA10136@spo001.leaseweb.com>
References: <20131107074028.GA21844@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131107074028.GA21844@elgon.mountain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dan,

> We changed "buf" from being an array of 6 chars to being a pointer this
> sizeof(buf) needs to be updated as well.
> 
> Fixes: 2ddb8089a7e5 ('watchdog: pcwd_usb: Use allocated buffer for usb_control_msg')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index 53598e8..7031b9b 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -258,7 +258,7 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
>  
>  	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
>  			HID_REQ_SET_REPORT, HID_DT_REPORT,
> -			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
> +			0x0200, usb_pcwd->interface_number, buf, 6,
>  			USB_COMMAND_TIMEOUT) != sizeof(buf)) {
>  		dbg("usb_pcwd_send_command: error in usb_control_msg for "
>  				"cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);

Added to linux-watchdog-next.

Kind regards,
Wim.

