Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41136 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbbHDPbs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Aug 2015 11:31:48 -0400
Message-ID: <55C0DADF.9050505@roeck-us.net>
Date: Tue, 04 Aug 2015 08:31:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/8] watchdog: Introduce hardware maximum timeout in watchdog
 core
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <1438654414-29259-3-git-send-email-linux@roeck-us.net> <20150804121816.GM9999@pengutronix.de>
In-Reply-To: <20150804121816.GM9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On 08/04/2015 05:18 AM, Uwe Kleine-K=F6nig wrote:
> On Mon, Aug 03, 2015 at 07:13:28PM -0700, Guenter Roeck wrote:
>> Introduce an optional hardware maximum timeout in the watchdog core.
>> The hardware maximum timeout can be lower than the maximum timeout.
> Is this only until all drivers are converted to make use of the central
> worker? Otherwise this doesn't make sense, right?
>
>> Drivers can set the maximum hardare timeout value in the watchdog data
> s/hardare/hardware/
>
Always those fat fingers ;-)

>> structure. If the configured timeout exceeds half the value of the
>> maximum hardware timeout, the watchdog core enables a timer function
>> to assist sending keepalive requests to the watchdog driver.
> I don't understand why you want to halve the maximum hw-timeout. If my
> watchdog has hw-max-timeout =3D 5s and userspace sets it to 3s there
> should be no need for assistance?! I think the implementation is the
> other way round?
>
It is supposed to reflect the _maximum_ timeout. That is different to
the time between heartbeats, which is supposed to be less; using half
the value of the maximum hardware timeout seemed to be a safe number.
It is supposed to be a constant after initialization and should not chang=
e
afterwards if the (soft) timeout is changed. Not sure how to explain
that better.

>> ---
>>   Documentation/watchdog/watchdog-kernel-api.txt |  14 +++
>>   drivers/watchdog/watchdog_dev.c                | 121 +++++++++++++++=
++++++----
>>   include/linux/watchdog.h                       |  21 ++++-
>>   3 files changed, 135 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Document=
ation/watchdog/watchdog-kernel-api.txt
>> index d8b0d3367706..5fa085276874 100644
>> --- a/Documentation/watchdog/watchdog-kernel-api.txt
>> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
>> @@ -53,9 +53,12 @@ struct watchdog_device {
>>   	unsigned int timeout;
>>   	unsigned int min_timeout;
>>   	unsigned int max_timeout;
>> +	unsigned int max_hw_timeout_ms;
>> +	unsigned long last_keepalive;
>>   	void *driver_data;
>>   	struct mutex lock;
>>   	unsigned long status;
>> +	struct delayed_work work;
>>   	struct list_head deferred;
>>   };
>>
>> @@ -73,8 +76,18 @@ It contains following fields:
>>     additional information about the watchdog timer itself. (Like it's=
 unique name)
>>   * ops: a pointer to the list of watchdog operations that the watchdo=
g supports.
>>   * timeout: the watchdog timer's timeout value (in seconds).
>> +  This is the time after which the system will reboot if user space d=
oes
>> +  not send a heartbeat request if the watchdog device is opened.
>> +  This may or may not be the hardware watchdog timeout. See max_hw_ti=
meout_ms
>> +  for more details.
> Hmm, what is timeout then? Is this the value that the driver currently
> handles? Or the framework with the automatic pings? Probably the
> former?! This needs better wording.
>

As I say above, "This is the time after which the system will reboot if u=
ser
space does not send a heartbeat request if the watchdog device is opened"=
.
Not sure how to express that better. Any idea ?

>>   * min_timeout: the watchdog timer's minimum timeout value (in second=
s).
>>   * max_timeout: the watchdog timer's maximum timeout value (in second=
s).
>> +* max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds. May =
differ
>> +  from max_timeout. If set, the infrastructure will send a heartbeat =
to the
>> +  watchdog driver if 'timeout' is larger than 'max_hw_timeout / 2',
>> +  unless user space failed to ping the watchdog for 'timeout' seconds=
.
> In the long run max_timeout should be removed, right?
>
It could be removed, yes, though that would require each of the drivers
to set max_hw_timeout_ms. That is a much larger task, though, and might b=
e
difficult to accomplish since each driver handles it differently (in some
cases it is a hard limit, in others it is an arbitrary number).

