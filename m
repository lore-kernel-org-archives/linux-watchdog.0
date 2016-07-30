Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56974 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcG3Qqi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 30 Jul 2016 12:46:38 -0400
Subject: Re: [PATCH v3] watchdog: ziirave_wdt: Add support to upload the
 firmware.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1469702269-32268-1-git-send-email-enric.balletbo@collabora.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <579CD9E4.9070905@roeck-us.net>
Date: Sat, 30 Jul 2016 09:46:28 -0700
MIME-Version: 1.0
In-Reply-To: <1469702269-32268-1-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/28/2016 03:37 AM, Enric Balletbo i Serra wrote:
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
>
> Changes since v2: (requested by Guenter)
>   - Remove ihex parsing, convert the file into binary before passing it to the
>     kernel (ihex2fw <src.HEX> <dst.fw>).
>   - New binary firmware parsed using the ihex.h helpers.
>   - Protect firmware upgrade with a mutex.
>   - Remove a noisy message.
>   - Remove some unneded memset.
>   - Remove some unnecessary ()
>
> Changes since v1: (requested by Martyn)
>   - Remove two defines that are not used.
>   - Fix typo in documentation count -> length
>
>   drivers/watchdog/ziirave_wdt.c | 363 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 363 insertions(+)
>
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
> index fa1efef..81c8545 100644
> --- a/drivers/watchdog/ziirave_wdt.c
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -18,7 +18,10 @@
>    * GNU General Public License for more details.
>    */
>
> +#include <linux/delay.h>
>   #include <linux/i2c.h>
> +#include <linux/ihex.h>
> +#include <linux/firmware.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/slab.h>
> @@ -36,6 +39,8 @@
>   #define ZIIRAVE_STATE_OFF	0x1
>   #define ZIIRAVE_STATE_ON	0x2
>
> +#define ZIIRAVE_FW_NAME		"ziirave_wdt.fw"
> +
>   static char *ziirave_reasons[] = {"power cycle", "hw watchdog", NULL, NULL,
>   				  "host request", NULL, "illegal configuration",
>   				  "illegal instruction", "illegal trap",
> @@ -50,12 +55,32 @@ static char *ziirave_reasons[] = {"power cycle", "hw watchdog", NULL, NULL,
>   #define ZIIRAVE_WDT_PING		0x9
>   #define ZIIRAVE_WDT_RESET_DURATION	0xa
>
> +#define ZIIRAVE_FIRM_PKT_TOTAL_SIZE	20
> +#define ZIIRAVE_FIRM_PKT_DATA_SIZE	16
> +#define ZIIRAVE_FIRM_FLASH_MEMORY_START	0x1600
> +#define ZIIRAVE_FIRM_FLASH_MEMORY_END	0x2bbf
> +
> +/* Received and ready for next Download packet. */
> +#define ZIIRAVE_FIRM_DOWNLOAD_ACK	1
> +/* Currently writing to flash. Retry Download status in a moment! */
> +#define ZIIRAVE_FIRM_DOWNLOAD_BUSY	2
> +
> +/* Firmware commands */
> +#define ZIIRAVE_CMD_DOWNLOAD_START		0x10
> +#define ZIIRAVE_CMD_DOWNLOAD_END		0x11
> +#define ZIIRAVE_CMD_DOWNLOAD_SET_READ_ADDR	0x12
> +#define ZIIRAVE_CMD_DOWNLOAD_READ_BYTE		0x13
> +#define ZIIRAVE_CMD_RESET_PROCESSOR		0x0b
> +#define ZIIRAVE_CMD_JUMP_TO_BOOTLOADER		0x0c
> +#define ZIIRAVE_CMD_DOWNLOAD_PACKET		0x0e
> +
>   struct ziirave_wdt_rev {
>   	unsigned char major;
>   	unsigned char minor;
>   };
>
>   struct ziirave_wdt_data {
> +	struct mutex sysfs_mutex;
>   	struct watchdog_device wdd;
>   	struct ziirave_wdt_rev bootloader_rev;
>   	struct ziirave_wdt_rev firmware_rev;
> @@ -146,6 +171,288 @@ static unsigned int ziirave_wdt_get_timeleft(struct watchdog_device *wdd)
>   	return ret;
>   }
>
> +static int ziirave_firm_wait_for_ack(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	int ret;
> +
> +	do {
> +		usleep_range(5000, 5100);

That range is both quite narrow and large. A wider range might be better
to give the kernel some leeway.

> +		ret = i2c_smbus_read_byte(client);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "Failed to read byte\n");
> +			return ret;
> +		}
> +	} while (ret == ZIIRAVE_FIRM_DOWNLOAD_BUSY);
> +

Please add some reasonable timeout here.

> +	return ret == ZIIRAVE_FIRM_DOWNLOAD_ACK ? 0 : -EIO;
> +}
> +
> +static int ziirave_firm_set_read_addr(struct watchdog_device *wdd, u16 addr)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	u8 address[2];
> +
> +	address[0] = addr & 0xff;
> +	address[1] = (addr >> 8) & 0xff;
> +
> +	return i2c_smbus_write_block_data(client,
> +					  ZIIRAVE_CMD_DOWNLOAD_SET_READ_ADDR,
> +					  ARRAY_SIZE(address), address);
> +}
> +
> +static int ziirave_firm_write_block_data(struct watchdog_device *wdd,
> +					 u8 command, u8 length, const u8 *data,
> +					 bool wait_for_ack)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	int ret;
> +
> +	ret = i2c_smbus_write_block_data(client, command, length, data);
> +
Please drop empty lines between assignments and value checks.

