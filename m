Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56516 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbHERl5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 13:41:57 -0400
Message-ID: <55C24ADF.7010605@roeck-us.net>
Date: Wed, 05 Aug 2015 10:41:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: David Teigland <teigland@redhat.com>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <20150805171349.GA15472@redhat.com>
In-Reply-To: <20150805171349.GA15472@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi David,

On 08/05/2015 10:13 AM, David Teigland wrote:
> On Mon, Aug 03, 2015 at 07:13:26PM -0700, Guenter Roeck wrote:
>> - Some watchdogs have a very short maximum timeout, in the range of just a few
>>    seconds. Such low timeouts are difficult if not impossible to support from
>>    user space. Drivers supporting such watchdog hardware need to implement
>>    a timer function to augment heartbeats from user space.
>
>> - A new status flag, WDOG_RUNNING, informs the watchdog subsystem that a
>>    watchdog is running, and that the watchdog subsystem needs to generate
>>    heartbeat requests while the associated watchdog device is closed.
>
>> Patch #2 adds timer functionality to the watchdog core. It solves the problem
>> of short maximum hardware timeouts by augmenting heartbeats triggered from
>> user space with internally triggered heartbeats.
>>
>> Patch #3 adds functionality to generate heartbeats while the watchdog device is
>> closed. It handles situation where where the watchdog is running after
>> the driver has been instantiated, but the device is not yet opened,
>> and post-close situations necessary if a watchdog can not be stopped.
>
> These sound concerning because it seems that heartbeats could be generated
> outside of the direct control of userspace.  I have a program that depends
> on having direct control over whether heartbeats are generated (or more
> specifically, *not* generated.)  If these new features introduce a new way
> for heartbeats to be generated, is there a way I can detect or disable
> that behavior from userspace?  Unwanted heartbeats could break my program
> and may lead to data corruption.
>

Not really. The heartbeats will be generated such that the watchdog expires
no later that <last heartbeat from userspace + configured timeout>. I discussed
this already with Uwe; he had the same concern. This isn't in the current
version of the patch set, but it will be in the next version. That means
that nothing will change from user space perspective.

> A related issue from some years ago is the unfortunate fact that closing
> the watchdog device also generates a heartbeat.  I'd like to disable that
> also, and submitted a patch for it here:
> http://www.spinics.net/lists/linux-watchdog/msg01477.html
>

That is a different issue, though, and unrelated to this patch set.
Wim had a good point there: Presumably the problem you are trying to solve
applies to the entire system, not to a specific watchdog. What you are looking
for looks more like a system parameter, not like something to set with an ioctl
message. The reason here is that you'd still want to be able to use standard
applications such as systemd or watchdogd to trigger heartbeats, and not depend
on your own.

Thanks,
Guenter

