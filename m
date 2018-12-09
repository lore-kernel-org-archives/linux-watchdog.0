Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39947 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLIOOD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Dec 2018 09:14:03 -0500
Subject: Re: [PATCH] Watchdog: remove outdated comment
To: Hardik Singh Rathore <hardiksingh.k@gmail.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181209104726.15610-1-hardiksingh.k@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <18f7e9ee-0d8f-7c73-cdc0-7826e912d33a@roeck-us.net>
Date: Sun, 9 Dec 2018 06:13:59 -0800
MIME-Version: 1.0
In-Reply-To: <20181209104726.15610-1-hardiksingh.k@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/9/18 2:47 AM, Hardik Singh Rathore wrote:
> The lock field doesn't exist in watchdog_device structure.
> It was added by commit f4e9c82f64b5 ("watchdog: Add Locking support")
> and removed by commit b4ffb1909843
> ("watchdog: Separate and maintain variables based on variable lifetime")
> 
> Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   include/linux/watchdog.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 44985c4a1e86..417d9f37077a 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -90,9 +90,6 @@ struct watchdog_ops {
>    *
>    * The driver-data field may not be accessed directly. It must be accessed
>    * via the watchdog_set_drvdata and watchdog_get_drvdata helpers.
> - *
> - * The lock field is for watchdog core internal use only and should not be
> - * touched.
>    */
>   struct watchdog_device {
>   	int id;
> 
