Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54979 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbbLAQCH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Dec 2015 11:02:07 -0500
Subject: Re: [char-misc-next 3/6] mei: wd: implement MEI iAMT watchdog driver
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"wim@iguana.be" <wim@iguana.be>
References: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
 <1448541081-11299-4-git-send-email-tomas.winkler@intel.com>
 <565C7F65.8070305@roeck-us.net> <1448970872.30677.15.camel@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565DC47B.3060402@roeck-us.net>
Date: Tue, 1 Dec 2015 08:02:03 -0800
MIME-Version: 1.0
In-Reply-To: <1448970872.30677.15.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/01/2015 03:55 AM, Winkler, Tomas wrote:
[ ... ]

>>> +/**
>>> + * struct mei_wdt_dev - watchdog device wrapper
>>> + *
>>> + * @wdd: watchdog device
>>> + * @wdt: back pointer to mei_wdt driver
>>> + * @refcnt: reference counter
>>> + */
>>> +struct mei_wdt_dev {
>>> +	struct watchdog_device wdd;
>>> +	struct mei_wdt *wdt;
>>> +	struct kref refcnt;
>>> +};
>>> +
>>> +/**
>>> + * struct mei_wdt - mei watchdog driver
>>> + *
>>> + * @cldev: mei watchdog client device
>>> + * @mwd: watchdog device wrapper
>>> + * @state: watchdog internal state
>>> + * @timeout: watchdog current timeout
>>> + */
>>> +struct mei_wdt {
>>> +	struct mei_cl_device *cldev;
>>> +	struct mei_wdt_dev *mwd;
>>> +	enum mei_wdt_state state;
>>> +	u16 timeout;
>>> +};
>>
>> Any special reason for having two data structures instead of one ?
>> You could just move the variables from struct mei_wdt_dev into
>> struct mei_wdt, no ?
>
> Yes, on newer platform mei_wdt_dev might be not present in case the the
> device is not provisioned. This came to action in the following
> patches.
>

It is still an implementation choice to keep the data structures separate.
That mei_wdt_dev can be unregistered doesn't mean that the data structure
has to be destroyed or allocated on registration.

