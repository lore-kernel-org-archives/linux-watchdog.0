Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38033 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbLXAX6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Dec 2015 19:23:58 -0500
Subject: Re: [char-misc-next v3 3/8] watchdog: mei_wdt: implement MEI iAMT
 watchdog driver
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
 <1450739881-3923-4-git-send-email-tomas.winkler@intel.com>
 <5678D85E.30101@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B540F6079@hasmsx108.ger.corp.intel.com>
 <5678FE75.6050905@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B540FBDA9@hasmsx108.ger.corp.intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <567B3B1B.5040900@roeck-us.net>
Date: Wed, 23 Dec 2015 16:23:55 -0800
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B540FBDA9@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/23/2015 02:38 PM, Winkler, Tomas wrote:
>>
>> On 12/21/2015 11:19 PM, Winkler, Tomas wrote:
>>>
>>>>
>>>> On 12/21/2015 03:17 PM, Tomas Winkler wrote:
>>>>> Create a driver with the generic watchdog interface
>>>>> for the MEI iAMT watchdog device.
>>>>>
>>>>> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
>>>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>>>> ---
>>>>> V2: The watchdog device is no longer dynamically allocated in separate
>>>> structure
>>>>> V3: Revert back to dynamically allocated watchdog device wrapper
>>>>>
>>>>>     Documentation/misc-devices/mei/mei.txt |  12 +-
>>>>>     MAINTAINERS                            |   1 +
>>>>>     drivers/watchdog/Kconfig               |  15 +
>>>>>     drivers/watchdog/Makefile              |   1 +
>>>>>     drivers/watchdog/mei_wdt.c             | 481
>>>> +++++++++++++++++++++++++++++++++
>>>>>     5 files changed, 504 insertions(+), 6 deletions(-)
>>>>>     create mode 100644 drivers/watchdog/mei_wdt.c
>>>>>
>>>>> diff --git a/Documentation/misc-devices/mei/mei.txt b/Documentation/misc-
>>>> devices/mei/mei.txt
>>>>> index 91c1fa34f48b..2b80a0cd621f 100644
>>>>> --- a/Documentation/misc-devices/mei/mei.txt
>>>>> +++ b/Documentation/misc-devices/mei/mei.txt
>>>>> @@ -231,15 +231,15 @@ IT knows when a platform crashes even when
>> there
>>>> is a hard failure on the host.
>>>>>     The Intel AMT Watchdog is composed of two parts:
>>>>>     	1) Firmware feature - receives the heartbeats
>>>>>     	   and sends an event when the heartbeats stop.
>>>>> -	2) Intel MEI driver - connects to the watchdog feature, configures the
>>>>> -	   watchdog and sends the heartbeats.
>>>>> +	2) Intel MEI iAMT watchdog driver - connects to the watchdog feature,
>>>>> +	   configures the watchdog and sends the heartbeats.
>>>>>
>>>>> -The Intel MEI driver uses the kernel watchdog API to configure the Intel AMT
>>>>> -Watchdog and to send heartbeats to it. The default timeout of the
>>>>> +The Intel iAMT watchdog MEI driver uses the kernel watchdog API to
>> configure
>>>>> +the Intel AMT Watchdog and to send heartbeats to it. The default timeout
>> of
>>>> the
>>>>>     watchdog is 120 seconds.
>>>>>
>>>>> -If the Intel AMT Watchdog feature does not exist (i.e. the connection failed),
>>>>> -the Intel MEI driver will disable the sending of heartbeats.
>>>>> +If the Intel AMT is not enabled in the firmware then the watchdog client
>> won't
>>>> enumerate
>>>>> +on the me client bus and watchdog devices won't be exposed.
>>>>>
>>>>>
>>>>>     Supported Chipsets
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 9bff63cf326e..e655625c2c16 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -5666,6 +5666,7 @@ S:	Supported
>>>>>     F:	include/uapi/linux/mei.h
>>>>>     F:	include/linux/mei_cl_bus.h
>>>>>     F:	drivers/misc/mei/*
>>>>> +F:	drivers/watchdog/mei_wdt.c
>>>>>     F:	Documentation/misc-devices/mei/*
>>>>>
>>>>>     INTEL MIC DRIVERS (mic)
>>>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>>>> index 1c427beffadd..8ac51d69785c 100644
>>>>> --- a/drivers/watchdog/Kconfig
>>>>> +++ b/drivers/watchdog/Kconfig
>>>>> @@ -1154,6 +1154,21 @@ config SBC_EPX_C3_WATCHDOG
>>>>>     	  To compile this driver as a module, choose M here: the
>>>>>     	  module will be called sbc_epx_c3.
>>>>>
>>>>> +config INTEL_MEI_WDT
>>>>> +	tristate "Intel MEI iAMT Watchdog"
>>>>> +	depends on INTEL_MEI && X86
>>>>> +	select WATCHDOG_CORE
>>>>> +	---help---
>>>>> +	  A device driver for the Intel MEI iAMT watchdog.
>>>>> +
>>>>> +	  The Intel AMT Watchdog is an OS Health (Hang/Crash) watchdog.
>>>>> +	  Whenever the OS hangs or crashes, iAMT will send an event
>>>>> +	  to any subscriber to this event. The watchdog doesn't reset the
>>>>> +	  the platform.
>>>>> +
>>>>> +	  To compile this driver as a module, choose M here:
>>>>> +	  the module will be called mei_wdt.
>>>>> +
>>>>>     # M32R Architecture
>>>>>
>>>>>     # M68K Architecture
>>>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>>>> index 53d4827ddfe1..9069c9dd8aa8 100644
>>>>> --- a/drivers/watchdog/Makefile
>>>>> +++ b/drivers/watchdog/Makefile
>>>>> @@ -123,6 +123,7 @@ obj-$(CONFIG_MACHZ_WDT) += machzwd.o
>>>>>     obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
>>>>>     obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
>>>>>     obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
>>>>> +obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>>>>>
>>>>>     # M32R Architecture
>>>>>
>>>>> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
>>>>> new file mode 100644
>>>>> index 000000000000..5b28a1e95ac1
>>>>> --- /dev/null
>>>>> +++ b/drivers/watchdog/mei_wdt.c
>>>>> @@ -0,0 +1,481 @@
>>>>> +/*
>>>>> + * Intel Management Engine Interface (Intel MEI) Linux driver
>>>>> + * Copyright (c) 2015, Intel Corporation.
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or modify it
>>>>> + * under the terms and conditions of the GNU General Public License,
>>>>> + * version 2, as published by the Free Software Foundation.
>>>>> + *
>>>>> + * This program is distributed in the hope it will be useful, but WITHOUT
>>>>> + * ANY WARRANTY; without even the implied warranty of
>> MERCHANTABILITY
>>>> or
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
>>>> for
>>>>> + * more details.
>>>>> + */
>>>>> +
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/slab.h>
>>>>> +#include <linux/interrupt.h>
>>>>> +#include <linux/watchdog.h>
>>>>> +
>>>>> +#include <linux/uuid.h>
>>>>> +#include <linux/mei_cl_bus.h>
>>>>> +
>>>>> +/*
>>>>> + * iAMT Watchdog Device
>>>>> + */
>>>>> +#define INTEL_AMT_WATCHDOG_ID "iamt_wdt"
>>>>> +
>>>>> +#define MEI_WDT_DEFAULT_TIMEOUT   120  /* seconds */
>>>>> +#define MEI_WDT_MIN_TIMEOUT       120  /* seconds */
>>>>> +#define MEI_WDT_MAX_TIMEOUT     65535  /* seconds */
>>>>> +
>>>>> +/* Commands */
>>>>> +#define MEI_MANAGEMENT_CONTROL 0x02
>>>>> +
>>>>> +/* MEI Management Control version number */
>>>>> +#define MEI_MC_VERSION_NUMBER  0x10
>>>>> +
>>>>> +/* Sub Commands */
>>>>> +#define MEI_MC_START_WD_TIMER_REQ  0x13
>>>>> +#define MEI_MC_STOP_WD_TIMER_REQ   0x14
>>>>> +
>>>>> +/**
>>>>> + * enum mei_wdt_state - internal watchdog state
>>>>> + *
>>>>> + * @MEI_WDT_IDLE: wd is idle and not opened
>>>>> + * @MEI_WDT_START: wd was opened, start was called
>>>>> + * @MEI_WDT_RUNNING: wd is expecting keep alive pings
>>>>> + * @MEI_WDT_STOPPING: wd is stopping and will move to IDLE
>>>>> + */
>>>>> +enum mei_wdt_state {
>>>>> +	MEI_WDT_IDLE,
>>>>> +	MEI_WDT_START,
>>>>> +	MEI_WDT_RUNNING,
>>>>> +	MEI_WDT_STOPPING,
>>>>> +};
>>>>> +
>>>>> +struct mei_wdt;
>>>>> +
>>>>> +/**
>>>>> + * struct mei_wdt_dev - watchdog device wrapper
>>>>> + *
>>>>> + * @wdd: watchdog device
>>>>> + * @wdt: back pointer to mei_wdt driver
>>>>> + * @refcnt: reference counter
>>>>> + */
>>>>> +struct mei_wdt_dev {
>>>>> +	struct watchdog_device wdd;
>>>>> +	struct mei_wdt *wdt;
>>>>> +	struct kref refcnt;
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * struct mei_wdt - mei watchdog driver
>>>>> + * @mwd: watchdog device wrapper
>>>>> + *
>>>>> + * @cldev: mei watchdog client device
>>>>> + * @state: watchdog internal state
>>>>> + * @timeout: watchdog current timeout
>>>>> + */
>>>>> +struct mei_wdt {
>>>>> +	struct mei_wdt_dev *mwd;
>>>>> +
>>>>> +	struct mei_cl_device *cldev;
>>>>> +	enum mei_wdt_state state;
>>>>> +	u16 timeout;
>>>>> +};
>>>>> +
>>>>> +/*
>>>>> + * struct mei_mc_hdr - Management Control Command Header
>>>>> + *
>>>>> + * @command: Management Control (0x2)
>>>>> + * @bytecount: Number of bytes in the message beyond this byte
>>>>> + * @subcommand: Management Control Subcommand
>>>>> + * @versionnumber: Management Control Version (0x10)
>>>>> + */
>>>>> +struct mei_mc_hdr {
>>>>> +	u8 command;
>>>>> +	u8 bytecount;
>>>>> +	u8 subcommand;
>>>>> +	u8 versionnumber;
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * struct mei_wdt_start_request watchdog start/ping
>>>>> + *
>>>>> + * @hdr: Management Control Command Header
>>>>> + * @timeout: timeout value
>>>>> + * @reserved: reserved (legacy)
>>>>> + */
>>>>> +struct mei_wdt_start_request {
>>>>> +	struct mei_mc_hdr hdr;
>>>>> +	u16 timeout;
>>>>> +	u8 reserved[17];
>>>>> +} __packed;
>>>>> +
>>>>> +/**
>>>>> + * struct mei_wdt_stop_request - watchdog stop
>>>>> + *
>>>>> + * @hdr: Management Control Command Header
>>>>> + */
>>>>> +struct mei_wdt_stop_request {
>>>>> +	struct mei_mc_hdr hdr;
>>>>> +} __packed;
>>>>> +
>>>>> +/**
>>>>> + * mei_wdt_ping - send wd start/ping command
>>>>> + *
>>>>> + * @wdt: mei watchdog device
>>>>> + *
>>>>> + * Return: 0 on success,
>>>>> + *         negative errno code on failure
>>>>> + */
>>>>> +static int mei_wdt_ping(struct mei_wdt *wdt)
>>>>> +{
>>>>> +	struct mei_wdt_start_request req;
>>>>> +	const size_t req_len = sizeof(req);
>>>>> +	int ret;
>>>>> +
>>>>> +	memset(&req, 0, req_len);
>>>>> +	req.hdr.command = MEI_MANAGEMENT_CONTROL;
>>>>> +	req.hdr.bytecount = req_len - offsetof(struct mei_mc_hdr,
>>>> subcommand);
>>>>> +	req.hdr.subcommand = MEI_MC_START_WD_TIMER_REQ;
>>>>> +	req.hdr.versionnumber = MEI_MC_VERSION_NUMBER;
>>>>> +	req.timeout = wdt->timeout;
>>>>> +
>>>>> +	ret = mei_cldev_send(wdt->cldev, (u8 *)&req, req_len);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * mei_wdt_stop - send wd stop command
>>>>> + *
>>>>> + * @wdt: mei watchdog device
>>>>> + *
>>>>> + * Return: 0 on success,
>>>>> + *         negative errno code on failure
>>>>> + */
>>>>> +static int mei_wdt_stop(struct mei_wdt *wdt)
>>>>> +{
>>>>> +	struct mei_wdt_stop_request req;
>>>>> +	const size_t req_len = sizeof(req);
>>>>> +	int ret;
>>>>> +
>>>>> +	memset(&req, 0, req_len);
>>>>> +	req.hdr.command = MEI_MANAGEMENT_CONTROL;
>>>>> +	req.hdr.bytecount = req_len - offsetof(struct mei_mc_hdr,
>>>> subcommand);
>>>>> +	req.hdr.subcommand = MEI_MC_STOP_WD_TIMER_REQ;
>>>>> +	req.hdr.versionnumber = MEI_MC_VERSION_NUMBER;
>>>>> +
>>>>> +	ret = mei_cldev_send(wdt->cldev, (u8 *)&req, req_len);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * mei_wdt_ops_start - wd start command from the watchdog core.
>>>>> + *
>>>>> + * @wdd: watchdog device
>>>>> + *
>>>>> + * Return: 0 on success or -ENODEV;
>>>>> + */
>>>>> +static int mei_wdt_ops_start(struct watchdog_device *wdd)
>>>>> +{
>>>>> +	struct mei_wdt_dev *mwd = watchdog_get_drvdata(wdd);
>>>>> +	struct mei_wdt *wdt;
>>>>> +
>>>>> +	if (!mwd)
>>>>> +		return -ENODEV;
>>>>> +
>>>> I don't find a code path where this can be NULL. I also checked later patches,
>>>> but I just don't see it.
>>>>
>>>> Can you clarify how this can happen ? If this is just for safety, it should go.
>>>> We would _want_ the driver to crash unless this is a valid condition.
>>>>
>>>> Several other similar checks below.
>>>
>>> Yes, this can happen and as far I remember it does as we are unregistering the
>> device while the watchdog core is still
>>> holding on wdd.  Also I prefer not crashing the driver and the whole kernel with
>> it, this is API should check its parameters.
>>>
>> After unregistering, the watchdog core doesn't call those functions anymore.
>> It could have happened earlier when you were manipulating the internal status
>> flags, but it should not happen anymore. The watchdog core must not call the
>> ops functions after the device was unregistered.
>
> I agree the code logic seems to function like what you've describing but I've positively hit that condition in some stress test, now I'm not sure in what code version so I will try to get that again for the current one.

That would be great. I am concerned that, if the situation is seen, we would
paint over some bug, maybe even in the infrastructure. If so we'll really
need to understand how to get there, since other drivers could be affected
as well.

Thanks,
Guenter