> +	if (ret) {
> +		dev_err(&client->dev,
> +			"Failed to send command 0x%02x: %d\n", command, ret);
> +		return ret;
> +	}
> +
> +	if (wait_for_ack)
> +		ret = ziirave_firm_wait_for_ack(wdd);
> +
> +	return ret;
> +}
> +
> +static int ziirave_firm_write_byte(struct watchdog_device *wdd, u8 command,
> +				   u8 byte, bool wait_for_ack)
> +{
> +	return ziirave_firm_write_block_data(wdd, command, 1, &byte,
> +					     wait_for_ack);
> +}
> +
> +/*
> + * ziirave_firm_write_pkt() - Build and write a firmware packet
> + *
> + * A packet to send to the firmware is composed by following bytes:
> + *     Length | Addr0 | Addr1 | Data0 .. Data15 | Checksum |
> + * Where,
> + *     Length: A data byte containing the length of the data.
> + *     Addr0: Low byte of the address.
> + *     Addr1: High byte of the address.
> + *     Data0 .. Data15: Array of 16 bytes of data.
> + *     Checksum: Checksum byte to verify data integrity.
> + */
> +static int ziirave_firm_write_pkt(struct watchdog_device *wdd,
> +				  const struct ihex_binrec *rec)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	u8 i, checksum = 0, packet[ZIIRAVE_FIRM_PKT_TOTAL_SIZE];
> +	int ret;
> +	u16 addr;
> +
> +	memset(packet, 0, ARRAY_SIZE(packet));
> +
> +	/* Packet length */
> +	packet[0] = (u8)be16_to_cpu(rec->len);
> +	/* Packet address */
> +	addr = (be32_to_cpu(rec->addr) & 0xffff) >> 1;
> +	packet[1] = (u8)(addr & 0xff);
> +	packet[2] = (u8)((addr & 0xff00) >> 8);
> +
Unnecessary typecasts.

