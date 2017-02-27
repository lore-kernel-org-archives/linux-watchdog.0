Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35253 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbdB0OcJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 27 Feb 2017 09:32:09 -0500
Subject: Re: watchdog: softdog: fire watchdog even if softirqs do not get to
 run
To: Niklas Cassel <niklas.cassel@axis.com>
References: <1487355902-28020-1-git-send-email-niklass@axis.com>
 <20170227040425.GA9023@roeck-us.net>
 <e550bcd0-2628-080a-c04c-f15623055a67@axis.com>
Cc: wim@iguana.be, edumazet@google.com, peterz@infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ca40e1a7-e1cc-07f0-f8f4-d020cf36b1e8@roeck-us.net>
Date: Mon, 27 Feb 2017 06:31:12 -0800
MIME-Version: 1.0
In-Reply-To: <e550bcd0-2628-080a-c04c-f15623055a67@axis.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/27/2017 04:58 AM, Niklas Cassel wrote:
> On 02/27/2017 05:04 AM, Guenter Roeck wrote:
>> On Fri, Feb 17, 2017 at 07:25:02PM +0100, Niklas Cassel wrote:
>>> From: Niklas Cassel <niklas.cassel@axis.com>
>>>
>>> Checking for timer expiration is done from the softirq TIMER_SOFTIRQ.
>>>
>>> Since commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job"),
>>> pending softirqs are no longer always handled immediately, instead,
>>> if there are pending softirqs, and ksoftirqd is in state TASK_RUNNING,
>>> the handling of the softirqs are deferred, and are instead supposed
>>> to be handled by ksoftirqd, when ksoftirqd gets scheduled.
>>>
>>> If a user space process with a real-time policy starts to misbehave
>>> by never relinquishing the CPU while ksoftirqd is in state TASK_RUNNING,
>>> what will happen is that all softirqs will get deferred, while ksoftirqd,
>>> which is supposed to handle the deferred softirqs, will never get to run.
>>>
>>> To make sure that the watchdog is able to fire even when we do not get
>>> to run softirqs, replace the timers with hrtimers.
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Niklas,
>>
>> Please rebase onto current mainline, test, and resubmit.
>
> I've sent out a v2 now :)
>
> Although, I thought that it was a bit weird that the conflicting patch
> was in Linus tree but is not in next-20170227.
>
It was in the watchdog-next branch of my repository at kernel.org,
which is not in -next. I'll have to sort that out with Wim at some point.

> I'm not sure if you are the web master for www.linux-watchdog.org,
> but their cgit seems to be broken:
> http://www.linux-watchdog.org/cgi-bin/gitweb.cgi?p=linux-watchdog.git;a=summary
> http://www.linux-watchdog.org/cgi-bin/gitweb.cgi?p=linux-watchdog-next.git;a=summary
>
Wim knows about it, and plans to replace the server.

Guenter

