Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43456 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbHETBo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 15:01:44 -0400
Message-ID: <55C25D92.8020609@roeck-us.net>
Date: Wed, 05 Aug 2015 12:01:38 -0700
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
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <20150805171349.GA15472@redhat.com> <55C24ADF.7010605@roeck-us.net> <20150805175158.GB15472@redhat.com>
In-Reply-To: <20150805175158.GB15472@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi David,

On 08/05/2015 10:51 AM, David Teigland wrote:
> On Wed, Aug 05, 2015 at 10:41:51AM -0700, Guenter Roeck wrote:
>> Not really. The heartbeats will be generated such that the watchdog expires
>> no later that <last heartbeat from userspace + configured timeout>. I discussed
>> this already with Uwe; he had the same concern. This isn't in the current
>> version of the patch set, but it will be in the next version. That means
>> that nothing will change from user space perspective.
>
> Sounds good, thanks.
>
>>> A related issue from some years ago is the unfortunate fact that closing
>>> the watchdog device also generates a heartbeat.  I'd like to disable that
>>> also, and submitted a patch for it here:
>>> http://www.spinics.net/lists/linux-watchdog/msg01477.html
>>>
>>
>> That is a different issue, though, and unrelated to this patch set.
>> Wim had a good point there: Presumably the problem you are trying to solve
>> applies to the entire system, not to a specific watchdog. What you are looking
>> for looks more like a system parameter, not like something to set with an ioctl
>> message. The reason here is that you'd still want to be able to use standard
>> applications such as systemd or watchdogd to trigger heartbeats, and not depend
>> on your own.
>
> I'd need this behavior when the system is running my program (sanlock with
> wdmd), which uses /dev/watchdog.  No other programs (systemd or watchdogd)
> could be using /dev/watchdog at the same time.
>

I think I can understand why Wim was reluctant to accept your patch;
I must admit I don't understand your use case either.

I wonder if you are actually mis-using the watchdog subsystem to generate
hard resets. After all, you could avoid the unexpected close situation with
an exit handler in your application. That handler could catch anything but
SIGKILL, but anyone using SIGKILL doesn't really deserve better. If the intent
is to reset the system after the application closes, executing "/sbin/restart -f"
might be a safer approach than just killing the watchdog.

In addition to that, I don't think it is a good idea to rely on the assumption
that the watchdog will expire exactly after the configured timeout.
Many watchdog drivers implement a soft timeout on top of the hardware timeout,
and thus already implement the internal heartbeat. Most of those drivers
will stop sending internal heartbeats if user space did not send a heartbeat
within the configured timeout period. The actual reset will then occur later,
after the actual hardware watchdog timed out. This can be as much as the
hardware timeout period, which may be substantial.

Thanks,
Guenter

