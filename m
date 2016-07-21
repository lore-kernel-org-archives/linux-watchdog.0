Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34436 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbcGUJJ1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Jul 2016 05:09:27 -0400
MIME-Version: 1.0
In-Reply-To: <CAFqH_52EajJV6BQzf=VqJZEVr=XZZgjRW7KfTdEehx=C8eDGoA@mail.gmail.com>
References: <1469010678-23058-1-git-send-email-enric.balletbo@collabora.com>
 <579044B8.3080508@roeck-us.net> <CAFqH_52EajJV6BQzf=VqJZEVr=XZZgjRW7KfTdEehx=C8eDGoA@mail.gmail.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 21 Jul 2016 11:09:26 +0200
Message-ID: <CAFqH_50pnWgiAr9CTP88U-uLrQ+-Z0wfmHRbKbyS_ZA-ir_khg@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: ziirave_wdt: Add support to upload the firmware.
To: Guenter Roeck <linux@roeck-us.net>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Correction

2016-07-21 10:59 GMT+02:00 Enric Balletbo Serra <eballetbo@gmail.com>:
> Hi Guenter,
>
> Many thanks for the review, I'm agree with your comments so I'll apply
> the changes in next version that hopefully I'll send soon. Just some
> questions below.
>
> 2016-07-21 5:42 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
>> On 07/20/2016 03:31 AM, Enric Balletbo i Serra wrote:
>>>
>>> This patch adds and entry to the sysfs to start firmware upload process
>>> on the specified device with the requested firmware.
>>>
>>> The uploading of the firmware needs only to happen once per firmware
>>> upgrade, as the firmware is stored in persistent storage. If the
>>> firmware upload or the firmware verification fails then we print and
>>> error message and exit.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>> Changes since v1: (requested by Martyn)
>>>   - Remove two defines that are not used.
>>>   - Fix typo in documentation count -> length
>>>
>>>   drivers/watchdog/ziirave_wdt.c | 421
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 421 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/ziirave_wdt.c
>>> b/drivers/watchdog/ziirave_wdt.c
>>> index fa1efef..1a37577 100644
>>> --- a/drivers/watchdog/ziirave_wdt.c
>>> +++ b/drivers/watchdog/ziirave_wdt.c
>>> @@ -18,7 +18,10 @@
>>>    * GNU General Public License for more details.
>>>    */
>>>
>>> +#include <linux/ctype.h>
>>> +#include <linux/delay.h>
>>>   #include <linux/i2c.h>
>>> +#include <linux/firmware.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/module.h>
>>>   #include <linux/slab.h>
>>> @@ -36,6 +39,8 @@
>>>   #define ZIIRAVE_STATE_OFF     0x1
>>>   #define ZIIRAVE_STATE_ON      0x2
>>>
>>> +#define ZIIRAVE_FW_NAME                "ziirave_fw.hex"
>>> +
>>>   static char *ziirave_reasons[] = {"power cycle", "hw watchdog", NULL,
>>> NULL,
>>>                                   "host request", NULL, "illegal
>>> configuration",
>>>                                   "illegal instruction", "illegal trap",
>>> @@ -50,6 +55,25 @@ static char *ziirave_reasons[] = {"power cycle", "hw
>>> watchdog", NULL, NULL,
>>>   #define ZIIRAVE_WDT_PING              0x9
>>>   #define ZIIRAVE_WDT_RESET_DURATION    0xa
>>>
>>> +#define ZIIRAVE_FIRM_PKT_TOTAL_SIZE    20
>>> +#define ZIIRAVE_FIRM_PKT_DATA_SIZE     16
>>> +#define ZIIRAVE_FIRM_FLASH_MEMORY_START        0x1600
>>> +#define ZIIRAVE_FIRM_FLASH_MEMORY_END  0x2bbf
>>> +
>>> +/* Received and ready for next Download packet. */
>>> +#define ZIIRAVE_FIRM_DOWNLOAD_ACK      1
>>> +/* Currently writing to flash. Retry Download status in a moment! */
>>> +#define ZIIRAVE_FIRM_DOWNLOAD_BUSY     2
>>> +
>>> +/* Firmware commands */
>>> +#define ZIIRAVE_CMD_DOWNLOAD_START             0x10
>>> +#define ZIIRAVE_CMD_DOWNLOAD_END               0x11
>>> +#define ZIIRAVE_CMD_DOWNLOAD_SET_READ_ADDR     0x12
>>> +#define ZIIRAVE_CMD_DOWNLOAD_READ_BYTE         0x13
>>> +#define ZIIRAVE_CMD_RESET_PROCESSOR            0x0b
>>> +#define ZIIRAVE_CMD_JUMP_TO_BOOTLOADER         0x0c
>>> +#define ZIIRAVE_CMD_DOWNLOAD_PACKET            0x0e
>>> +
>>>   struct ziirave_wdt_rev {
>>>         unsigned char major;
>>>         unsigned char minor;
>>> @@ -62,6 +86,23 @@ struct ziirave_wdt_data {
>>>         int reset_reason;
>>>   };
>>>
>>> +/*
>>> + * A packet to send to the firmware is composed by following bytes:
>>> + *     Length | Addr0 | Addr1 | Data0 .. Data15 | Checksum |
>>> + * Where,
>>> + *     Length: A data byte containing the length of the data.
>>> + *     Addr0: Low byte of the address.
>>> + *     Addr1: High byte of the address.
>>> + *     Data0 .. Data15: Array of 16 bytes of data.
>>> + *     Checksum: Checksum byte to verify data integrity.
>>> + */
>>> +struct ziirave_fw_pkt_t {
>>> +       u8 length;
>>> +       u16 addr;
>>> +       u8 data[ZIIRAVE_FIRM_PKT_DATA_SIZE];
>>> +       u8 checksum;
>>> +} __packed;
>>> +
>>>   static int wdt_timeout;
>>>   module_param(wdt_timeout, int, 0);
>>>   MODULE_PARM_DESC(wdt_timeout, "Watchdog timeout in seconds");
>>> @@ -146,6 +187,339 @@ static unsigned int ziirave_wdt_get_timeleft(struct
>>> watchdog_device *wdd)
>>>         return ret;
>>>   }
>>>
>>> +static int ziirave_firm_wait_for_ack(struct watchdog_device *wdd)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(wdd->parent);
>>> +       int ret;
>>> +
>>> +       do {
>>> +               usleep_range(5000, 5100);
>>> +               ret = i2c_smbus_read_byte(client);
>>> +               if (ret < 0) {
>>> +                       dev_err(&client->dev, "Failed to read byte\n");
>>> +                       return ret;
>>> +               }
>>> +       } while (ret == ZIIRAVE_FIRM_DOWNLOAD_BUSY);
>>> +
>>> +       return ret == ZIIRAVE_FIRM_DOWNLOAD_ACK ? 0 : -EIO;
>>> +}
>>> +
>>> +/*
>>> + * Parse Microchip format Hex file (an extended Intel Hex file) to
>>> extract
>>> + * address and data.
>>> + */
>>> +static int ziirave_firm_parse_hex_line(unsigned char *fw_data,
>>> +                                      struct ziirave_fw_pkt_t *fw_pkt,
>>> +                                      bool *addr_has_changed)
>>> +{
>>> +       int count = 0;
>>> +       unsigned char *src, dst;
>>> +
>>> +       if (*fw_data++ != ':')
>>> +               return -EFAULT;
>>
>>
>> Why is this a bad address ? Something like -EINVAL might be more
>> appropriate.
>>
>>> +
>>> +       /* locate end of line */
>>> +       for (src = fw_data; *src != '\n'; src += 2) {
>>
>>
>> What if there is no newline at the end ? What if fw_data is corrupt and
>> contains nonsense ?
>>
>> To keep going until a non-hex character is found is not really robust.
>>
>>
>>> +               /*
>>> +                * Convert the ascii hexadecimal string to its binary
>>> +                * representation
>>> +                */
>>> +               if (hex2bin(&dst, src, 1))
>>> +                       return -EINVAL;
>>> +
>>> +               /* Parse line to split addr / data */
>>> +               switch (count) {
>>> +               case 0:
>>> +                       fw_pkt->length = dst;
>>> +                       break;
>>> +               case 1:
>>> +                       fw_pkt->addr = dst << 8;
>>> +                       break;
>>> +               case 2:
>>> +                       fw_pkt->addr |= dst;
>>> +                       fw_pkt->addr >>= 1;
>>> +                       break;
>>> +               case 3:
>>> +                       /* check if data is an address */
>>> +                       if (dst == 0x04)
>>> +                               *addr_has_changed = true;
>>> +                       else
>>> +                               *addr_has_changed = false;
>>> +                       break;
>>> +               case  4:
>>> +               case  5:
>>> +                       if (!*addr_has_changed)
>>> +                               fw_pkt->data[(count - 4)] = dst;
>>
>>
>> Really unnecessary ( ).
>>
>>> +                       break;
>>> +               default:
>>> +                       fw_pkt->data[(count - 4)] = dst;
>>> +                       break;
>>
>>
>> I am really not a friend of passing an intel hex file to the kernel.
>> It is quite easy to construct a file which messes up the kernel, unless
>> a lot of care is put into its parsing, as evidenced here:
>> Construct a file which results in count >= 16 and see what happens.
>>
>> You'll have to make this way more robust to make it acceptable.
>> You might want to consider converting the file into a binary file
>> _before_ passing it to the kernel.
>>
>
> Ok, got it, sounds good I'll do this in next version.
>
>> Thanks,
>> Guenter
>>
>>> +               }
>>> +               count++;
>>> +       }
>>> +
>>> +       /* return read value + ':' + '\n' */
>>> +       return (count * 2) + 2;
>>> +}
>>> +
>>> +static int ziirave_firm_set_read_addr(struct watchdog_device *wdd, u16
>>> addr)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(wdd->parent);
>>> +       u8 address[2];
>>> +
>>> +       memset(address, 0, sizeof(address));
>>
>>
>> you are filling in address in the next two instructions. This is
>> unnecessary.
>>
>>
>>> +       address[0] = addr & 0xff;
>>> +       address[1] = (addr >> 8) & 0xff;
>>> +
>>> +       return i2c_smbus_write_block_data(client,
>>> +
>>> ZIIRAVE_CMD_DOWNLOAD_SET_READ_ADDR,
>>> +                                         ARRAY_SIZE(address), address);
>>> +}
>>> +
>>> +static int ziirave_firm_write_block_data(struct watchdog_device *wdd,
>>> +                                        u8 command, u8 length, const u8
>>> *data,
>>> +                                        bool wait_for_ack)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(wdd->parent);
>>> +       int ret;
>>> +
>>> +       ret = i2c_smbus_write_block_data(client, command, length, data);
>>> +
>>> +       if (ret) {
>>> +               dev_err(&client->dev,
>>> +                       "Failed to send command 0x%02x: %d\n", command,
>>> ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       if (wait_for_ack) {
>>> +               ret = ziirave_firm_wait_for_ack(wdd);
>>> +               if (ret)
>>> +                       dev_err(&client->dev,
>>> +                               "Failed waiting ACK from command 0x%02x:
>>> %d\n",
>>> +                               command, ret);
>>
>>
>> This is really quite noisy. Since the error is reported to user space,
>> I would suggest to either drop the messages or make them debug messages.
>>
>
> If it's ok I would prefer transform to a debug message.
>
>>> +       }
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static int ziirave_firm_write_byte(struct watchdog_device *wdd, u8
>>> command,
>>> +                                  u8 byte, bool wait_for_ack)
>>> +{
>>> +       return ziirave_firm_write_block_data(wdd, command, 1, &byte,
>>> +                                            wait_for_ack);
>>> +}
>>> +
>>> +static int ziirave_firm_write_pkt(struct watchdog_device *wdd,
>>> +                                 struct ziirave_fw_pkt_t *fw_pkt)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(wdd->parent);
>>> +       u8 i, checksum = 0, packet[ZIIRAVE_FIRM_PKT_TOTAL_SIZE];
>>> +       int ret;
>>> +
>>> +       memset(&packet, 0, sizeof(packet));
>>
>>
>> & is unnecessary here, and is this really necessary ?
>>
>>> +
>>> +       packet[0] = fw_pkt->length;
>>> +       packet[1] = (u8)(fw_pkt->addr & 0xff);
>>> +       packet[2] = (u8)((fw_pkt->addr & 0xff00) >> 8);
>>> +
>>> +       /* Copy packet data */
>>> +       memcpy(packet + 3, fw_pkt->data, fw_pkt->length);
>>
>>
>> length is unchecked when written and may be up to 255.
>>
>>> +
>>> +       /* Compute checksum */
>>> +       for (i = 0; i < (ZIIRAVE_FIRM_PKT_TOTAL_SIZE - 1); i++)
>>
>>
>> Unnecessary ( ).
>>
>>
>>> +               checksum += packet[i];
>>> +       packet[ZIIRAVE_FIRM_PKT_TOTAL_SIZE - 1] = checksum;
>>> +
>>> +       ret = ziirave_firm_write_block_data(wdd,
>>> ZIIRAVE_CMD_DOWNLOAD_PACKET,
>>> +                                           ARRAY_SIZE(packet), packet,
>>> true);
>>> +       if (ret)
>>> +               dev_err(&client->dev,
>>> +                     "Failed to write firmware packet at address 0x%04x:
>>> %d\n",
>>> +                     fw_pkt->addr, ret);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static int ziirave_firm_verify(struct watchdog_device *wdd,
>>> +                              const struct firmware *fw)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(wdd->parent);
>>> +       int i, ret, read_bytes = 0, total_read_bytes = 0;
>>> +       bool addr_has_changed;
>>> +       struct ziirave_fw_pkt_t fw_pkt;
>>> +       u8 data[ZIIRAVE_FIRM_PKT_DATA_SIZE];
>>> +
>>> +       while (total_read_bytes < fw->size) {
>>> +               read_bytes = ziirave_firm_parse_hex_line(
>>> +                                       (u8 *)(fw->data +
>>> total_read_bytes),
>>> +                                       &fw_pkt, &addr_has_changed);
>>> +
>>
>> Error returns are ignored, in effect reducing total_read_bytes.
>>
>>> +               /* Detect the end of file */
>>> +               total_read_bytes += read_bytes;
>>> +               if (total_read_bytes == fw->size)
>>> +                       break;
>>> +
>>
>> ziirave_firm_parse_hex_line() doesn't know anything about the size of the
>> file.
>> Thus, total_read_bytes can become larger than fw->size. Also, doesn't this
>> ignore
>> the last line ?
>>
>>> +               if (addr_has_changed)
>>> +                       continue;
>>> +
>>> +               if (fw_pkt.addr < ZIIRAVE_FIRM_FLASH_MEMORY_START ||
>>> +                   fw_pkt.addr > ZIIRAVE_FIRM_FLASH_MEMORY_END)
>>> +                       continue;
>>> +
>>
>> What if addr >= ZIIRAVE_FIRM_FLASH_MEMORY_END - ARRAY_SIZE(data) ?
>> Wouldn't this read beyond the end of the firmware ?
>>
>>
>>> +               ret = ziirave_firm_set_read_addr(wdd, fw_pkt.addr);
>>> +               if (ret) {
>>> +                       dev_err(&client->dev,
>>> +                               "Failed to send SET_READ_ADDR command:
>>> %d\n",
>>> +                               ret);
>>> +                       return ret;
>>> +               }
>>> +
>>> +               for (i = 0; i < ARRAY_SIZE(data); i++) {
>>> +                       ret = i2c_smbus_read_byte_data(client,
>>> +
>>> ZIIRAVE_CMD_DOWNLOAD_READ_BYTE);
>>> +                       if (ret < 0) {
>>> +                               dev_err(&client->dev,
>>> +                                       "Failed to READ DATA: %d\n", ret);
>>> +                               return ret;
>>> +                       }
>>> +                       data[i] = (u8)ret;
>>> +               }
>>> +
>>> +               if (memcmp(data, fw_pkt.data, fw_pkt.length)) {
>>> +                       dev_err(&client->dev,
>>> +                               "Firmware mismatch at address 0x%04x\n",
>>> +                               fw_pkt.addr);
>>> +                       return -EINVAL;
>>> +               }
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int ziirave_firm_upload(struct watchdog_device *wdd,
>>> +                              const struct firmware *fw)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(wdd->parent);
>>> +       struct ziirave_fw_pkt_t fw_pkt;
>>> +       struct ziirave_fw_pkt_t fw_pkt_new;
>>> +       int ret, total_read_bytes = 0, words_till_page_break;
>>> +       bool addr_has_changed;
>>> +
>>> +       ret = ziirave_firm_write_byte(wdd, ZIIRAVE_CMD_JUMP_TO_BOOTLOADER,
>>> 1,
>>> +                                     false);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       msleep(500);
>>> +
>>> +       ret = ziirave_firm_write_byte(wdd, ZIIRAVE_CMD_DOWNLOAD_START, 1,
>>> true);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       msleep(500);
>>> +
>>> +       while (total_read_bytes < fw->size) {
>>> +               int read_bytes = 0;
>>> +
>>> +               read_bytes = ziirave_firm_parse_hex_line(
>>> +                                       (u8 *)(fw->data +
>>> total_read_bytes),
>>> +                                       &fw_pkt, &addr_has_changed);
>>> +
>>> +               if (read_bytes <= 0) {
>>> +                       dev_err(&client->dev,
>>> +                               "Failed to parse HEX file\n");
>>> +                       return -EINVAL;
>>> +               }
>>> +
>>> +               /* Detect the end of file */
>>> +               total_read_bytes += read_bytes;
>>> +               if (total_read_bytes == fw->size) {
>>
>>
>> What if it is larger due to a bad firmware file ?
>>
>>> +                       /*
>>> +                        * For end of download, the length field will be
>>> set
>>> +                        * to 0
>>> +                        */
>>
>>
>> And if the file is not semantically correct and doesn't have a length field
>> of 0 at the end ?
>>
>>
>>> +                       memset(&fw_pkt, 0, sizeof(fw_pkt));
>>> +                       ret = ziirave_firm_write_pkt(wdd, &fw_pkt);
>>> +                       if (ret) {
>>> +                               dev_err(&client->dev,
>>> +                                       "Failed to send EMPTY packet:
>>> %d\n",
>>> +                                       ret);
>>> +                               return ret;
>>> +                       }
>>> +
>>> +                       /* This sleep seems to be required */
>>> +                       msleep(20);
>>> +
>>> +                       /* Start firmware verification */
>>> +                       ret = ziirave_firm_verify(wdd, fw);
>>> +                       if (ret) {
>>> +                               dev_err(&client->dev,
>>> +                                       "Failed to verify firmware: %d\n",
>>> ret);
>>> +                               return ret;
>>> +                       }
>>> +
>>> +                       /* End download operation */
>>> +                       ret = ziirave_firm_write_byte(wdd,
>>> +
>>> ZIIRAVE_CMD_DOWNLOAD_END,
>>> +                                                     1, false);
>>> +                       if (ret)
>>> +                               return ret;
>>> +                       break;
>>> +               }
>>> +
>>> +               if (addr_has_changed)
>>> +                       continue;
>>> +
>>> +               /* Calculate words till page break */
>>> +               words_till_page_break = (64 - (fw_pkt.addr & 0x3f));
>>> +               if ((fw_pkt.length >> 1) > words_till_page_break) {
>>> +                       /*
>>> +                        * Data in passes page boundary, so we need to
>>> split in
>>> +                        * two blocks of data. Create a packet with the
>>> first
>>> +                        * block of data.
>>> +                        */
>>> +                       memset(&fw_pkt_new, 0, sizeof(fw_pkt_new));
>>> +
>>> +                       fw_pkt_new.length = words_till_page_break << 1;
>>> +                       fw_pkt_new.addr = fw_pkt.addr;
>>> +                       memcpy(fw_pkt_new.data, fw_pkt.data,
>>> fw_pkt_new.length);
>>> +
>>> +                       ret = ziirave_firm_write_pkt(wdd, &fw_pkt_new);
>>> +                       if (ret)
>>> +                               return ret;
>>> +
>>> +                       /* Create a packet with the second block of data
>>> */
>>> +                       memset(&fw_pkt_new, 0, sizeof(fw_pkt_new));
>>> +
>>> +                       /* Remaining bytes */
>>> +                       fw_pkt_new.length =
>>> +                               fw_pkt.length - (words_till_page_break <<
>>> 1);
>>> +                       fw_pkt_new.addr = fw_pkt.addr +
>>> words_till_page_break;
>>> +                       memcpy(fw_pkt_new.data,
>>> +                              fw_pkt.data + (words_till_page_break << 1),
>>> +                              fw_pkt_new.length);
>>> +
>>> +                       ret = ziirave_firm_write_pkt(wdd, &fw_pkt_new);
>>> +                       if (ret)
>>> +                               return ret;
>>> +               } else {
>>> +                       ret = ziirave_firm_write_pkt(wdd, &fw_pkt);
>>> +                       if (ret)
>>> +                               return ret;
>>> +               }
>>> +       }
>>> +
>>> +       /* Reset the processor */
>>> +       ret = ziirave_firm_write_byte(wdd, ZIIRAVE_CMD_RESET_PROCESSOR, 1,
>>> +                                     false);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       msleep(500);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   static const struct watchdog_info ziirave_wdt_info = {
>>>         .options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
>>> WDIOF_KEEPALIVEPING,
>>>         .identity = "Zodiac RAVE Watchdog",
>>> @@ -201,10 +575,57 @@ static ssize_t ziirave_wdt_sysfs_show_reason(struct
>>> device *dev,
>>>   static DEVICE_ATTR(reset_reason, S_IRUGO, ziirave_wdt_sysfs_show_reason,
>>>                    NULL);
>>>
>>> +static ssize_t ziirave_wdt_sysfs_store_firm(struct device *dev,
>>> +                                           struct device_attribute *attr,
>>> +                                           const char *buf, size_t count)
>>> +{
>>> +       struct i2c_client *client = to_i2c_client(dev->parent);
>>> +       struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
>>> +       const struct firmware *fw;
>>> +       int err;
>>> +
>>
>>
>> What happens if this file is opened twice and written in parallel ?
>> What if any
>> other attribute is accessed while the firmware download is ongoing ?
>>
>
> Good point. So you think I need to protect all with mutexes or there
> is another way? From a quick look on other drivers i didn't see this
> kind of protection (something to look at in the future)
>

Just found other drivers using a mutex, so forget my last sentence.

>>
>>> +       err = request_firmware(&fw, ZIIRAVE_FW_NAME, dev);
>>> +       if (err) {
>>> +               dev_err(&client->dev, "Unable to open firmware %s: %d\n",
>>> +                       ZIIRAVE_FW_NAME, err);
>>> +               return err;
>>> +       }
>>> +
>>> +       err = ziirave_firm_upload(&w_priv->wdd, fw);
>>> +       if (err) {
>>> +               dev_err(&client->dev, "The firmware update failed: %d\n",
>>> err);
>>> +               goto release_firmware;
>>> +       }
>>> +
>>> +       /* Update firmware version */
>>> +       err = ziirave_wdt_revision(client, &w_priv->firmware_rev,
>>> +                                  ZIIRAVE_WDT_FIRM_VER_MAJOR);
>>> +       if (err) {
>>> +               dev_err(&client->dev, "Failed to read firmware version:
>>> %d\n",
>>> +                       err);
>>> +               goto release_firmware;
>>> +       }
>>> +
>>> +       dev_info(&client->dev, "Firmware updated to version
>>> 02.%02u.%02u\n",
>>> +                w_priv->firmware_rev.major, w_priv->firmware_rev.minor);
>>> +
>>> +       /* Restore the watchdog timeout */
>>> +       err = ziirave_wdt_set_timeout(&w_priv->wdd, w_priv->wdd.timeout);
>>> +       if (err)
>>> +               dev_err(&client->dev, "Failed to set timeout: %d\n", err);
>>> +
>>> +release_firmware:
>>> +       release_firmware(fw);
>>> +       return err ? err : count;
>>> +}
>>> +
>>> +static DEVICE_ATTR(update_fw, S_IWUSR, NULL,
>>> ziirave_wdt_sysfs_store_firm);
>>> +
>>>   static struct attribute *ziirave_wdt_attrs[] = {
>>>         &dev_attr_firmware_version.attr,
>>>         &dev_attr_bootloader_version.attr,
>>>         &dev_attr_reset_reason.attr,
>>> +       &dev_attr_update_fw.attr,
>>
>>
>> We have firmware_version, so update_firmware seems appropriate.
>>
>>>         NULL
>>>   };
>>>   ATTRIBUTE_GROUPS(ziirave_wdt);
>>>
>>
>
> Regards,
> Enric
