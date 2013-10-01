Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:64879 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab3JAUst (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Oct 2013 16:48:49 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so7611548pbc.25
        for <linux-watchdog@vger.kernel.org>; Tue, 01 Oct 2013 13:48:48 -0700 (PDT)
Date: Tue, 1 Oct 2013 13:48:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [1/3] watchdog: at91rm9200: Remove redundant of_match_ptr
Message-ID: <20131001204842.GA20057@roeck-us.net>
References: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380516173-6974-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 30, 2013 at 12:42:51PM -0000, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 

Hi Sachin,

I understand that the driver doesn't currently support to be built as module,
so of_match_ptr() is not really necessary. But unless I am missing something,
here isn't anything wrong with it either, not does it hurt to have it in place.

So what is the benefit of this series ?

Thanks,
Guenter

> ---
> drivers/watchdog/at91rm9200_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
> index 1c75260..aa5cb56 100644
> --- a/drivers/watchdog/at91rm9200_wdt.c
> +++ b/drivers/watchdog/at91rm9200_wdt.c
> @@ -269,7 +269,7 @@ static struct platform_driver at91wdt_driver = {
>  	.driver		= {
>  		.name	= "at91_wdt",
>  		.owner	= THIS_MODULE,
> -		.of_match_table = of_match_ptr(at91_wdt_dt_ids),
> +		.of_match_table = at91_wdt_dt_ids,
>  	},
>  };
>  
