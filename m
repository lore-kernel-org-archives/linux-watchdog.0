Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49308 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcBFQme (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Feb 2016 11:42:34 -0500
Subject: Re: [RFC 4/4] watchdog: ni9x3x_wdt: Let user control watchdog mode
To: Kyle Roeschley <kyle.roeschley@ni.com>,
	Josh Cartwright <joshc@ni.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-4-git-send-email-kyle.roeschley@ni.com>
 <20160205202720.GD9579@jcartwri.amer.corp.natinst.com>
 <20160205210328.GB11390@senary>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56B62278.1020508@roeck-us.net>
Date: Sat, 6 Feb 2016 08:42:32 -0800
MIME-Version: 1.0
In-Reply-To: <20160205210328.GB11390@senary>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/05/2016 01:03 PM, Kyle Roeschley wrote:
> On Fri, Feb 05, 2016 at 02:27:20PM -0600, Josh Cartwright wrote:
>> On Thu, Feb 04, 2016 at 07:28:03PM -0600, Kyle Roeschley wrote:
>>> When first powering on, the NI 903x/913x watchdog starts in boot mode.
>>> If not switched from boot mode to user mode within 30 seconds of power
>>> on, the device status LED indicates an unrecoverable error. While before
>>> this was handled automatically, now add a module parameter to disable
>>> this behavior.
>>>
>>> In order to still have a useful watchdog, also add a R/W sysfs attribute
>>> `mode' which can be used to switch the watchdog mode from boot to user
>>> mode (but not user to boot mode).
>>
>> Hmm.  Instead of an attribute, why don't we just ensure the watchdog is
>> in "user" mode in start()?
>>
>>    Josh
>
> Seems like a good idea, except for the fact that we then lose a way to query
> the current watchdog mode. Maybe we could only enable the `mode' attribute
> (and possibly make it read-only) when auto_mode_switch is set to false?

If the system is still running after 30 seconds, it is in user mode.
So your query would have to be pretty quick. If you want to know if the
watchdog is running, which might be more important for the user,
you could check the 'state' attribute instead.

Guenter

