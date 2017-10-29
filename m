Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44421 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdJ2WnC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 29 Oct 2017 18:43:02 -0400
Subject: Re: [watchdog] watchdog: mei_wdt: don't use of variable length array
To: Tomas Winkler <tomas.winkler@intel.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171029075119.15667-1-tomas.winkler@intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <277055c5-6e04-6e15-d2e8-9a81bb1f62cf@roeck-us.net>
Date: Sun, 29 Oct 2017 15:43:00 -0700
MIME-Version: 1.0
In-Reply-To: <20171029075119.15667-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/29/2017 12:51 AM, Tomas Winkler wrote:
> Fixes sparse warning:
> drivers/watchdog/mei_wdt.c:530:18: warning: Variable length array is used
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mei_wdt.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> index ea60b29494fb..b8194b02abe0 100644
> --- a/drivers/watchdog/mei_wdt.c
> +++ b/drivers/watchdog/mei_wdt.c
> @@ -526,12 +526,11 @@ static ssize_t mei_dbgfs_read_state(struct file *file, char __user *ubuf,
>   				    size_t cnt, loff_t *ppos)
>   {
>   	struct mei_wdt *wdt = file->private_data;
> -	const size_t bufsz = 32;
> -	char buf[bufsz];
> +	char buf[32];
>   	ssize_t pos;
>   
> -	pos = scnprintf(buf, bufsz, "state: %s\n",
> -			 mei_wdt_state_str(wdt->state));
> +	pos = scnprintf(buf, sizeof(buf), "state: %s\n",
> +			mei_wdt_state_str(wdt->state));
>   
>   	return simple_read_from_buffer(ubuf, cnt, ppos, buf, pos);
>   }
> 

