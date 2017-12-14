Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35082 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbdLNOaU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 14 Dec 2017 09:30:20 -0500
Subject: Re: [PATCH] watchdog: document watchdog_init_timeout() wdd parameter
To: Corentin Labbe <clabbe.montjoie@gmail.com>, wim@iguana.be
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171213194140.1717-1-clabbe.montjoie@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <58961686-e995-8b0d-3e35-877e2da73290@roeck-us.net>
Date: Thu, 14 Dec 2017 06:30:17 -0800
MIME-Version: 1.0
In-Reply-To: <20171213194140.1717-1-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/13/2017 11:41 AM, Corentin Labbe wrote:
> All parameters of watchdog_init_timeout() are documented with exception
> of wdd, thus generating a build warning.
> 
> This patch document it and so remove the following build warning:
> drivers/watchdog/watchdog_core.c:113: warning: No description found for parameter 'wdd'
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 8a8d952f8df9..eb8fa25f8eb2 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -97,6 +97,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>   
>   /**
>    * watchdog_init_timeout() - initialize the timeout field
> + * @wdd: watchdog device
>    * @timeout_parm: timeout module parameter
>    * @dev: Device that stores the timeout-sec property
>    *
> 

