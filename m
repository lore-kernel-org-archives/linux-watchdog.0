Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:50291 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdJ0BFT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Oct 2017 21:05:19 -0400
Received: by mail-pg0-f66.google.com with SMTP id y5so4023970pgq.7
        for <linux-watchdog@vger.kernel.org>; Thu, 26 Oct 2017 18:05:19 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] watchdog: i6300esb: remove info message and
 version number
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
References: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
 <20171026161016.3198-4-rrendec@arista.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bf7f6cc8-73da-19a1-d54c-438b5ede1b57@roeck-us.net>
Date: Thu, 26 Oct 2017 18:05:17 -0700
MIME-Version: 1.0
In-Reply-To: <20171026161016.3198-4-rrendec@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/26/2017 09:10 AM, Radu Rendec wrote:
> The initial info message (early in the esb_probe() function) is not very
> useful and we already have a message on successful probe, which includes
> device identification. If the probe fails (e.g. PCI related errors),
> additional messages are printed anyway.
> 
> The version number was only used in the initial info message. Other than
> that, it serves no useful purpose and it ran out of favor upstream
> anyway.
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

... and thanks a lot for doing this!

Guenter

> ---
>   drivers/watchdog/i6300esb.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index 4d92925cdc1e..950c71a8bb22 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -30,8 +30,6 @@
>    *      Includes, defines, variables, module parameters, ...
>    */
>   
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>   #include <linux/module.h>
>   #include <linux/types.h>
>   #include <linux/kernel.h>
> @@ -45,7 +43,6 @@
>   #include <linux/io.h>
>   
>   /* Module and version information */
> -#define ESB_VERSION "0.05"
>   #define ESB_MODULE_NAME "i6300ESB timer"
>   
>   /* PCI configuration registers */
> @@ -76,9 +73,6 @@
>   #define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
>   #define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
>   
> -/* Probed devices counter; used only for printing the initial info message */
> -static int cards_found;
> -
>   /* module parameters */
>   /* 30 sec default heartbeat (1 < heartbeat < 2*1023) */
>   #define ESB_HEARTBEAT_MIN	1
> @@ -302,11 +296,6 @@ static int esb_probe(struct pci_dev *pdev,
>   	struct esb_dev *edev;
>   	int ret;
>   
> -	cards_found++;
> -	if (cards_found == 1)
> -		pr_info("Intel 6300ESB WatchDog Timer Driver v%s\n",
> -			ESB_VERSION);
> -
>   	edev = devm_kzalloc(&pdev->dev, sizeof(*edev), GFP_KERNEL);
>   	if (!edev)
>   		return -ENOMEM;
> 

