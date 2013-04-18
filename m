Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:43555 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967649Ab3DRQfT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Apr 2013 12:35:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org,
	wim@iguana.be, LKML <linux-kernel@vger.kernel.org>,
	vgoyal@redhat.com, dyoung@redhat.com,
	Guenter Roeck <linux@roeck-us.net>
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
Date: Thu, 18 Apr 2013 09:35:05 -0700
In-Reply-To: <1366233596-34681-1-git-send-email-dzickus@redhat.com> (Don
	Zickus's message of "Wed, 17 Apr 2013 17:19:56 -0400")
Message-ID: <87ip3j94qu.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v3] watchdog: Add hook for kicking in kdump path
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

> A common problem with kdump is that during the boot up of the
> second kernel, the hardware watchdog times out and reboots the
> machine before a vmcore can be captured.
>
> Instead of tellling customers to disable their hardware watchdog
> timers, I hacked up a hook to put in the kdump path that provides
> one last kick before jumping into the second kernel.

Having thought about this a little more this patch is actively wrong.

The problem is you can easily be petting the watchdog in violation of
whatever policy is normally in place.  Which means that this extra
petting can result in a system that is unavailable for an unacceptably
long period of time.

I expect most watchdog policies are not that strict, but this patch
would preclude using those that are.

And like is being discussed in another subthread it does look like
changing the timeout and the interval should be enough all on it's own.

Eric
