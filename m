Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41498 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeLBBiZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Dec 2018 20:38:25 -0500
Subject: Re: [PATCH] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
To: Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181201101417.6368-1-tiny.windzz@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2b188937-e297-acb4-8c40-bb93ff5bbb76@roeck-us.net>
Date: Sat, 1 Dec 2018 06:25:44 -0800
MIME-Version: 1.0
In-Reply-To: <20181201101417.6368-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/1/18 2:14 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

One patch per file, please.

Guenter

> ---
>   drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
>   drivers/watchdog/ie6xx_wdt.c    | 16 +++-------------
>   2 files changed, 6 insertions(+), 26 deletions(-)
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
> diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
> index 78c2541f5d52..8de9fb1ed371 100644
> --- a/drivers/watchdog/ie6xx_wdt.c
> +++ b/drivers/watchdog/ie6xx_wdt.c
> @@ -193,7 +193,7 @@ static struct watchdog_device ie6xx_wdt_dev = {
>   
>   #ifdef CONFIG_DEBUG_FS
>   
> -static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
> +static int ie6xx_wdt_show(struct seq_file *s, void *unused)
>   {
>   	seq_printf(s, "PV1   = 0x%08x\n",
>   		inl(ie6xx_wdt_data.sch_wdtba + PV1));
> @@ -212,23 +212,13 @@ static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
>   	return 0;
>   }
>   
> -static int ie6xx_wdt_dbg_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ie6xx_wdt_dbg_show, NULL);
> -}
> -
> -static const struct file_operations ie6xx_wdt_dbg_operations = {
> -	.open		= ie6xx_wdt_dbg_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ie6xx_wdt);
>   
>   static void ie6xx_wdt_debugfs_init(void)
>   {
>   	/* /sys/kernel/debug/ie6xx_wdt */
>   	ie6xx_wdt_data.debugfs = debugfs_create_file("ie6xx_wdt",
> -		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_dbg_operations);
> +		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_fops);
>   }
>   
>   static void ie6xx_wdt_debugfs_exit(void)
> 
