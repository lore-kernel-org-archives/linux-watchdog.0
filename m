Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sun, 17 Jul 2016 21:49:59 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd: Utilize the module_isa_driver macro
Message-ID: <20160717194959.GB32751@spo001.leaseweb.nl>
References: <20160601130548.GA13035@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160601130548.GA13035@sophia>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi William,

> This driver does not do anything special in module init/exit. This patch
> eliminates the module init/exit boilerplate code by utilizing the
> module_isa_driver macro.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/watchdog/pcwd.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
> index e936f15..3ad5206 100644
> --- a/drivers/watchdog/pcwd.c
> +++ b/drivers/watchdog/pcwd.c
> @@ -992,19 +992,7 @@ static struct isa_driver pcwd_isa_driver = {
>  	},
>  };
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
>  MODULE_AUTHOR("Ken Hollis <kenji@bitgate.com>, "
>  		"Wim Van Sebroeck <wim@iguana.be>");
> -- 
> 2.7.3
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
