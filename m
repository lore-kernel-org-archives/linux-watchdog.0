Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2013 08:53:10 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb <linux-usb@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: usb_control_msg and non-dma buffers
Message-ID: <20131014155310.GA3474@kroah.com>
References: <525C1218.7060901@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525C1218.7060901@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Oct 14, 2013 at 08:47:36AM -0700, Guenter Roeck wrote:
> Hi all,
> 
> I am getting the following smatch error in drivers/watchdog/pcwd_usb.c:
> 
> drivers/watchdog/pcwd_usb.c:257 usb_pcwd_send_command() error: doing dma on the stack (buf)
> 
> This is from a call to usb_control_msg().
> 
> Is this a false positive or a real problem that needs to be fixed ?

It is a real problem that must be fixed.

You can't send USB data off of the stack and expect the driver to work
on all controllers and platforms.

thanks,

greg k-h
