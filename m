Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41341 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeKUBEZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Nov 2018 20:04:25 -0500
Subject: Re: [PATCH] watchdog: cpwd: add of_node_put()
To: Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181120132359.19799-1-tiny.windzz@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8abef7ab-1d77-cf88-748c-11e54c760f34@roeck-us.net>
Date: Tue, 20 Nov 2018 06:34:56 -0800
MIME-Version: 1.0
In-Reply-To: <20181120132359.19799-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/20/18 5:23 AM, Yangtao Li wrote:
> use of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   drivers/watchdog/cpwd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index aee0b25cf10d..d3a81642ada5 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -617,6 +617,7 @@ static int cpwd_probe(struct platform_device *op)
>   
>   	platform_set_drvdata(op, p);
>   	cpwd_device = p;
> +	of_node_put(options);

It would be better to do that right after its last use to also cover
error handling.

Guenter

>   	return 0;
>   
>   out_unregister:
> 
