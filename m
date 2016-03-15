Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from forward.webhostbox.net ([5.100.155.152]:59667 "EHLO
	forward.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbcCOCZN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Mar 2016 22:25:13 -0400
Subject: Re: [PATCH] watchdog: add driver for StreamLabs USB watchdog device
To: Alexey Klimov <klimov.linux@gmail.com>
References: <1457576946-9313-1-git-send-email-klimov.linux@gmail.com>
 <56E0EFD8.20206@roeck-us.net>
 <CALW4P+Km7csSRgS5gBQz+B1mrpGy=aUF-yGZbd2EPNPcVabNow@mail.gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>, wim@iguana.be,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Yury Norov <yury.norov@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56E7727B.3070303@roeck-us.net>
Date: Mon, 14 Mar 2016 19:24:59 -0700
MIME-Version: 1.0
In-Reply-To: <CALW4P+Km7csSRgS5gBQz+B1mrpGy=aUF-yGZbd2EPNPcVabNow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexey,

On 03/14/2016 06:02 PM, Alexey Klimov wrote:
> Hi Guenter,
>
> On Thu, Mar 10, 2016 at 3:54 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 03/09/2016 06:29 PM, Alexey Klimov wrote:
>>>
>>> This patch creates new driver that supports StreamLabs usb watchdog
>>> device. This device plugs into 9-pin usb header and connects to
>>> reset pin and reset button on common PC.
>>>
>>> USB commands used to communicate with device were reverse
>>> engineered using usbmon.
>>>
>>> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
>>> ---
>>>    drivers/watchdog/Kconfig          |  15 ++
>>>    drivers/watchdog/Makefile         |   1 +
>>>    drivers/watchdog/streamlabs_wdt.c | 370
>>> ++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 386 insertions(+)
>>>    create mode 100644 drivers/watchdog/streamlabs_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 80825a7..95d8f72 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -1705,4 +1705,19 @@ config USBPCWATCHDOG
>>>
>>>            Most people will say N.
>>>
>>> +config USB_STREAMLABS_WATCHDOG
>>> +       tristate "StreamLabs USB watchdog driver"
>>> +       depends on USB
>>> +       ---help---
>>> +         This is the driver for the USB Watchdog dongle from StreamLabs.
>>> +         If you correctly connect reset pins to motherboard Reset pin and
>>> +         to Reset button then this device will simply watch your kernel
>>> to make
>>> +         sure it doesn't freeze, and if it does, it reboots your computer
>>> +         after a certain amount of time.
>>> +
>>> +
>>> +         To compile this driver as a module, choose M here: the
>>> +         module will be called streamlabs_wdt.
>>> +
>>> +         Most people will say N. Say yes or M if you want to use such usb
>>> device.
>>>    endif # WATCHDOG
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index f6a6a38..d54fd31 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -25,6 +25,7 @@ obj-$(CONFIG_WDTPCI) += wdt_pci.o
>>>
>>>    # USB-based Watchdog Cards
>>>    obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
>>> +obj-$(CONFIG_USB_STREAMLABS_WATCHDOG) += streamlabs_wdt.o
>>>
>>>    # ALPHA Architecture
>>>
>>> diff --git a/drivers/watchdog/streamlabs_wdt.c
>>> b/drivers/watchdog/streamlabs_wdt.c
>>> new file mode 100644
>>> index 0000000..031dbc35
>>> --- /dev/null
>>> +++ b/drivers/watchdog/streamlabs_wdt.c
>>> @@ -0,0 +1,370 @@
>>> +/*
>>> + * StreamLabs USB Watchdog driver
>>> + *
>>> + * Copyright (c) 2016 Alexey Klimov <klimov.linux@gmail.com>
>>> + *
>>> + * This program is free software; you may redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/errno.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/usb.h>
>>> +#include <linux/watchdog.h>
>>> +
>>> +/*
>>> + * USB Watchdog device from Streamlabs
>>> + * http://www.stream-labs.com/products/devices/watchdog/
>>> + *
>>> + * USB commands have been reverse engineered using usbmon.
>>> + */
>>> +
>>> +#define DRIVER_AUTHOR "Alexey Klimov <klimov.linux@gmail.com>"
>>> +#define DRIVER_DESC "StreamLabs USB watchdog driver"
>>> +#define DRIVER_NAME "usb_streamlabs_wdt"
>>> +
>>> +MODULE_AUTHOR(DRIVER_AUTHOR);
>>> +MODULE_DESCRIPTION(DRIVER_DESC);
>>> +MODULE_LICENSE("GPL");
>>> +
>>> +#define USB_STREAMLABS_WATCHDOG_VENDOR 0x13c0
>>> +#define USB_STREAMLABS_WATCHDOG_PRODUCT        0x0011
>>> +
>>> +/* one buffer is used for communication, however transmitted message is
>>> only
>>> + * 32 bytes long */
>>
>>
>> /*
>>   * Please use proper multi-line comments throughout.
>>
>>   */
>
> Ok, will fix them all.
>
>
>>> +#define BUFFER_TRANSFER_LENGTH 32
>>> +#define BUFFER_LENGTH          64
>>> +#define USB_TIMEOUT            350
>>> +
>>> +#define STREAMLABS_CMD_START   0
>>> +#define STREAMLABS_CMD_STOP    1
>>> +
>>> +#define STREAMLABS_WDT_MIN_TIMEOUT     1
>>> +#define STREAMLABS_WDT_MAX_TIMEOUT     46
>>> +
>>> +struct streamlabs_wdt {
>>> +       struct watchdog_device wdt_dev;
>>> +       struct usb_device *usbdev;
>>> +       struct usb_interface *intf;
>>> +
>>> +       struct kref kref;
>>> +       struct mutex lock;
>>> +       u8 *buffer;
>>> +};
>>> +
>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>>> +
>>> +static int usb_streamlabs_wdt_validate_response(u8 *buf)
>>> +{
>>> +       /* If watchdog device understood the command it will acknowledge
>>> +        * with values 1,2,3,4 at indexes 10, 11, 12, 13 in response
>>> message.
>>> +        */
>>> +       if (buf[10] != 1 || buf[11] != 2 || buf[12] != 3 || buf[13] != 4)
>>> +               return -EINVAL;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int usb_streamlabs_wdt_command(struct watchdog_device *wdt_dev,
>>> int cmd)
>>> +{
>>> +       struct streamlabs_wdt *streamlabs_wdt =
>>> watchdog_get_drvdata(wdt_dev);
>>> +       int retval;
>>> +       int size;
>>> +       unsigned long timeout_msec;
>>> +       int retry_counter = 10;         /* how many times to re-send stop
>>> cmd */
>>> +
>>> +       mutex_lock(&streamlabs_wdt->lock);
>>> +
>>> +       timeout_msec = wdt_dev->timeout * MSEC_PER_SEC;
>>> +
>>> +       /* Prepare message that will be sent to device.
>>> +        * This buffer is allocated by kzalloc(). Only initialize required
>>> +        * fields.
>>
>>
>> But only once, and overwritten by the response. So the comment is quite
>> pointless
>> and misleading.
>
> Ok, I will do something with this comment during re-work and rebase.
>
>>> +        */
>>> +       if (cmd == STREAMLABS_CMD_START) {
>>> +               streamlabs_wdt->buffer[0] = 0xcc;
>>> +               streamlabs_wdt->buffer[1] = 0xaa;
>>> +       } else {        /* assume stop command if it's not start */
>>> +               streamlabs_wdt->buffer[0] = 0xff;
>>> +               streamlabs_wdt->buffer[1] = 0xbb;
>>> +       }
>>> +
>>> +       streamlabs_wdt->buffer[3] = 0x80;
>>> +
>>> +       streamlabs_wdt->buffer[6] = (timeout_msec & 0xff) << 8;
>>> +       streamlabs_wdt->buffer[7] = (timeout_msec & 0xff00) >> 8;
>>> +retry:
>>> +       streamlabs_wdt->buffer[10] = 0x00;
>>> +       streamlabs_wdt->buffer[11] = 0x00;
>>> +       streamlabs_wdt->buffer[12] = 0x00;
>>> +       streamlabs_wdt->buffer[13] = 0x00;
>>> +
>>> +       /* send command to watchdog */
>>> +       retval = usb_interrupt_msg(streamlabs_wdt->usbdev,
>>> +                               usb_sndintpipe(streamlabs_wdt->usbdev,
>>> 0x02),
>>> +                               streamlabs_wdt->buffer,
>>> BUFFER_TRANSFER_LENGTH,
>>> +                               &size, USB_TIMEOUT);
>>> +
>>> +       if (retval || size != BUFFER_TRANSFER_LENGTH) {
>>> +               dev_err(&streamlabs_wdt->intf->dev,
>>> +                       "error %i when submitting interrupt msg\n",
>>> retval);
>>
>>
>> Please no error messages if something goes wrong. We don't want to
>> fill the kernel log with those messages.
>
> Ok, will remove them. Or is it fine to convert them to dev_dbg?
>

If you think the messages might be useful for debugging, sure.


>>> +               retval = -EIO;
>>> +               goto out;
>>> +       }
>>> +
>>> +       /* and read response from watchdog */
>>> +       retval = usb_interrupt_msg(streamlabs_wdt->usbdev,
>>> +                               usb_rcvintpipe(streamlabs_wdt->usbdev,
>>> 0x81),
>>> +                               streamlabs_wdt->buffer, BUFFER_LENGTH,
>>> +                               &size, USB_TIMEOUT);
>>> +
>>> +       if (retval || size != BUFFER_LENGTH) {
>>> +               dev_err(&streamlabs_wdt->intf->dev,
>>> +                       "error %i when receiving interrupt msg\n",
>>> retval);
>>> +               retval = -EIO;
>>> +               goto out;
>>> +       }
>>> +
>>> +       /* check if watchdog actually acked/recognized command */
>>> +       retval =
>>> usb_streamlabs_wdt_validate_response(streamlabs_wdt->buffer);
>>> +       if (retval) {
>>> +               dev_err(&streamlabs_wdt->intf->dev,
>>> +                                       "watchdog didn't ACK command!\n");
>>> +               goto out;
>>> +       }
>>> +
>>> +       /* Transition from enabled to disabled state in this device
>>> +        * doesn't happen immediately. Usually, 2 or 3 (sometimes even 4)
>>> stop
>>> +        * commands should be sent until watchdog answers 'I'm stopped!'.
>>> +        * Retry stop command if watchdog fails to answer correctly
>>> +        * about its state. After 10 attempts, report error and return
>>> -EIO.
>>> +        */
>>> +       if (cmd == STREAMLABS_CMD_STOP) {
>>> +               if (--retry_counter <= 0) {
>>> +                       dev_err(&streamlabs_wdt->intf->dev,
>>> +                               "failed to stop watchdog after 9
>>> attempts!\n");
>>> +                       retval = -EIO;
>>> +                       goto out;
>>> +               }
>>> +               /*
>>> +                * Check if watchdog actually changed state to disabled.
>>> +                * If watchdog is still enabled then reset message and
>>> retry
>>> +                * stop command.
>>> +                */
>>> +               if (streamlabs_wdt->buffer[0] != 0xff ||
>>> +                                       streamlabs_wdt->buffer[1] != 0xbb)
>>> {
>>> +                       streamlabs_wdt->buffer[0] = 0xff;
>>> +                       streamlabs_wdt->buffer[1] = 0xbb;
>>> +                       goto retry;
>>
>>
>> Can you use a loop instead ? goto's are ok when needed,
>> but here it just makes the code more difficult to read.
>
> Sure.
>
>>> +               }
>>> +       }
>>> +
>>> +out:
>>> +       mutex_unlock(&streamlabs_wdt->lock);
>>> +       return retval;
>>> +}
>>> +
>>> +static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
>>> +{
>>> +       return usb_streamlabs_wdt_command(wdt_dev, STREAMLABS_CMD_START);
>>> +}
>>> +
>>> +static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
>>> +{
>>> +       return usb_streamlabs_wdt_command(wdt_dev, STREAMLABS_CMD_STOP);
>>> +}
>>> +
>>> +static int usb_streamlabs_wdt_settimeout(struct watchdog_device *wdt_dev,
>>> +                               unsigned int timeout)
>>> +{
>>> +       struct streamlabs_wdt *streamlabs_wdt =
>>> watchdog_get_drvdata(wdt_dev);
>>> +
>>> +       mutex_lock(&streamlabs_wdt->lock);
>>> +       wdt_dev->timeout = timeout;
>>> +       mutex_unlock(&streamlabs_wdt->lock);
>>
>>
>> I don't think this mutex protection is needed.
>>
>> Note that there is a patch pending (and will make it into 4.6)
>> which will make the set_timeout function optional if all it does
>> is to set the timeout variable.
>
> Here comes some pain. For last week I tried to clone
> git://www.linux-watchdog.org/linux-watchdog-next.git (I hope this is
> correct address) to rebase on top of 4.6 and test but almost always I
> got this after counting:
>
> fatal: read error: Connection timed out
> fatal: early EOF
> fatal: index-pack failed
>
> and counting takes 3-4 hours.
>
> After all I cloned it (and www.linux-watchdog.org looks more healthy
> in last couple of days) but merge window should be opened soon so I
> will get new things in two weeks anyway. I think I will be able to
> rebase on 4.6-rc1 or near and re-send.
>
> Looks like I'm not the first one who have troubles with
> git://www.linux-watchdog.org
> http://www.spinics.net/lists/linux-watchdog/msg07384.html
>

Yes, sometimes Wim's service provider seems to be less than reliable.

If that happens, you can clone
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
and check out the watchdog-next branch. It is not in sync with Wim's tree, though,
and typically has a few commits on top of it (or, once in a while, may be missing
some commits).

>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void usb_streamlabs_wdt_release_resources(struct kref *kref)
>>> +{
>>> +       struct streamlabs_wdt *streamlabs_wdt =
>>> +                       container_of(kref, struct streamlabs_wdt, kref);
>>> +
>>> +       mutex_destroy(&streamlabs_wdt->lock);
>>> +       kfree(streamlabs_wdt->buffer);
>>> +       kfree(streamlabs_wdt);
>>> +}
>>> +
>>> +static void usb_streamlabs_wdt_ref(struct watchdog_device *wdt_dev)
>>> +{
>>> +       struct streamlabs_wdt *streamlabs_wdt =
>>> watchdog_get_drvdata(wdt_dev);
>>> +
>>> +       kref_get(&streamlabs_wdt->kref);
>>> +}
>>> +
>>> +static void usb_streamlabs_wdt_unref(struct watchdog_device *wdt_dev)
>>> +{
>>> +       struct streamlabs_wdt *streamlabs_wdt =
>>> watchdog_get_drvdata(wdt_dev);
>>> +
>>> +       kref_put(&streamlabs_wdt->kref,
>>> usb_streamlabs_wdt_release_resources);
>>> +}
>>> +
>>> +static const struct watchdog_info streamlabs_wdt_ident = {
>>> +       .options        = (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING),
>>
>>
>> Unnecessary ( )
>
> Ok.
>
>>> +       .identity       = DRIVER_NAME,
>>> +};
>>> +
>>> +static struct watchdog_ops usb_streamlabs_wdt_ops = {
>>> +       .owner  = THIS_MODULE,
>>> +       .start  = usb_streamlabs_wdt_start,
>>> +       .stop   = usb_streamlabs_wdt_stop,
>>> +       .set_timeout    = usb_streamlabs_wdt_settimeout,
>>> +       .ref    = usb_streamlabs_wdt_ref,
>>> +       .unref  = usb_streamlabs_wdt_unref,
>>
>>
>> Those functions no longer exist (and are no longer needed) in the latest
>> kernel.
>
> Got it.
>
>>> +};
>>> +
>>> +static int usb_streamlabs_wdt_probe(struct usb_interface *intf,
>>> +                       const struct usb_device_id *id)
>>> +{
>>> +       struct usb_device *dev = interface_to_usbdev(intf);
>>> +       struct streamlabs_wdt *streamlabs_wdt;
>>> +       int retval;
>>> +
>>> +       /* USB IDs of this device appear to be weird/unregistered. Hence,
>>> do
>>> +        * an additional check on product and manufacturer.
>>> +        * If there is similar device in the field with same values then
>>> +        * there is stop command in probe() below that checks if the
>>> device
>>> +        * behaves as a watchdog. */
>>> +       if (dev->product && dev->manufacturer &&
>>> +               (strncmp(dev->product, "USBkit", 6) != 0
>>> +               || strncmp(dev->manufacturer, "STREAM LABS", 11) != 0))
>>> +               return -ENODEV;
>>> +
>>> +       streamlabs_wdt = kmalloc(sizeof(struct streamlabs_wdt),
>>> GFP_KERNEL);
>>> +       if (!streamlabs_wdt) {
>>> +               dev_err(&intf->dev, "kmalloc failed\n");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       streamlabs_wdt->buffer = kzalloc(BUFFER_LENGTH, GFP_KERNEL);
>>> +       if (!streamlabs_wdt->buffer) {
>>> +               dev_err(&intf->dev, "kzalloc for watchdog->buffer
>>> failed\n");
>>> +               retval = -ENOMEM;
>>> +               goto err_nobuf;
>>> +       }
>>> +
>>
>>
>> Please consider using devm_kzalloc().
>>
>> Also, is it necessary to allocate the buffer separately instead of using a
>> (possibly cache line aligned) array in struct streamlabs_wdt ?
>
> Thanks. Already moved to devm_kzalloc() and moved array inside
> structure instead of allocating buffer separately.
>
>>> +       mutex_init(&streamlabs_wdt->lock);
>>> +
>>> +       streamlabs_wdt->wdt_dev.info = &streamlabs_wdt_ident;
>>> +       streamlabs_wdt->wdt_dev.ops = &usb_streamlabs_wdt_ops;
>>> +       streamlabs_wdt->wdt_dev.timeout = STREAMLABS_WDT_MAX_TIMEOUT;
>>> +       streamlabs_wdt->wdt_dev.max_timeout = STREAMLABS_WDT_MAX_TIMEOUT;
>>> +       streamlabs_wdt->wdt_dev.min_timeout = STREAMLABS_WDT_MIN_TIMEOUT;
>>> +       streamlabs_wdt->wdt_dev.parent = &intf->dev;
>>> +
>>> +       streamlabs_wdt->usbdev = interface_to_usbdev(intf);
>>> +       streamlabs_wdt->intf = intf;
>>> +       usb_set_intfdata(intf, &streamlabs_wdt->wdt_dev);
>>> +       watchdog_set_drvdata(&streamlabs_wdt->wdt_dev, streamlabs_wdt);
>>> +
>>> +       watchdog_init_timeout(&streamlabs_wdt->wdt_dev,
>>> +                               streamlabs_wdt->wdt_dev.timeout,
>>> &intf->dev);
>>
>>
>> This is quite pointless, since timeout is already set, and you don't have
>> a module parameter to overwrite it.
>
> Gonna remove it.
>
>>> +       watchdog_set_nowayout(&streamlabs_wdt->wdt_dev, nowayout);
>>> +
>>> +       kref_init(&streamlabs_wdt->kref);
>>> +
>>> +       retval = usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
>>> +       if (retval)
>>> +               goto err_wdt_buf;
>>> +
>>> +       retval = watchdog_register_device(&streamlabs_wdt->wdt_dev);
>>> +       if (retval) {
>>> +               dev_err(&intf->dev, "failed to register watchdog
>>> device\n");
>>> +               goto err_wdt_buf;
>>> +       }
>>> +
>>> +       dev_info(&intf->dev, "StreamLabs USB watchdog loaded.\n");
>>> +
>>> +       return 0;
>>> +
>>> +err_wdt_buf:
>>> +       mutex_destroy(&streamlabs_wdt->lock);
>>> +       kfree(streamlabs_wdt->buffer);
>>> +
>>> +err_nobuf:
>>> +       kfree(streamlabs_wdt);
>>> +       return retval;
>>> +}
>>> +
>>> +
>>> +
>>> +static int usb_streamlabs_wdt_suspend(struct usb_interface *intf,
>>> +                                       pm_message_t message)
>>> +{
>>> +       struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
>>> +
>>> +       if (watchdog_active(&streamlabs_wdt->wdt_dev))
>>> +               usb_streamlabs_wdt_command(&streamlabs_wdt->wdt_dev,
>>> +
>>> STREAMLABS_CMD_STOP);
>>
>>
>> Please call usb_streamlabs_wdt_stop().
>>
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int usb_streamlabs_wdt_resume(struct usb_interface *intf)
>>> +{
>>> +       struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
>>> +
>>> +       if (watchdog_active(&streamlabs_wdt->wdt_dev))
>>> +               return
>>> usb_streamlabs_wdt_command(&streamlabs_wdt->wdt_dev,
>>> +
>>> STREAMLABS_CMD_START);
>>
>>
>> Please call usb_streamlabs_wdt_start().
>
> Thanks, I will add required calls. Out of curiosity, what about
> driver(s) that checks watchdog status in suspend/resume and calls
> stop/start only if watchdog active?
>

Not sure I understand. Isn't that what you are doing ?

>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void usb_streamlabs_wdt_disconnect(struct usb_interface *intf)
>>> +{
>>> +       struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
>>> +
>>> +       /* First, stop sending USB messages to device. */
>>> +       mutex_lock(&streamlabs_wdt->lock);
>>> +       usb_set_intfdata(intf, NULL);
>>> +       streamlabs_wdt->usbdev = NULL;
>>> +       mutex_unlock(&streamlabs_wdt->lock);
>>> +
>>
>> If user space has a keepalive pending (waiting for the mutex being
>> released in usb_streamlabs_wdt_command()), this may result in a call to
>> usb_interrupt_msg() with the device set to NULL. The mutex protection
>> doesn't add any value since you don't check if ->usbdev is NULL in
>> usb_streamlabs_wdt_command().
>
> In another email Oliver adviced to remove ->usbdev. So, I use ->intf
> and check it for NULL in usb_streamlabs_wdt_command(). I also do
> usb_set_intfdata(intf, NULL);
> streamlabs_wdt->intf = NULL;
> here with mutex locked. Hope it's fine.
>

I'll have to see the code to determine if it is clean.

> Thanks for review.
>
My pleasure.

Thanks,
Guenter

