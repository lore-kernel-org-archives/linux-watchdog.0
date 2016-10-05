Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46898 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbcJENS3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Oct 2016 09:18:29 -0400
Subject: Re: [PATCH] watchdog: ath79_wdt: fix build failure
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1475645318-15254-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a20426b8-921f-f3fa-a106-7ee7cdddacb3@roeck-us.net>
Date: Wed, 5 Oct 2016 06:18:24 -0700
MIME-Version: 1.0
In-Reply-To: <1475645318-15254-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/04/2016 10:28 PM, Sudip Mukherjee wrote:
> The build of mips ath79_defconfig was failing with the error:
> drivers/watchdog/ath79_wdt.c:164:5:
> 	error: implicit declaration of function 'get_user'
> drivers/watchdog/ath79_wdt.c:196:3:
> 	error: implicit declaration of function 'copy_to_user'
> drivers/watchdog/ath79_wdt.c:201:3:
> 	error: implicit declaration of function 'put_user'
>
> Quoting Al Viro - "another victim of indirect include chains"
>
> Fixes: 58a8f3b69e07 ("mips: separate extable.h, switch module.h to it")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
> build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/164834126
>
>  drivers/watchdog/ath79_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> index 835d310..e2209bf 100644
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c
> @@ -35,6 +35,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/uaccess.h>
>
>  #define DRIVER_NAME	"ath79-wdt"
>
>