> +	/* Packet data */
> +	if (be16_to_cpu(rec->len) > ZIIRAVE_FIRM_PKT_DATA_SIZE)
> +		return -EMSGSIZE;
> +	memcpy(packet + 3, rec->data, be16_to_cpu(rec->len));
> +
> +	/* Packet checksum */
> +	for (i = 0; i < ZIIRAVE_FIRM_PKT_TOTAL_SIZE - 1; i++)
> +		checksum += packet[i];
> +	packet[ZIIRAVE_FIRM_PKT_TOTAL_SIZE - 1] = checksum;
> +
> +	ret = ziirave_firm_write_block_data(wdd, ZIIRAVE_CMD_DOWNLOAD_PACKET,
> +					    ARRAY_SIZE(packet), packet, true);
> +	if (ret)
> +		dev_err(&client->dev,
> +		      "Failed to write firmware packet at address 0x%04x: %d\n",
> +		      addr, ret);
> +
> +	return ret;
> +}
> +
> +static int ziirave_firm_verify(struct watchdog_device *wdd,
> +			       const struct firmware *fw)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	const struct ihex_binrec *rec;
> +	int i, ret;
> +	u8 data[ZIIRAVE_FIRM_PKT_DATA_SIZE];
> +	u16 addr;
> +
> +	for (rec = (void *)fw->data; rec; rec = ihex_next_binrec(rec)) {
> +		/* Zero length marks end of records */
> +		if (!be16_to_cpu(rec->len))
> +			break;
> +
> +		addr = (be32_to_cpu(rec->addr) & 0xffff) >> 1;
> +		if (addr < ZIIRAVE_FIRM_FLASH_MEMORY_START ||
> +		    addr > ZIIRAVE_FIRM_FLASH_MEMORY_END)
> +			continue;
> +
> +		ret = ziirave_firm_set_read_addr(wdd, addr);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"Failed to send SET_READ_ADDR command: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		for (i = 0; i < ARRAY_SIZE(data); i++) {
> +			ret = i2c_smbus_read_byte_data(client,
> +						ZIIRAVE_CMD_DOWNLOAD_READ_BYTE);
> +			if (ret < 0) {
> +				dev_err(&client->dev,
> +					"Failed to READ DATA: %d\n", ret);
> +				return ret;
> +			}
> +			data[i] = (u8)ret;

Unnecessary typecast.

> +		}
> +
> +		if (memcmp(data, rec->data, be16_to_cpu(rec->len))) {
> +			dev_err(&client->dev,
> +				"Firmware mismatch at address 0x%04x\n", addr);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ziirave_firm_upload(struct watchdog_device *wdd,
> +			       const struct firmware *fw)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	int ret, words_till_page_break;
> +	const struct ihex_binrec *rec;
> +	struct ihex_binrec *rec_new;
> +
> +	ret = ziirave_firm_write_byte(wdd, ZIIRAVE_CMD_JUMP_TO_BOOTLOADER, 1,
> +				      false);
> +	if (ret)
> +		return ret;
> +
> +	msleep(500);
> +
> +	ret = ziirave_firm_write_byte(wdd, ZIIRAVE_CMD_DOWNLOAD_START, 1, true);
> +	if (ret)
> +		return ret;
> +
> +	msleep(500);
> +
> +	for (rec = (void *)fw->data; rec; rec = ihex_next_binrec(rec)) {
> +		/* Zero length marks end of records */
> +		if (!be16_to_cpu(rec->len))
> +			break;
> +
> +		/* Check max data size */
> +		if (be16_to_cpu(rec->len) > ZIIRAVE_FIRM_PKT_DATA_SIZE) {
> +			dev_err(&client->dev, "Firmware packet too long (%d)\n",
> +				be16_to_cpu(rec->len));
> +			return -EMSGSIZE;
> +		}
> +
> +		/* Calculate words till page break */
> +		words_till_page_break = (64 - ((be32_to_cpu(rec->addr) >> 1) &
> +					 0x3f));
> +		if ((be16_to_cpu(rec->len) >> 1) > words_till_page_break) {
> +			/*
> +			 * Data in passes page boundary, so we need to split in
> +			 * two blocks of data. Create a packet with the first
> +			 * block of data.
> +			 */
> +			rec_new = kzalloc(sizeof(struct ihex_binrec) +
> +					  (words_till_page_break << 1),
> +					  GFP_KERNEL);
> +			if (!rec_new)
> +				return -ENOMEM;
> +
> +			rec_new->len = cpu_to_be16(words_till_page_break << 1);
> +			rec_new->addr = rec->addr;
> +			memcpy(rec_new->data, rec->data,
> +			       be16_to_cpu(rec_new->len));
> +
> +			ret = ziirave_firm_write_pkt(wdd, rec_new);
> +			kfree(rec_new);
> +			if (ret)
> +				return ret;
> +
> +			/* Create a packet with the second block of data */
> +			rec_new = kzalloc(sizeof(struct ihex_binrec) +
> +					  be16_to_cpu(rec->len) -
> +					  (words_till_page_break << 1),
> +					  GFP_KERNEL);
> +			if (!rec_new)
> +				return -ENOMEM;
> +
> +			/* Remaining bytes */
> +			rec_new->len = rec->len -
> +				       cpu_to_be16(words_till_page_break << 1);
> +
> +			rec_new->addr = cpu_to_be32(be32_to_cpu(rec->addr) +
> +					(words_till_page_break << 1));
> +
> +			memcpy(rec_new->data,
> +			       rec->data + (words_till_page_break << 1),
> +			       be16_to_cpu(rec_new->len));
> +
> +			ret = ziirave_firm_write_pkt(wdd, rec_new);
> +			kfree(rec_new);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = ziirave_firm_write_pkt(wdd, rec);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	/* For end of download, the length field will be set to 0 */
> +	rec_new = kzalloc(sizeof(struct ihex_binrec) + 1, GFP_KERNEL);
> +	if (!rec_new)
> +		return -ENOMEM;
> +
> +	ret = ziirave_firm_write_pkt(wdd, rec_new);
> +	kfree(rec_new);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to send EMPTY packet: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* This sleep seems to be required */
> +	msleep(20);
> +
> +	/* Start firmware verification */
> +	ret = ziirave_firm_verify(wdd, fw);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"Failed to verify firmware: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* End download operation */
> +	ret = ziirave_firm_write_byte(wdd, ZIIRAVE_CMD_DOWNLOAD_END, 1, false);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset the processor */
> +	ret = ziirave_firm_write_byte(wdd, ZIIRAVE_CMD_RESET_PROCESSOR, 1,
> +				      false);
> +	if (ret)
> +		return ret;
> +
> +	msleep(500);
> +
> +	return 0;
> +}
> +
>   static const struct watchdog_info ziirave_wdt_info = {
>   	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>   	.identity = "Zodiac RAVE Watchdog",
> @@ -201,10 +508,64 @@ static ssize_t ziirave_wdt_sysfs_show_reason(struct device *dev,
>   static DEVICE_ATTR(reset_reason, S_IRUGO, ziirave_wdt_sysfs_show_reason,
>   		   NULL);
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
> +	err = mutex_lock_interruptible(&w_priv->sysfs_mutex);
> +	if (err)
> +		return err;
> +

Please remember to apply the mutex for all chip accesses.

> +	err = request_ihex_firmware(&fw, ZIIRAVE_FW_NAME, dev);

Excellent choice.

> +	if (err) {
> +		dev_err(&client->dev, "Failed to request ihex firmware\n");
> +		goto unlock_sysfs;
> +	}
> +
You could actually request the firmware outside the mutex. That operation does
not have to be mutex protected.

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
> +unlock_sysfs:
> +	mutex_unlock(&w_priv->sysfs_mutex);
> +
> +	return err ? err : count;
> +}
> +
> +static DEVICE_ATTR(update_firmware, S_IWUSR, NULL,
> +		   ziirave_wdt_sysfs_store_firm);
> +
>   static struct attribute *ziirave_wdt_attrs[] = {
>   	&dev_attr_firmware_version.attr,
>   	&dev_attr_bootloader_version.attr,
>   	&dev_attr_reset_reason.attr,
> +	&dev_attr_update_firmware.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(ziirave_wdt);
> @@ -252,6 +613,8 @@ static int ziirave_wdt_probe(struct i2c_client *client,
>   	if (!w_priv)
>   		return -ENOMEM;
>
> +	mutex_init(&w_priv->sysfs_mutex);
> +
>   	w_priv->wdd.info = &ziirave_wdt_info;
>   	w_priv->wdd.ops = &ziirave_wdt_ops;
>   	w_priv->wdd.min_timeout = ZIIRAVE_TIMEOUT_MIN;
>

