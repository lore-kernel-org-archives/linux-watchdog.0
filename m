Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40619 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeLDQ7c (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Dec 2018 11:59:32 -0500
Subject: Re: [PATCH 1/2] watchdog: bcm281xx: convert to DEFINE_SHOW_ATTRIBUTE
To: Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181201145140.8088-1-tiny.windzz@gmail.com>
 <20181201145140.8088-2-tiny.windzz@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b041b3a1-124a-ac48-5366-718a7dea5b9d@roeck-us.net>
Date: Tue, 4 Dec 2018 08:59:28 -0800
MIME-Version: 1.0
In-Reply-To: <20181201145140.8088-2-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/1/18 6:51 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index 1462be9e6fc5..4249b47902bd 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -90,7 +90,7 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
>   
>   #ifdef CONFIG_BCM_KONA_WDT_DEBUG
>   
> -static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
> +static int bcm_kona_show(struct seq_file *s, void *data)
>   {
>   	int ctl_val, cur_val;
>   	unsigned long flags;
> @@ -130,17 +130,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, bcm_kona_wdt_dbg_show, inode->i_private);
> -}
> -
> -static const struct file_operations bcm_kona_dbg_operations = {
> -	.open		= bcm_kona_dbg_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(bcm_kona);
>   
>   static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
>   {
> @@ -157,7 +147,7 @@ static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
>   		return;
>   
>   	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
> -				&bcm_kona_dbg_operations))
> +				&bcm_kona_fops))
>   		wdt->debugfs = dir;
>   	else
>   		debugfs_remove_recursive(dir);
> 
