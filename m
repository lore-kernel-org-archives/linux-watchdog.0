Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45768 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754158AbeDTNMd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 20 Apr 2018 09:12:33 -0400
Subject: Re: [PATCH] watchdog: renesas-wdt: Remove R-Car M2-W ES2.x from
 blacklist
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <1524226849-13301-1-git-send-email-geert+renesas@glider.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <146cf699-13da-55a0-4a55-c57bb770c867@roeck-us.net>
Date: Fri, 20 Apr 2018 06:12:29 -0700
MIME-Version: 1.0
In-Reply-To: <1524226849-13301-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/20/2018 05:20 AM, Geert Uytterhoeven wrote:
> System restart triggered by watchdog time-out works fine on a Koelsch
> board with R-Car M2-W ES2.0.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Thanks to Magnus and Shimoda-san for providing board access!
> ---
>   drivers/watchdog/renesas_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 514db5cc15951125..88d81feba4e60087 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -146,7 +146,7 @@ static const struct soc_device_attribute rwdt_quirks_match[] = {
>   		.data = (void *)1,	/* needs single CPU */
>   	}, {
>   		.soc_id = "r8a7791",
> -		.revision = "ES[12].*",
> +		.revision = "ES1.*",
>   		.data = (void *)1,	/* needs single CPU */
>   	}, {
>   		.soc_id = "r8a7792",
> 