>> +* last_keepalive: Time of most recent keepalive triggered from user s=
pace,
>> +  in jiffies.
>>   * bootstatus: status of the device after booting (reported with watc=
hdog
>>     WDIOF_* status bits).
>>   * driver_data: a pointer to the drivers private data of a watchdog d=
evice.
>> @@ -85,6 +98,7 @@ It contains following fields:
>>     information about the status of the device (Like: is the watchdog =
timer
>>     running/active, is the nowayout bit set, is the device opened via
>>     the /dev/watchdog interface or not, ...).
>> +* work: Worker data structure for WatchDog Timer Driver Core internal=
 use only.
>>   * deferred: entry in wtd_deferred_reg_list which is used to
>>     register early initialized watchdogs.
>>
>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchd=
og_dev.c
>> index 06171c73daf5..25849c1d6dc1 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -37,7 +37,9 @@
>>   #include <linux/errno.h>	/* For the -ENODEV/... values */
>>   #include <linux/kernel.h>	/* For printk/panic/... */
>>   #include <linux/fs.h>		/* For file operations */
>> +#include <linux/jiffies.h>	/* For timeout functions */
>>   #include <linux/watchdog.h>	/* For watchdog specific items */
>> +#include <linux/workqueue.h>	/* For workqueue */
>>   #include <linux/miscdevice.h>	/* For handling misc devices */
>>   #include <linux/init.h>		/* For __init/__exit/... */
>>   #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
>> @@ -49,6 +51,53 @@ static dev_t watchdog_devt;
>>   /* the watchdog device behind /dev/watchdog */
>>   static struct watchdog_device *old_wdd;
>>
>> +static struct workqueue_struct *watchdog_wq;
>> +
>> +static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>> +{
>> +	unsigned int hm =3D wdd->max_hw_timeout_ms;
>> +	unsigned int m =3D wdd->max_timeout * 1000;
>> +
>> +	return watchdog_active(wdd) && hm && hm !=3D m &&
>> +		wdd->timeout * 500 > hm;
>
> I don't understand what max_timeout is now that there is max_hw_timeout=
.
> So I don't understand why you need hm !=3D m either.
>

Backward compatibility. A driver which does not set max_hw_timeout_ms,
or sets both to the same value, by definition expects to handle everythin=
g
internally, and thus no worker is configured.

> Taking the example from above (hw-maxtimeout =3D 5000ms, current timeou=
t =3D
> 3s) this doesn't trigger.
>
This is intentional. The idea here is that the driver set max_timeout
(here to a low value), and thus doesn't expect additional internal
heartbeats generated from the kernel. In the above example, user space
would be expected to send heartbeats after less than 3s, which does
not require kernel assistance. Even if the current timeout is set to 5s,
user space would be expected to send heartbeats much more often than that=
,
say every 2 or 3 seconds. Again, this does not require kernel assistance.

> And the other way round:
>   - hw-max-timeout =3D 3s
>   - timeout =3D 5s
>
> In this case userspace might send a ping only after 4 seconds, but
> watchdog_need_worker will be false.
>

Yep, that is wrong. The condition should be
	wdd->timeout * 1000 > hm
to trigger internal heartbeats every 1.5 seconds.

> What is the meaning of WDOG_ACTIVE now? does it mean userspace has the
> device open? Then this looks wrong, too.
>
Yes, it is, and always was. Why is that wrong ? It indicates if the
keepalive worker needs to run or not, and in this state it won't need
to run if the watchdog is not active (that state is added in the next pat=
ch).

> /me wonders if he understood that function correctly?!
>
>> @@ -88,6 +96,8 @@ struct watchdog_device {
>>   	unsigned int timeout;
>>   	unsigned int min_timeout;
>>   	unsigned int max_timeout;
>> +	unsigned int max_hw_timeout_ms;
>> +	unsigned long last_keepalive;
>>   	void *driver_data;
>>   	struct mutex lock;
>>   	unsigned long status;
> It would be nice to group this a bit to make it more clear which member=
s
> are supposed to be set by driver and which are not.
>
Good idea. I'll do that.

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
