Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59684 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcDRN5f (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Apr 2016 09:57:35 -0400
Subject: Re: [PATCH v2] watchdog: add driver for StreamLabs USB watchdog
 device
To: Oliver Neukum <oneukum@suse.com>,
	Alexey Klimov <klimov.linux@gmail.com>
References: <1460948016-5453-1-git-send-email-klimov.linux@gmail.com>
 <1460968368.25119.7.camel@suse.com>
Cc: linux-watchdog@vger.kernel.org, yury.norov@gmail.com,
	wim@iguana.be, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5714E7D3.4030809@roeck-us.net>
Date: Mon, 18 Apr 2016 06:57:39 -0700
MIME-Version: 1.0
In-Reply-To: <1460968368.25119.7.camel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/18/2016 01:32 AM, Oliver Neukum wrote:
> On Mon, 2016-04-18 at 03:53 +0100, Alexey Klimov wrote:
>> This patch creates new driver that supports StreamLabs usb watchdog
>> device. This device plugs into 9-pin usb header and connects to
>> reset pin and reset button on common PC.
>>
>> USB commands used to communicate with device were reverse
>> engineered using usbmon.
>
> Almost. I see only one issue.
>
>> +struct streamlabs_wdt {
>> +	struct watchdog_device wdt_dev;
>> +	struct usb_interface *intf;
>> +
>> +	struct mutex lock;
>> +	u8 buffer[BUFFER_LENGTH];
>
> That is wrong.
>
>> +};
>> +
>
> [..]
>
>> +static int usb_streamlabs_wdt_command(struct watchdog_device *wdt_dev, u16 cmd)
>> +{
>> +	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
>> +	struct usb_device *usbdev;
>> +	int retval;
>> +	int size;
>> +	unsigned long timeout_msec;
>> +
>> +	int retry_counter = 10;		/* how many times to re-send stop cmd */
>> +
>> +	mutex_lock(&streamlabs_wdt->lock);
>> +
>> +	if (unlikely(!streamlabs_wdt->intf)) {
>> +		mutex_unlock(&streamlabs_wdt->lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	usbdev = interface_to_usbdev(streamlabs_wdt->intf);
>> +	timeout_msec = wdt_dev->timeout * MSEC_PER_SEC;
>> +
>> +	do {
>> +		usb_streamlabs_wdt_prepare_buf((u16 *) streamlabs_wdt->buffer,
>> +							cmd, timeout_msec);
>> +		/* send command to watchdog */
>> +		retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
>> +				streamlabs_wdt->buffer, BUFFER_TRANSFER_LENGTH,
>
> Because of this line.
>
> The problem is subtle. Your buffer and your lock share a cacheline.
> On some architecture the cache is not consistent with respect to DMA.
> On them cachelines holding a buffer for DMA need to be flushed to RAM
> and invalidated and you may read from them only after DMA has finished.
>
> Thus you may have prepared a cacheline for DMA but somebody tries taking
> the lock. Then the cacheline with the lock is read from RAM. If that
> happens before you finish the DMA the data resulting from DMA is lost.
>
> The fix is to allocate the buffer with its own allocation. The VM
> subsystem makes sure separate allocation don't share cachelines.
>

Hi Oliver,

For my own education, would adding ____cacheline_aligned to the buffer variable
declaration solve the problem as well ?

Thanks,
Guenter

> That is the long explanation for what I mean when I say that you violate
> the DMA rules.
>
> 	Regards
> 		Oliver
>
>
>

