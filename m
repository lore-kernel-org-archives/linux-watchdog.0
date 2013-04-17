Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:49008 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965345Ab3DQVuP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Apr 2013 17:50:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org,
	wim@iguana.be, LKML <linux-kernel@vger.kernel.org>,
	vgoyal@redhat.com, dyoung@redhat.com, linux@roeck-us.net
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
Date: Wed, 17 Apr 2013 14:49:59 -0700
In-Reply-To: <1366233596-34681-1-git-send-email-dzickus@redhat.com> (Don
	Zickus's message of "Wed, 17 Apr 2013 17:19:56 -0400")
Message-ID: <87li8gaku0.fsf@xmission.com>
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
>
> The assumption is the watchdog timeout is at least 10-30 seconds
> long, enough to get the second kernel to userspace to kick the watchdog
> again, if needed.

Why not double the watchdog timeout? and/or pet the watchdog a little
more frequently.

This is the least icky hook I have seen proposed to be put on the kexec
on panic path, but I still suspect this may reduce the ability to take a
crash dump.  What happens if it was the watchdog timer that panic'd for
example.

Eric
