Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51292 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcFANUm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Jun 2016 09:20:42 -0400
Subject: Re: [PATCH] watchdog: pcwd: Utilize the module_isa_driver macro
To: William Breathitt Gray <vilhelm.gray@gmail.com>, wim@iguana.be
References: <20160601130548.GA13035@sophia>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <574EE12B.3050308@roeck-us.net>
Date: Wed, 1 Jun 2016 06:20:43 -0700
MIME-Version: 1.0
In-Reply-To: <20160601130548.GA13035@sophia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/01/2016 06:05 AM, William Breathitt Gray wrote:
> This driver does not do anything special in module init/exit. This patch
> eliminates the module init/exit boilerplate code by utilizing the
> module_isa_driver macro.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/pcwd.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
> index e936f15..3ad5206 100644
> --- a/drivers/watchdog/pcwd.c
> +++ b/drivers/watchdog/pcwd.c
> @@ -992,19 +992,7 @@ static struct isa_driver pcwd_isa_driver = {
>   	},
>   };
>
> -static int __init pcwd_init_module(void)
> -{
> -	return isa_register_driver(&pcwd_isa_driver, PCWD_ISA_NR_CARDS);
> -}
> -
> -static void __exit pcwd_cleanup_module(void)
> -{
> -	isa_unregister_driver(&pcwd_isa_driver);
> -	pr_info("Watchdog Module Unloaded\n");
> -}
> -
> -module_init(pcwd_init_module);
> -module_exit(pcwd_cleanup_module);
> +module_isa_driver(pcwd_isa_driver, PCWD_ISA_NR_CARDS);
>
>   MODULE_AUTHOR("Ken Hollis <kenji@bitgate.com>, "
>   		"Wim Van Sebroeck <wim@iguana.be>");
>

