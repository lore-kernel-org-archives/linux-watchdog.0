Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59837 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbcARUVj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jan 2016 15:21:39 -0500
Subject: Re: [char-misc-next, v4, 5/7] watchdog: mei_wdt: register wd device
 only if required
To: "Winkler, Tomas" <tomas.winkler@intel.com>
References: <1452206967-1144-6-git-send-email-tomas.winkler@intel.com>
 <20160117171308.GA10264@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B54139E08@hasmsx108.ger.corp.intel.com>
 <569C0BE9.5030605@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B5413A3B2@hasmsx108.ger.corp.intel.com>
 <569D07D9.8020902@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B5413A598@hasmsx108.ger.corp.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <569D494E.8030905@roeck-us.net>
Date: Mon, 18 Jan 2016 12:21:34 -0800
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B5413A598@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/18/2016 11:36 AM, Winkler, Tomas wrote:
>>
>> On 01/18/2016 05:19 AM, Winkler, Tomas wrote:
>>>
>>>
>>>> only
>>>>>> if required
>>>>>>
>>>>>> Hi Tomas,
>>>>>>
>>>>>> On Fri, Jan 08, 2016 at 12:49:25AM +0200, Winkler, Tomas wrote:
>>>>>>> From: Alexander Usyskin <alexander.usyskin@intel.com>
>>>>>>>
>>>>>>> For Intel Broadwell and newer platforms, the ME device can inform
>>>>>>> the host whether the watchdog functionality is activated or not.
>>>>>>> If the watchdog functionality is not activated then the watchdog interface
>>>>>>> can be not registered and eliminate unnecessary pings and hence lower
>> the
>>>>>>> power consumption by avoiding waking up the device.
>>>>>>> The feature can be deactivated also without reboot
>>>>>>> in that case the watchdog device should be unregistered at runtime.
>>>>>>>
>>>>>>> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
>>>>>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>>>>>> ---
>>>>>>> V2: rework unregistration
>>>>>>> V3: rebase; implement unregistraion also at runtime
>>>>>>> V4: Rebase the code over patchset : "watchdog: Replace driver based
>>>>>> refcounting"
>>>>>>>
>>>>>>>     drivers/watchdog/mei_wdt.c | 196
>>>>>> ++++++++++++++++++++++++++++++++++++++++++---
>>>>>>>     1 file changed, 187 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
>>>>>>> index e7e3f144f2b0..85b27fc5d4ec 100644
>>>>>>> --- a/drivers/watchdog/mei_wdt.c
>>>>>>> +++ b/drivers/watchdog/mei_wdt.c
>>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>> +static void mei_wdt_unregister_work(struct work_struct *work)
>>>>>>> +{
>>>>>>> +	struct mei_wdt *wdt = container_of(work, struct mei_wdt,
>> unregister);
>>>>>>> +
>>>>>>> +	mei_wdt_unregister(wdt);
>>>>>>> +}
>>>>>>
>>>>>> Registration is synchronous, unregistration is asynchronous.
>>>>>>
>>>>>> Assuming that is on purpose, I think it warrants an explanation.
>>>>>>
>>>>> The unregistration is detected on response from the  ping, which is run under
>>>> same mutex as unregistration.
>>>>> Tomas
>>>>>
>>>>>
>>>> And that explains why registration can be synchronous and unregistration
>>>> has to be asynchronous ?
>>>
>>> You need to connect the dots but yes.
>>> The registration is run from the internal ping request (in probe) or from an
>> internal event (in runtime), so the flow is not already locked by the watchdog
>> mutex.
>>> Hope it helps.
>>
>> What I was asking for is a comment such as
>>
>> "We can not unregister directly because a ping operation (triggered
>> through the watchdog subsystem) is pending and must be completed first."
>
> You can put it also that way, but in the bottom line you will get deadlock.

Yes, understood. Maybe that should be part of the comment.

> According your comment I'm guessing  that you are asking me to update the commit message, please be more direct,
> I'm not native English speaker and may miss little nuances.
>
Hi Tomas,

please add a comment into the source code, describing why unregistration has to be
asynchronous. It took me a while to understand the context, and we want to make
sure that others don't have to repeat that exercise.

Other than that, the series is fine with me, except that the patches
affecting the mei directory don't apply to the current mainline
as of this morning (possibly due to some other changes in that directory).

I would suggest to add the comment, wait for -rc1, rebase, and re-send
the series with my Acked-by: added to all patches.

Thanks,
Guenter

