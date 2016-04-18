Return-path: <oneukum@suse.com>
Message-ID: <1460988518.25119.28.camel@suse.com>
Subject: Re: [PATCH v2] watchdog: add driver for StreamLabs USB watchdog
 device
From: Oliver Neukum <oneukum@suse.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexey Klimov <klimov.linux@gmail.com>, yury.norov@gmail.com,
 wim@iguana.be,  linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Date: Mon, 18 Apr 2016 16:08:38 +0200
In-Reply-To: <5714E7D3.4030809@roeck-us.net>
References: <1460948016-5453-1-git-send-email-klimov.linux@gmail.com>
	 <1460968368.25119.7.camel@suse.com> <5714E7D3.4030809@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, 2016-04-18 at 06:57 -0700, Guenter Roeck wrote:
> On 04/18/2016 01:32 AM, Oliver Neukum wrote:
> > On Mon, 2016-04-18 at 03:53 +0100, Alexey Klimov wrote:
> >> This patch creates new driver that supports StreamLabs usb watchdog
> >> device. This device plugs into 9-pin usb header and connects to
> >> reset pin and reset button on common PC.
> >>
> >> USB commands used to communicate with device were reverse
> >> engineered using usbmon.
> >
> > Almost. I see only one issue.
> >
> >> +struct streamlabs_wdt {
> >> +	struct watchdog_device wdt_dev;
> >> +	struct usb_interface *intf;
> >> +
> >> +	struct mutex lock;
> >> +	u8 buffer[BUFFER_LENGTH];
> >
> > That is wrong.
> >
> >> +};
> >> +
> >
> > [..]
> >
> >> +static int usb_streamlabs_wdt_command(struct watchdog_device *wdt_dev, u16 cmd)
> >> +{
> >> +	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> >> +	struct usb_device *usbdev;
> >> +	int retval;
> >> +	int size;
> >> +	unsigned long timeout_msec;
> >> +
> >> +	int retry_counter = 10;		/* how many times to re-send stop cmd */
> >> +
> >> +	mutex_lock(&streamlabs_wdt->lock);
> >> +
> >> +	if (unlikely(!streamlabs_wdt->intf)) {
> >> +		mutex_unlock(&streamlabs_wdt->lock);
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	usbdev = interface_to_usbdev(streamlabs_wdt->intf);
> >> +	timeout_msec = wdt_dev->timeout * MSEC_PER_SEC;
> >> +
> >> +	do {
> >> +		usb_streamlabs_wdt_prepare_buf((u16 *) streamlabs_wdt->buffer,
> >> +							cmd, timeout_msec);
> >> +		/* send command to watchdog */
> >> +		retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
> >> +				streamlabs_wdt->buffer, BUFFER_TRANSFER_LENGTH,
> >
> > Because of this line.
> >
> > The problem is subtle. Your buffer and your lock share a cacheline.
> > On some architecture the cache is not consistent with respect to DMA.
> > On them cachelines holding a buffer for DMA need to be flushed to RAM
> > and invalidated and you may read from them only after DMA has finished.
> >
> > Thus you may have prepared a cacheline for DMA but somebody tries taking
> > the lock. Then the cacheline with the lock is read from RAM. If that
> > happens before you finish the DMA the data resulting from DMA is lost.
> >
> > The fix is to allocate the buffer with its own allocation. The VM
> > subsystem makes sure separate allocation don't share cachelines.
> >
> 
> Hi Oliver,
> 
> For my own education, would adding ____cacheline_aligned to the buffer variable
> declaration solve the problem as well ?

Possibly. We have never gone that route. The obvious problems is that
I am not sure our alignment is known before boot.

	Regards
		Oliver
