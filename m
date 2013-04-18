Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:36073 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab3DRSJm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Apr 2013 14:09:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org,
	wim@iguana.be, LKML <linux-kernel@vger.kernel.org>,
	vgoyal@redhat.com, dyoung@redhat.com,
	Guenter Roeck <linux@roeck-us.net>
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
	<87ip3j94qu.fsf@xmission.com> <20130418174432.GN79013@redhat.com>
Date: Thu, 18 Apr 2013 11:09:29 -0700
In-Reply-To: <20130418174432.GN79013@redhat.com> (Don Zickus's message of
	"Thu, 18 Apr 2013 13:44:32 -0400")
Message-ID: <87ehe77lt2.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v3] watchdog: Add hook for kicking in kdump path
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

> On Thu, Apr 18, 2013 at 09:35:05AM -0700, Eric W. Biederman wrote:
>> Don Zickus <dzickus@redhat.com> writes:
>> 
>> > A common problem with kdump is that during the boot up of the
>> > second kernel, the hardware watchdog times out and reboots the
>> > machine before a vmcore can be captured.
>> >
>> > Instead of tellling customers to disable their hardware watchdog
>> > timers, I hacked up a hook to put in the kdump path that provides
>> > one last kick before jumping into the second kernel.
>> 
>> Having thought about this a little more this patch is actively wrong.
>> 
>> The problem is you can easily be petting the watchdog in violation of
>> whatever policy is normally in place.  Which means that this extra
>> petting can result in a system that is unavailable for an unacceptably
>> long period of time.
>
> Not really, just an extra period which isn't that much.  This would only
> be noticable if kdump is setup and enabled and then _hung_, otherwise it
> just quickly reboots and noone notices. :-)

For the folks who care the definition of acceptable unavailability would
look like: watchdog timeout + max boot time + margin of error.  So it
is possible for an extra watchdog pet to eat up or exceed your margin
of error.

You are more likely to cause a how in the world did that happen than
something more extreme, but even playing invalidating peoples mental
model can be a problem sometimes.

>> I expect most watchdog policies are not that strict, but this patch
>> would preclude using those that are.
>
> I would assume most of those users would not enable kdump and would not be
> affected.

I have seen it be the case that the goal is to record what went wrong
if there is time, but to get back into service in a timely manner
regardless.

>> And like is being discussed in another subthread it does look like
>> changing the timeout and the interval should be enough all on it's own.
>
> Probably and I will pursue that.  Thanks for the suggestion.

Eric

