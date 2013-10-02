Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:53191 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3JBPPr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Oct 2013 11:15:47 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so1014720pdj.34
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Oct 2013 08:15:46 -0700 (PDT)
Date: Wed, 2 Oct 2013 08:15:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [2/3] watchdog: orion: Remove redundant of_match_ptr
Message-ID: <20131002151541.GA14696@roeck-us.net>
References: <1380516173-6974-2-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380516173-6974-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 30, 2013 at 12:42:52PM -0000, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> drivers/watchdog/orion_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 4ea5fcc..34adb54 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -207,7 +207,7 @@ static struct platform_driver orion_wdt_driver = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "orion_wdt",
> -		.of_match_table = of_match_ptr(orion_wdt_of_match_table),
> +		.of_match_table = orion_wdt_of_match_table,
>  	},
>  };
>  
