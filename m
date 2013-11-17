Return-Path: <wimvs@spo001.leaseweb.com>
Date: Sun, 17 Nov 2013 20:06:31 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch v2] watchdog: pcwd_usb: overflow in usb_pcwd_send_command()
Message-ID: <20131117190631.GG10136@spo001.leaseweb.com>
References: <527BA351.10705@roeck-us.net> <20131108092419.GA22389@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131108092419.GA22389@elgon.mountain>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Dan,

> We changed "buf" from being an array of 6 chars to being a pointer this
> sizeof(buf) needs to be updated as well.
> 
> Fixes: 2ddb8089a7e5 ('watchdog: pcwd_usb: Use allocated buffer for usb_control_msg')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Fix the bug that Guenter Roeck pointed out in v1.

This was added to linux-watchdog-next.

Kind regards,
Wim.
