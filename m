Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59902 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab3LUSAl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Dec 2013 13:00:41 -0500
Message-ID: <52B5D748.9030508@roeck-us.net>
Date: Sat, 21 Dec 2013 10:00:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Watchdog: pcwd_usb: remove CONFIG_USB_DEBUG usage
References: <20131219234410.GD4884@kroah.com>
In-Reply-To: <20131219234410.GD4884@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/19/2013 03:44 PM, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> CONFIG_USB_DEBUG is going away, and all of the other USB drivers no
> longer rely on "debug" module parameters for debugging lines, so move
> the pcwd_usb driver to use the dynamic debug infrastructure to be more
> in line with the rest of the kernel.
>
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

