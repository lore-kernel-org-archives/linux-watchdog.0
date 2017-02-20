Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45614 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdBTKnG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Feb 2017 05:43:06 -0500
Subject: Re: [PATCH] watchdog: softdog: fire watchdog even if softirqs do not
 get to run
To: Peter Zijlstra <peterz@infradead.org>
References: <1487355902-28020-1-git-send-email-niklass@axis.com>
 <697d74e9-a492-f4bf-e09f-3c5c7b5708f3@roeck-us.net>
 <20170220083659.GJ6500@twins.programming.kicks-ass.net>
Cc: Niklas Cassel <niklas.cassel@axis.com>, wim@iguana.be,
        edumazet@google.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, niklass@axis.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <680e3c9c-4798-a1c6-7ca0-9197d6117c42@roeck-us.net>
Date: Mon, 20 Feb 2017 01:02:24 -0800
MIME-Version: 1.0
In-Reply-To: <20170220083659.GJ6500@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/20/2017 12:36 AM, Peter Zijlstra wrote:
> On Sun, Feb 19, 2017 at 08:46:28AM -0800, Guenter Roeck wrote:
>> Cc: Wolfram for input.
>>
>> On 02/17/2017 10:25 AM, Niklas Cassel wrote:
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
>>
>> This makes the driver dependent on HIGH_RES_TIMERS, which is not available
>> on all architectures. Before adding that restriction, I would like to see
>> some discussion if this is the only feasible solution.
>>
>
> It does no such thing; the hrtimer interface is always available.
>

That is good to hear. Thanks for the correction.

Guenter

