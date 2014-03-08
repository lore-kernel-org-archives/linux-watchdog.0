Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55810 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbaCHOMv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 8 Mar 2014 09:12:51 -0500
Message-ID: <531B2560.9030700@roeck-us.net>
Date: Sat, 08 Mar 2014 06:12:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>
CC: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog <linux-watchdog@vger.kernel.org>
Subject: Re: Watchdog drivers and device driver model
References: <1394199268.4376.50.camel@chaos.site>	 <5319D99A.50003@roeck-us.net> <1394206246.4376.53.camel@chaos.site>	 <20140307172939.GA32353@roeck-us.net> <1394281645.7736.0.camel@chaos.site>
In-Reply-To: <1394281645.7736.0.camel@chaos.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/08/2014 04:27 AM, Jean Delvare wrote:
> Hi Guenter,
>
> Le Friday 07 March 2014 à 09:29 -0800, Guenter Roeck a écrit :
>> On Fri, Mar 07, 2014 at 04:30:46PM +0100, Jean Delvare wrote:
>>> Not sure if it would help. If both the native watchdog driver and the
>>> IPMI watchdog driver get loaded automatically via module aliases, it
>>> will be racy. Only one driver can own /dev/watchdog at any given time,
>>> and the use has to decide which one.
>>
>> At work we are using /dev/watchdog0 and /dev/watchdog1 directly,
>> and don't depend on /dev/watchdog (which maps to /dev/watchdog0).
>> This is actually quite convenient, as it lets us use the two watchdogs
>> to watch each other (I've seen hard system lockups with the mei
>> watchdog and the iTCO watchdog on a couple of systems, so I like to
>> have a backup).
>
> I admit I don't quite understand how watchdogs can "watch each other"?
> Each watchdog is essentially watching the watchdog daemon which is
> periodically writing to it, and assuming that daemon alive == system
> alive, right?
>
Bad terminology. We use two watchdogs in parallel. If oe fails to work,
the other does (hopefully ;-)

> Do you have one daemon writing to both watchdog device nodes? Or two
> daemon instances each writing to one device node?
>
systemd uses one, the watchdog application the other.

> As I understand it, the only benefit of using multiple watchdogs, is if
> the watchdog devices (or their drivers) are not 100% reliable, right?
>
Correct.

>> Sure, if you insist that the ipmi watchdog is tied to /dev/watchdog,
>> no matter what, that is a different issue.
>
> I think that's what the customer wants, yes. That being said, I seem to
> recall that not so long ago (on the enterprise scale) you could only
> have one watchdog driver running at once, right? Multiple watchdog
> support was added with commit 45f5fed3 in kernel v3.5 if I'm not
> mistaken. Only the latest SP of our latest product includes that commit.
> I suppose this is the reason why our customers still stick
> to /dev/watchdog and a single watchdog driver. It might change in the
> future, but probably not before the next major version of our product is
> released and widely deployed.
>
Ok, makes sense, but I think it was much earlier than 3.5.

>> Anyway, in our case it doesn't matter much which watchdog is on
>> which device, because we just use both. But I agree that it would
>> be nice to have an easy way to determine the underlying device
>> from user space (without having to go through the ioctl to get
>> the name).
>
> I just checked on my own laptop with kernel 3.0.101 + lots of backports
> and after boot I see 3 watchdog devices. All virtual so I have no way to
> figure out which driver and physical device is behind
> them. /dev/watchdog goes away if I unload iTCO_wdt, /dev/watchdog2 goes
> away if I unload mei. /dev/watchdog1 is a mystery.
>
> With kernel 3.12.12 + lots of backports, /dev/watchdog1 is owned by
> iTCO_wdt (although sysfs points to driver lpc_ich, as mentioned in a
> previous mail.) /dev/watchdog and /dev/watchdog0 are both owned by
> mei_me, but I had to guess as they are still a virtual devices (one
> misc, one watchdog.)
>
> So there is still some work to get things in good shape. Also this
> confirms that the watchdog device node <-> driver mapping is fragile and
> can change from one kernel version to the next or even across reboot, so
> users shouldn't assume it to be persistent.
>
Just like pretty much everything else ;-). I absolutely agree that it
would be great to have a better means to determine both the driver
and the name of the watchdog.

Guenter

