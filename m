Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:25214 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdLFWx6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 6 Dec 2017 17:53:58 -0500
Date: Wed, 6 Dec 2017 15:53:56 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jimmy Vance <jimmy.vance@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: hpwdt: fix unused variable warning
Message-ID: <20171206225356.GC17031@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20171206210250.1222757-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206210250.1222757-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 06, 2017 at 10:02:37PM +0100, Arnd Bergmann wrote:
> The new hpwdt_my_nmi() function is used conditionally, which produces
> a harmless warning in some configurations:
> 
> drivers/watchdog/hpwdt.c:478:12: error: 'hpwdt_my_nmi' defined but not used [-Werror=unused-function]
> 
> This moves it inside of the #ifdef that protects its caller, to silence
> the warning.
> 
> Fixes: 621174a92851 ("watchdog: hpwdt: Check source of NMI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/watchdog/hpwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index e61658310381..f1f00dfc0e68 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -475,12 +475,12 @@ static int hpwdt_time_left(void)
>  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
>  }
>  
> +#ifdef CONFIG_HPWDT_NMI_DECODING
>  static int hpwdt_my_nmi(void)
>  {
>  	return ioread8(hpwdt_nmistat) & 0x6;
>  }
>  
> -#ifdef CONFIG_HPWDT_NMI_DECODING
>  /*
>   *	NMI Handler
>   */
> -- 
> 2.9.0
> 


Looks fine. Thanks!


Reviewed-by: Jerry Hoemann <jerry.hoemann@hpe.com>


-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
