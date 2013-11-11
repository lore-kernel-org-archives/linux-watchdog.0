Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:60746 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab3KKQAY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Nov 2013 11:00:24 -0500
Date: Mon, 11 Nov 2013 08:00:21 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch v2] watchdog: pcwd_usb: overflow in
 usb_pcwd_send_command()
Message-ID: <20131111160021.GA24135@roeck-us.net>
References: <527BA351.10705@roeck-us.net>
 <20131108092419.GA22389@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131108092419.GA22389@elgon.mountain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 08, 2013 at 01:24:19AM -0800, Dan Carpenter wrote:
> We changed "buf" from being an array of 6 chars to being a pointer this
> sizeof(buf) needs to be updated as well.
> 
> Fixes: 2ddb8089a7e5 ('watchdog: pcwd_usb: Use allocated buffer for usb_control_msg')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I thought I had replied earlier, but I don't find my reply anywhere.
My apologies if this is a duplicate.

Guenter
