Return-path: <niklas.cassel@axis.com>
Subject: Re: [PATCH] watchdog: softdog: fire watchdog even if softirqs do not
 get to run
To: Guenter Roeck <linux@roeck-us.net>, <wim@iguana.be>,
	<edumazet@google.com>, <peterz@infradead.org>
References: <1487355902-28020-1-git-send-email-niklass@axis.com>
 <697d74e9-a492-f4bf-e09f-3c5c7b5708f3@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Wolfram
 Sang <wsa+renesas@sang-engineering.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <fa656ab6-31a2-1f46-0fd0-12d05f226a96@axis.com>
Date: Mon, 20 Feb 2017 11:03:57 +0100
MIME-Version: 1.0
In-Reply-To: <697d74e9-a492-f4bf-e09f-3c5c7b5708f3@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 02/19/2017 05:46 PM, Guenter Roeck wrote:
> Cc: Wolfram for input.
>
> On 02/17/2017 10:25 AM, Niklas Cassel wrote:
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
>
> This makes the driver dependent on HIGH_RES_TIMERS, which is not available
> on all architectures. Before adding that restriction, I would like to see
> some discussion if this is the only feasible solution.
>
> Is this driver the only one with this problem, or is anything using
> timers affected ?

Anything using timers is affected.
The timers will still get incremented, but the code checking for timer
expiration is run from a softirq, which in this case never gets to run,
so the timers will never expire.

Before 4cd13c21b207 ("softirq: Let ksoftirqd do its job"), softirqs
were never deferred, so they always got to run when exiting an irq.

So previously with a user space process using all the CPU, like:
chrt -r 99 sh -c "while :; do :; done"
the softdog would still fire.

If we ask the system to run something all the time,
and the system does that, I don't think we can blame the system.
It is however important that the watchdog can still detect and
fire when this happens. Other drivers, not so much.

I guess another solution would be to modify the if-statements in
kernel/softirq.c to sometimes do the softirq directly, even if ksoftirqd
is in state TASK_RUNNING, if we also meet some other condition.
However, do we want to add that extra complexity?
Perhaps someone with more softirq/scheduler knowledge can give
some input on this.
