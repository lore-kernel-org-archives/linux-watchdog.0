Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:52978 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbdB0NH5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 27 Feb 2017 08:07:57 -0500
Subject: Re: watchdog: softdog: fire watchdog even if softirqs do not get to
 run
To: Guenter Roeck <linux@roeck-us.net>
References: <1487355902-28020-1-git-send-email-niklass@axis.com>
 <20170227040425.GA9023@roeck-us.net>
CC: <wim@iguana.be>, <edumazet@google.com>, <peterz@infradead.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <e550bcd0-2628-080a-c04c-f15623055a67@axis.com>
Date: Mon, 27 Feb 2017 13:58:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170227040425.GA9023@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/27/2017 05:04 AM, Guenter Roeck wrote:
> On Fri, Feb 17, 2017 at 07:25:02PM +0100, Niklas Cassel wrote:
>> From: Niklas Cassel <niklas.cassel@axis.com>
>>
>> Checking for timer expiration is done from the softirq TIMER_SOFTIRQ.
>>
>> Since commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job"),
>> pending softirqs are no longer always handled immediately, instead,
>> if there are pending softirqs, and ksoftirqd is in state TASK_RUNNING,
>> the handling of the softirqs are deferred, and are instead supposed
>> to be handled by ksoftirqd, when ksoftirqd gets scheduled.
>>
>> If a user space process with a real-time policy starts to misbehave
>> by never relinquishing the CPU while ksoftirqd is in state TASK_RUNNING,
>> what will happen is that all softirqs will get deferred, while ksoftirqd,
>> which is supposed to handle the deferred softirqs, will never get to run.
>>
>> To make sure that the watchdog is able to fire even when we do not get
>> to run softirqs, replace the timers with hrtimers.
>>
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Niklas,
>
> Please rebase onto current mainline, test, and resubmit.

I've sent out a v2 now :)

Although, I thought that it was a bit weird that the conflicting patch
was in Linus tree but is not in next-20170227.

I'm not sure if you are the web master for www.linux-watchdog.org,
but their cgit seems to be broken:
http://www.linux-watchdog.org/cgi-bin/gitweb.cgi?p=linux-watchdog.git;a=summary
http://www.linux-watchdog.org/cgi-bin/gitweb.cgi?p=linux-watchdog-next.git;a=summary


>
> Thanks,
> Guenter
>
