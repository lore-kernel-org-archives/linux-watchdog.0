Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41197 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbHEJOW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 05:14:22 -0400
Message-ID: <55C1D3E8.6010705@roeck-us.net>
Date: Wed, 05 Aug 2015 02:14:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>, kernel@pengutronix.de
Subject: Re: [PATCH 2/8] watchdog: Introduce hardware maximum timeout in watchdog
 core
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <1438654414-29259-3-git-send-email-linux@roeck-us.net> <20150804121816.GM9999@pengutronix.de> <55C0DADF.9050505@roeck-us.net> <20150804155220.GV9999@pengutronix.de> <55C0E24F.5020802@roeck-us.net> <20150805082252.GX9999@pengutronix.de>
In-Reply-To: <20150805082252.GX9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/05/2015 01:22 AM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Tue, Aug 04, 2015 at 09:03:27AM -0700, Guenter Roeck wrote:
>> On 08/04/2015 08:52 AM, Uwe Kleine-König wrote:
>>> On Tue, Aug 04, 2015 at 08:31:43AM -0700, Guenter Roeck wrote:
>>>> On 08/04/2015 05:18 AM, Uwe Kleine-König wrote:
>>>>> On Mon, Aug 03, 2015 at 07:13:28PM -0700, Guenter Roeck wrote:
>>>>>> structure. If the configured timeout exceeds half the value of the
>>>>>> maximum hardware timeout, the watchdog core enables a timer function
>>>>>> to assist sending keepalive requests to the watchdog driver.
>>>>> I don't understand why you want to halve the maximum hw-timeout. If my
>>>>> watchdog has hw-max-timeout = 5s and userspace sets it to 3s there
>>>>> should be no need for assistance?! I think the implementation is the
>>>>> other way round?
>>>>>
>>>> It is supposed to reflect the _maximum_ timeout. That is different to
>>>> the time between heartbeats, which is supposed to be less; using half
>>>> the value of the maximum hardware timeout seemed to be a safe number.
>>> Right, I got that. With hw-max-timeout = 5s the machine resets after 5s
>>> not caring for the device. And so pinging repeatedly after 2.5s is fine.
>>> But if userspace sets a timeout of 3s (probably with the intention to
>>> ping with a frequency of 1/1.5s) there is no need for worker-assistance,
>>> because the pings coming in each 1.5s provided by userspace are good
>>> enough.
>>>
>> Yes, that is how it is supposed to work.
> So for the changelog you want:
>
> 	If the configured timeout exceeds the maximum hardware timeout
> 	the watchdog core enables a timer function ...
>
> right?
>
Something like that. You are right, the changelog needs an update.

>>>>>> +static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>>>>>> +{
>>>>>> +	unsigned int hm = wdd->max_hw_timeout_ms;
>>>>>> +	unsigned int m = wdd->max_timeout * 1000;
>>>>>> +
>>>>>> +	return watchdog_active(wdd) && hm && hm != m &&
>>>>>> +		wdd->timeout * 500 > hm;
> One problem with the worker I see is that the reset will probably be
> delayed with your worker. Consider userspace sets timeout = 10 s because
> if the main application doesn't work for 12 s something dangerous can
> happen. (Consider a guillotine where the blade can only be hold up for
> 12 s when not locked. :-) Now if the hw-max-timeout is 9s you setup a
> timer to ping at $last_keepalive + 4.5 s and $last_keepalive + 9 s (not
> taking timer and system latency into account). That means the system
> only resets 18 s after the last userspace ping. Oops.
>
> So ideally you send the last auto-ping at $last_keepalive +
> $configured_timeout - $hw-max-timeout (assuming the hardware is
> configured for $hw-max-timeout).
>

Yes, you are right, and makes sense. In practice that means I would
schedule an auto-ping 1s after the most recent user ping in your
example above, not at fixed intervals of 4.5s. I'll look into it.
Thinking about it, it is better anyway to reschedule the auto-ping
after a user ping, to avoid unnecessary pings.

>>>>> I don't understand what max_timeout is now that there is max_hw_timeout.
>>>>> So I don't understand why you need hm != m either.
>>>>>
>>>>
>>>> Backward compatibility. A driver which does not set max_hw_timeout_ms,
>>>> or sets both to the same value, by definition expects to handle everything
>>>> internally, and thus no worker is configured.
>>> And a driver that does
>>>
>>> 	max_timeout = 5
>>> 	max_hw_timeout = 5125
>>>
>>> falls through the cracks.
>>>
>> Hmm - not that this configuration makes any sense, but you are right.
>> I'll make it "hm < m".
> It does not? What do you expect max_timeout to be set to if the maximal
> hw-timeout is 5125 ms? 0 would work, but IMHO you need some more
> documentation then.
>

0 would work, or anything larger than 5.125s.

If you want to set max_timeout to 0, there is no need to set max_hw_timeout.

