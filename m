Return-path: <martyn.welch@collabora.co.uk>
Message-ID: <568F8C6F.4050702@collabora.co.uk>
Date: Fri, 08 Jan 2016 10:16:15 +0000
From: Martyn Welch <martyn.welch@collabora.co.uk>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: ziirave: Use watchdog infrastructure to
 create sysfs attributes
References: <1451862718-31073-1-git-send-email-linux@roeck-us.net> <1451862718-31073-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1451862718-31073-3-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 03/01/16 23:11, Guenter Roeck wrote:
> The watchdog core now supports creating driver specific sysfs attributes
> when creating the watchdog device.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Martyn Welch <martyn.welch@collabora.co.uk>

(Sorry for the delayed response, this email got caught by my spam filtering)

> ---
>   drivers/watchdog/ziirave_wdt.c | 20 +++-----------------
>   1 file changed, 3 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
> index b498fdcc231a..0c7cb7302cf0 100644
> --- a/drivers/watchdog/ziirave_wdt.c
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -207,10 +207,7 @@ static struct attribute *ziirave_wdt_attrs[] = {
>   	&dev_attr_reset_reason.attr,
>   	NULL
>   };
> -
> -static const struct attribute_group ziirave_wdt_sysfs_files = {
> -	.attrs  = ziirave_wdt_attrs,
> -};
> +ATTRIBUTE_GROUPS(ziirave_wdt);
>
>   static int ziirave_wdt_init_duration(struct i2c_client *client)
>   {
> @@ -260,6 +257,7 @@ static int ziirave_wdt_probe(struct i2c_client *client,
>   	w_priv->wdd.min_timeout = ZIIRAVE_TIMEOUT_MIN;
>   	w_priv->wdd.max_timeout = ZIIRAVE_TIMEOUT_MAX;
>   	w_priv->wdd.parent = &client->dev;
> +	w_priv->wdd.groups = ziirave_wdt_groups;
>
>   	ret = watchdog_init_timeout(&w_priv->wdd, wdt_timeout, &client->dev);
>   	if (ret) {
> @@ -327,26 +325,14 @@ static int ziirave_wdt_probe(struct i2c_client *client,
>   		return -ENODEV;
>
>   	ret = watchdog_register_device(&w_priv->wdd);
> -	if (ret)
> -		return ret;
> -
> -	ret = sysfs_create_group(&w_priv->wdd.dev->kobj,
> -				 &ziirave_wdt_sysfs_files);
> -	if (ret) {
> -		watchdog_unregister_device(&w_priv->wdd);
>
> -		return ret;
> -	}
> -
> -	return 0;
> +	return ret;
>   }
>
>   static int ziirave_wdt_remove(struct i2c_client *client)
>   {
>   	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
>
> -	sysfs_remove_group(&client->dev.kobj, &ziirave_wdt_sysfs_files);
> -
>   	watchdog_unregister_device(&w_priv->wdd);
>
>   	return 0;
>
