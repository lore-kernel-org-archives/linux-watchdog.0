Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45906 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcLED7N (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 4 Dec 2016 22:59:13 -0500
Subject: Re: [PATCH] watchdog: cpwd: remove memory allocate failure message
To: akkushwaha9896@gmail.com, wim@iguana.be
References: <1480886528-13702-1-git-send-email-akkushwaha9896@gmail.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d6aac437-d9d8-5fdf-e6da-398d95a7a637@roeck-us.net>
Date: Sun, 4 Dec 2016 19:59:09 -0800
MIME-Version: 1.0
In-Reply-To: <1480886528-13702-1-git-send-email-akkushwaha9896@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/04/2016 01:22 PM, akkushwaha9896@gmail.com wrote:
> From: Amit Kushwaha <akkushwaha9896@gmail.com>
>
> This patch cleanup following warning reported by checkpatch.pl
> WARNING: Possible unnecessary 'out of memory' message
> With no available memory, a warn on message already gets printed
> by page alloc functions
>
> Signed-off-by: Amit Kushwaha <akkushwaha9896@gmail.com>
> ---
>  drivers/watchdog/cpwd.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index 71ee079..baa2d0d 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -540,10 +540,8 @@ static int cpwd_probe(struct platform_device *op)
>
>  	p = kzalloc(sizeof(*p), GFP_KERNEL);
>  	err = -ENOMEM;
> -	if (!p) {
> -		pr_err("Unable to allocate struct cpwd\n");
> +	if (!p)
>  		goto out;
> -	}

If you look closely, that goto is quite useless and should be replaced with
a direct return statement Plus, replacing the kzalloc() with devm_kzalloc()
and dropping the kfree() calls would be much more valuable.

Guenter

