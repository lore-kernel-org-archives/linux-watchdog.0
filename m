Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 7 Nov 2013 17:33:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] watchdog: pcwd_usb: overflow in usb_pcwd_send_command()
Message-ID: <20131107143356.GP20521@mwanda>
References: <20131107074028.GA21844@elgon.mountain>
 <527BA351.10705@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527BA351.10705@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Nov 07, 2013 at 06:27:29AM -0800, Guenter Roeck wrote:
> On 11/06/2013 11:40 PM, Dan Carpenter wrote:
> >We changed "buf" from being an array of 6 chars to being a pointer this
> >sizeof(buf) needs to be updated as well.
> >
> oops ...
> 
> >Fixes: 2ddb8089a7e5 ('watchdog: pcwd_usb: Use allocated buffer for usb_control_msg')
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> >diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> >index 53598e8..7031b9b 100644
> >--- a/drivers/watchdog/pcwd_usb.c
> >+++ b/drivers/watchdog/pcwd_usb.c
> >@@ -258,7 +258,7 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
> >
> >  	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
> >  			HID_REQ_SET_REPORT, HID_DT_REPORT,
> >-			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
> >+			0x0200, usb_pcwd->interface_number, buf, 6,
> >  			USB_COMMAND_TIMEOUT) != sizeof(buf)) {
> 
> Doesn't it have to be fixed here as well ?

Yeah.  Good eye.  I'll send a v2.

regards,
dan carpenter
