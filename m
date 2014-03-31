Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55820 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaCaX6R (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 31 Mar 2014 19:58:17 -0400
Message-ID: <533A0111.1050400@roeck-us.net>
Date: Mon, 31 Mar 2014 16:58:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: Fix SBC8360 dependencies
References: <20140326160001.44271284@endymion.delvare>
In-Reply-To: <20140326160001.44271284@endymion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/26/2014 08:00 AM, Jean Delvare wrote:
> According to its Kconfig help text, the sbc8360 watchdog driver is
> only used on the Axiomtek SBC8360 single-board computer. This piece of
> hardware is 32-bit x86 so the driver is useless beyond X86_32.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>   drivers/watchdog/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-3.14-rc7.orig/drivers/watchdog/Kconfig	2014-03-25 08:29:55.136283300 +0100
> +++ linux-3.14-rc7/drivers/watchdog/Kconfig	2014-03-26 15:56:35.549231692 +0100
> @@ -815,7 +815,7 @@ config 60XX_WDT
>
>   config SBC8360_WDT
>   	tristate "SBC8360 Watchdog Timer"
> -	depends on X86
> +	depends on X86_32

Makes sense to me.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

