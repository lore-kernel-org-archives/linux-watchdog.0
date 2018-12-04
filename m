Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33860 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeLDRAY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Dec 2018 12:00:24 -0500
Subject: Re: [PATCH 2/2] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
To: Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181201145140.8088-1-tiny.windzz@gmail.com>
 <20181201145140.8088-3-tiny.windzz@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <585a9e90-297a-3cc9-2a54-49eb82b82adf@roeck-us.net>
Date: Tue, 4 Dec 2018 09:00:21 -0800
MIME-Version: 1.0
In-Reply-To: <20181201145140.8088-3-tiny.windzz@gmail.com>
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
>   drivers/watchdog/ie6xx_wdt.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
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