>>> +
>>> +struct mei_wdt_hdr {
>>> +	u8 command;
>>> +	u8 bytecount;
>>> +	u8 subcommand;
>>> +	u8 versionnumber;
>>> +};
>>> +
>>> +struct mei_wdt_start_request {
>>> +	struct mei_wdt_hdr hdr;
>>> +	u16 timeout;
>>> +	u8 reserved[17];
>>> +} __packed;
>>> +
>>> +struct mei_wdt_stop_request {
>>> +	struct mei_wdt_hdr hdr;
>>> +} __packed;
>>> +
>>> +/**
>>> + * mei_wdt_ping - send wd start command
>>> + *
>>> + * @wdt: mei watchdog device
>>> + *
>>> + * Return: number of bytes sent on success,
>>> + *         negative errno code on failure
>>> + */
>>> +static int mei_wdt_ping(struct mei_wdt *wdt)
>>> +{
>>> +	struct mei_wdt_start_request req;
>>> +	const size_t req_len = sizeof(req);
>>> +
>>> +	memset(&req, 0, req_len);
>>> +	req.hdr.command = MEI_MANAGEMENT_CONTROL;
>>> +	req.hdr.bytecount = req_len - offsetof(struct mei_wdt_hdr,
>>> subcommand);
>>> +	req.hdr.subcommand = MEI_MC_START_WD_TIMER_REQ;
>>> +	req.hdr.versionnumber = MEI_MC_VERSION_NUMBER;
>>> +	req.timeout = wdt->timeout;
>>> +
>>> +	return mei_cldev_send(wdt->cldev, (u8 *)&req, req_len);
>>> +}
>>> +
>>> +/**
>>> + * mei_wdt_stop - send wd stop command
>>> + *
>>> + * @wdt: mei watchdog device
>>> + *
>>> + * Return: number of bytes sent on success,
>>> + *         negative errno code on failure
>>> + */
>>> +static int mei_wdt_stop(struct mei_wdt *wdt)
>>> +{
>>> +	struct mei_wdt_stop_request req;
>>> +	const size_t req_len = sizeof(req);
>>> +
>>> +	memset(&req, 0, req_len);
>>> +	req.hdr.command = MEI_MANAGEMENT_CONTROL;
>>> +	req.hdr.bytecount = req_len - offsetof(struct mei_wdt_hdr,
>>> subcommand);
>>> +	req.hdr.subcommand = MEI_MC_STOP_WD_TIMER_REQ;
>>> +	req.hdr.versionnumber = MEI_MC_VERSION_NUMBER;
>>> +
>>> +	return mei_cldev_send(wdt->cldev, (u8 *)&req, req_len);
>>> +}
>>> +
>>> +/**
>>> + * mei_wdt_ops_start - wd start command from the watchdog core.
>>> + *
>>> + * @wdd: watchdog device
>>> + *
>>> + * Return: 0 on success or -ENODEV;
>>> + */
>>> +static int mei_wdt_ops_start(struct watchdog_device *wdd)
>>> +{
>>> +	struct mei_wdt_dev *mwd = watchdog_get_drvdata(wdd);
>>> +
>>> +	if (!mwd)
>>> +		return -ENODEV;
>>
>> This can only happen because you call watchdog_set_drvdata() after
>> watchdog device registration. If that happens, the system is in
>> really bad shape.
>
> mei_wdt_dev can destroyed during
> driver operation if the device is unprovisioned, but still you the
> condition should not happen unless we have a bug. We can put WARN_ON()
> there.
>

The calling code should take care of that and not call those functions
after unregistration. More on that below.

>>
>> I would suggest to move the call to watchdog_set_drvdata() ahead
>> of watchdog_register_device() and drop those checks.
>>
>>> +
>>> +	mwd->wdt->state = MEI_WDT_START;
>>> +	wdd->timeout = mwd->wdt->timeout;
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * mei_wdt_ops_stop - wd stop command from the watchdog core.
>>> + *
>>> + * @wdd: watchdog device
>>> + *
>>> + * Return: 0 if success, negative errno code for failure
>>> + */
>>> +static int mei_wdt_ops_stop(struct watchdog_device *wdd)
>>> +{
>>> +	struct mei_wdt_dev *mwd = watchdog_get_drvdata(wdd);
>>> +	struct mei_wdt *wdt;
>>> +	int ret;
>>> +
>>> +	if (!mwd)
>>> +		return -ENODEV;
>>> +
>>> +	wdt = mwd->wdt;
>>> +
>>> +	if (wdt->state != MEI_WDT_RUNNING)
>>> +		return 0;
>>> +
>>> +	wdt->state = MEI_WDT_STOPPING;
>>> +
>>> +	ret = mei_wdt_stop(wdt);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	wdt->state = MEI_WDT_IDLE;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * mei_wdt_ops_ping - wd ping command from the watchdog core.
>>> + *
>>> + * @wdd: watchdog device
>>> + *
>>> + * Return: 0 if success, negative errno code on failure
>>> + */
>>> +static int mei_wdt_ops_ping(struct watchdog_device *wdd)
>>> +{
>>> +	struct mei_wdt_dev *mwd = watchdog_get_drvdata(wdd);
>>> +	struct mei_wdt *wdt;
>>> +	int ret;
>>> +
>>> +	if (!mwd)
>>> +		return -ENODEV;
>>> +
>>> +	wdt = mwd->wdt;
>>> +
>>> +	if (wdt->state != MEI_WDT_START &&
>>> +	    wdt->state != MEI_WDT_RUNNING)
>>
>> Unnecessary continuation line ?
> Looks more readable to me. but we can also straight the condition.
>>
>>> +		return 0;
>>> +
>>> +	ret = mei_wdt_ping(wdt);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	wdt->state = MEI_WDT_RUNNING;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * mei_wdt_ops_set_timeout - wd set timeout command from the
>>> watchdog core.
>>> + *
>>> + * @wdd: watchdog device
>>> + * @timeout: timeout value to set
>>> + *
>>> + * Return: 0 if success, negative errno code for failure
>>> + */
>>> +static int mei_wdt_ops_set_timeout(struct watchdog_device *wdd,
>>> +				   unsigned int timeout)
>>> +{
>>> +	struct mei_wdt_dev *mwd = watchdog_get_drvdata(wdd);
>>> +	struct mei_wdt *wdt;
>>> +
>>> +	if (!mwd)
>>> +		return -ENODEV;
>>> +
>>> +	wdt = mwd->wdt;
>>> +
>>> +	/* valid value is already checked by the caller */
>>> +	wdt->timeout = timeout;
>>> +	wdd->timeout = timeout;
>>
>> One of those seems unnecessary. Why keep the timeout twice ?
>
> We need two as wdd may not exists and we still need to send ping to
> detect if the device is provisioned.
>

Ok, makes sense.

>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void mei_wdt_release(struct kref *ref)
>>> +{
>>> +	struct mei_wdt_dev *mwd = container_of(ref, struct
>>> mei_wdt_dev, refcnt);
>>> +
>>> +	kfree(mwd);
>>> +}
>>> +
>>> +static void mei_wdt_ops_ref(struct watchdog_device *wdd)
>>> +{
>>> +	struct mei_wdt_dev *mwd = watchdog_get_drvdata(wdd);
>>> +
>>> +	kref_get(&mwd->refcnt);
>>> +}
>>> +
>>> +static void mei_wdt_ops_unref(struct watchdog_device *wdd)
>>> +{
>>> +	struct mei_wdt_dev *mwd = watchdog_get_drvdata(wdd);
>>> +
>>> +	kref_put(&mwd->refcnt, mei_wdt_release);
>>> +}
>>> +
>>> +static const struct watchdog_ops wd_ops = {
>>> +	.owner       = THIS_MODULE,
>>> +	.start       = mei_wdt_ops_start,
>>> +	.stop        = mei_wdt_ops_stop,
>>> +	.ping        = mei_wdt_ops_ping,
>>> +	.set_timeout = mei_wdt_ops_set_timeout,
>>> +	.ref         = mei_wdt_ops_ref,
>>> +	.unref       = mei_wdt_ops_unref,
>>> +};
>>> +
>>> +static struct watchdog_info wd_info = {
>>> +	.identity = INTEL_AMT_WATCHDOG_ID,
>>> +	.options  = WDIOF_KEEPALIVEPING |
>>> +		    WDIOF_SETTIMEOUT |
>>> +		    WDIOF_ALARMONLY,
>>> +};
>>> +
>>> +static int mei_wdt_register(struct mei_wdt *wdt)
>>> +{
>>> +	struct mei_wdt_dev *mwd;
>>> +	struct device *dev;
>>> +	int ret;
>>> +
>>> +	if (!wdt || !wdt->cldev)
>>> +		return -EINVAL;
>>> +
>>> +	dev = &wdt->cldev->dev;
>>> +
>>> +	mwd = kzalloc(sizeof(struct mei_wdt_dev), GFP_KERNEL);
>>> +	if (!mwd)
>>> +		return -ENOMEM;
>>> +
>>> +	mwd->wdt = wdt;
>>> +	mwd->wdd.info = &wd_info;
>>> +	mwd->wdd.ops = &wd_ops;
>>> +	mwd->wdd.parent = dev;
>>> +	mwd->wdd.timeout = MEI_WDT_DEFAULT_TIMEOUT;
>>> +	mwd->wdd.min_timeout = MEI_WDT_MIN_TIMEOUT;
>>> +	mwd->wdd.max_timeout = MEI_WDT_MAX_TIMEOUT;
>>> +	kref_init(&mwd->refcnt);
>>> +
>>> +	ret = watchdog_register_device(&mwd->wdd);
>>> +	if (ret) {
>>> +		dev_err(dev, "unable to register watchdog device =
>>> %d.\n", ret);
>>> +		kref_put(&mwd->refcnt, mei_wdt_release);
>>> +		return ret;
>>> +	}
>>> +
>>> +	wdt->mwd = mwd;
>>> +	watchdog_set_drvdata(&mwd->wdd, mwd);
>>> +	return 0;
>>> +}
>>> +
>>> +static void mei_wdt_unregister(struct mei_wdt *wdt)
>>> +{
>>> +	if (!wdt->mwd)
>>> +		return;
>>> +
>>> +	watchdog_unregister_device(&wdt->mwd->wdd);
>>> +	kref_put(&wdt->mwd->refcnt, mei_wdt_release);
>>> +	wdt->mwd = NULL;

If setting this to NULL was really needed, you would have a race condition here:
wdt->mwd is set to NULL only after the pointer it points to was freed, leaving
a small window where the code above could still access it.

>>> +}
>>
>> Seems to me that using two separate data structures instead of one
>> adds a lot of complexity.
>
> It might be reduced but I'm not sure it can be significantly simpler.
> It the reference counter will be part of watchdog_device it would be
> simpler.
>

It would be there if struct watchdog_device was allocated by the
watchdog core, which is not the case. I am still trying to create
a situation where the local data structure (struct mei_wdt in this case)
can be released while the watchdog device is still open
(ie how to unprovision the watchdog device while in use).

Once I figure that out, I hope I can find a way to protect it
differently and drop the ref/unref callbacks. I suspect it may
be necessary to separate struct watchdog_device into two parts:
one used by drivers and one used by the watchdog core.
The watchdog core would then manage its own data structure, and
no longer depend on struct watchdog_device (owned by the driver)
to actually be there. Different story, though.

Thanks,
Guenter

