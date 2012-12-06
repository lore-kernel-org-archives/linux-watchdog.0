Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <50C0E0E8.3020809@mvista.com>
Date: Thu, 06 Dec 2012 21:16:08 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Wenyou Yang <wenyou.yang@atmel.com>
CC: linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
        JM.Lin@atmel.com, nicolas.ferre@atmel.com,
        linux-kernel@vger.kernel.org, wim@iguana.be, plagnioj@jcrosoft.com
Subject: Re: [v2 PATCH 6/8] watchdog/at91sam9_wdt: Use module_platform_driver()
References: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com> <1354671267-19277-7-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1354671267-19277-7-git-send-email-wenyou.yang@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hello.

On 12/05/2012 04:34 AM, Wenyou Yang wrote:

> Using module_platform_driver() replaces module_init() and module_exit()
> and makes the code simpler.

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: wim@iguana.be
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/watchdog/at91sam9_wdt.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 5afd3fb..a7c0881 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -278,6 +278,7 @@ MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
>  #endif
>  
>  static struct platform_driver at91wdt_driver = {
> +	.probe		= at91wdt_probe,

   You also need to remove '__init' annotation from that function since the
driver becomes hot-plug aware now.

WBR, Sergei
