Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33118 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbcHGVhI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 7 Aug 2016 17:37:08 -0400
Subject: Re: [PATCH v4] watchdog: ziirave_wdt: Add support to upload the
 firmware.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1470051586-5634-1-git-send-email-enric.balletbo@collabora.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <05209a6b-f709-cf79-2e17-c0dea08f99e6@roeck-us.net>
Date: Sun, 7 Aug 2016 14:37:00 -0700
MIME-Version: 1.0
In-Reply-To: <1470051586-5634-1-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/01/2016 04:39 AM, Enric Balletbo i Serra wrote:
> This patch adds and entry to the sysfs to start firmware upload process
> on the specified device with the requested firmware.
>
> The uploading of the firmware needs only to happen once per firmware
> upgrade, as the firmware is stored in persistent storage. If the
> firmware upload or the firmware verification fails then we print and
> error message and exit.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

[ ... ]

>
> +static ssize_t ziirave_wdt_sysfs_store_firm(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
> +	const struct firmware *fw;
> +	int err;
> +
> +	err = request_ihex_firmware(&fw, ZIIRAVE_FW_NAME, dev);
> +	if (err) {
> +		dev_err(&client->dev, "Failed to request ihex firmware\n");
> +		return err;
> +	}
> +
> +	err = mutex_lock_interruptible(&w_priv->sysfs_mutex);
> +	if (err)
> +		return err;
> +
This doesn't release the firmware.

> +	err = ziirave_firm_upload(&w_priv->wdd, fw);
> +	if (err) {
> +		dev_err(&client->dev, "The firmware update failed: %d\n", err);
> +		goto release_firmware;
> +	}
> +
> +	/* Update firmware version */
> +	err = ziirave_wdt_revision(client, &w_priv->firmware_rev,
> +				   ZIIRAVE_WDT_FIRM_VER_MAJOR);
> +	if (err) {
> +		dev_err(&client->dev, "Failed to read firmware version: %d\n",
> +			err);
> +		goto release_firmware;
> +	}
> +
> +	dev_info(&client->dev, "Firmware updated to version 02.%02u.%02u\n",
> +		 w_priv->firmware_rev.major, w_priv->firmware_rev.minor);
> +
> +	/* Restore the watchdog timeout */
> +	err = ziirave_wdt_set_timeout(&w_priv->wdd, w_priv->wdd.timeout);
> +	if (err)
> +		dev_err(&client->dev, "Failed to set timeout: %d\n", err);
> +
> +release_firmware:
> +	release_firmware(fw);
> +	mutex_unlock(&w_priv->sysfs_mutex);

Probably best to reverse the order of calls here, and add a second label
to release the firmware without releasing the lock (for use with the above).

Guenter

