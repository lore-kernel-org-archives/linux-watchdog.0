Return-Path: <wimvs@spo001.leaseweb.com>
Date: Tue, 29 Oct 2013 08:51:38 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] watchdog: pcwd_usb: Use allocated buffer for usb_control_msg
Message-ID: <20131029075138.GG19704@spo001.leaseweb.com>
References: <1381768174-15395-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381768174-15395-1-git-send-email-linux@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> usb_control_msg() must use a dma-capable buffer.
> 
> This fixes the following error reported by smatch:
> 
> drivers/watchdog/pcwd_usb.c:257 usb_pcwd_send_command() error: doing dma on the
> stack (buf)
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/pcwd_usb.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

This patch has been added to linux-watchog-next.

Kind regards,
Wim.
