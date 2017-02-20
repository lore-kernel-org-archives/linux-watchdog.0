Return-path: <edumazet@google.com>
MIME-Version: 1.0
In-Reply-To: <fa656ab6-31a2-1f46-0fd0-12d05f226a96@axis.com>
References: <1487355902-28020-1-git-send-email-niklass@axis.com>
 <697d74e9-a492-f4bf-e09f-3c5c7b5708f3@roeck-us.net> <fa656ab6-31a2-1f46-0fd0-12d05f226a96@axis.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Feb 2017 07:22:49 -0800
Message-ID: <CANn89iL+i=Zxh3gVk9zwJh=+T+RMsH542NA0myn50EwkgPRxDw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: softdog: fire watchdog even if softirqs do not
 get to run
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be,
	Peter Zijlstra <peterz@infradead.org>, linux-watchdog@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: multipart/alternative; boundary=001a11439ad41e380f0548f7d660
List-ID: <linux-watchdog@vger.kernel.org>

--001a11439ad41e380f0548f7d660
Content-Type: text/plain; charset=UTF-8

On Mon, Feb 20, 2017 at 2:03 AM, Niklas Cassel <niklas.cassel@axis.com>
wrote:

> On 02/19/2017 05:46 PM, Guenter Roeck wrote:
> > Cc: Wolfram for input.
> >
> > On 02/17/2017 10:25 AM, Niklas Cassel wrote:
> >> From: Niklas Cassel <niklas.cassel@axis.com>
> >>
> >> Checking for timer expiration is done from the softirq TIMER_SOFTIRQ.
> >>
> >> Since commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job"),
> >> pending softirqs are no longer always handled immediately, instead,
> >> if there are pending softirqs, and ksoftirqd is in state TASK_RUNNING,
> >> the handling of the softirqs are deferred, and are instead supposed
> >> to be handled by ksoftirqd, when ksoftirqd gets scheduled.
> >>
> >> If a user space process with a real-time policy starts to misbehave
> >> by never relinquishing the CPU while ksoftirqd is in state TASK_RUNNING,
> >> what will happen is that all softirqs will get deferred, while
> ksoftirqd,
> >> which is supposed to handle the deferred softirqs, will never get to
> run.
> >>
> >> To make sure that the watchdog is able to fire even when we do not get
> >> to run softirqs, replace the timers with hrtimers.
> >>
> >
> > This makes the driver dependent on HIGH_RES_TIMERS, which is not
> available
> > on all architectures. Before adding that restriction, I would like to see
> > some discussion if this is the only feasible solution.
> >
> > Is this driver the only one with this problem, or is anything using
> > timers affected ?
>
> Anything using timers is affected.
> The timers will still get incremented, but the code checking for timer
> expiration is run from a softirq, which in this case never gets to run,
> so the timers will never expire.
>
> Before 4cd13c21b207 ("softirq: Let ksoftirqd do its job"), softirqs
> were never deferred, so they always got to run when exiting an irq.
>
> So previously with a user space process using all the CPU, like:
> chrt -r 99 sh -c "while :; do :; done"
> the softdog would still fire.
>
>
So the question is :

If some RT process does an infinite loop, should we care about system being
functional ?

Looks like the OS is now WAI (Working As Intended)



> If we ask the system to run something all the time,
> and the system does that, I don't think we can blame the system.
> It is however important that the watchdog can still detect and
> fire when this happens. Other drivers, not so much.
>
> I guess another solution would be to modify the if-statements in
> kernel/softirq.c to sometimes do the softirq directly, even if ksoftirqd
> is in state TASK_RUNNING, if we also meet some other condition.
> However, do we want to add that extra complexity?
> Perhaps someone with more softirq/scheduler knowledge can give
> some input on this.
>

--001a11439ad41e380f0548f7d660
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Feb 20, 2017 at 2:03 AM, Niklas Cassel <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:niklas.cassel@axis.com" target=3D"_blank">niklas.cassel@axi=
s.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On 02/19/2017 05:46 PM, Guenter Roeck wrote:<br>
&gt; Cc: Wolfram for input.<br>
&gt;<br>
&gt; On 02/17/2017 10:25 AM, Niklas Cassel wrote:<br>
&gt;&gt; From: Niklas Cassel &lt;<a href=3D"mailto:niklas.cassel@axis.com">=
niklas.cassel@axis.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Checking for timer expiration is done from the softirq TIMER_SOFTI=
RQ.<br>
&gt;&gt;<br>
&gt;&gt; Since commit 4cd13c21b207 (&quot;softirq: Let ksoftirqd do its job=
&quot;),<br>
&gt;&gt; pending softirqs are no longer always handled immediately, instead=
,<br>
&gt;&gt; if there are pending softirqs, and ksoftirqd is in state TASK_RUNN=
ING,<br>
&gt;&gt; the handling of the softirqs are deferred, and are instead suppose=
d<br>
&gt;&gt; to be handled by ksoftirqd, when ksoftirqd gets scheduled.<br>
&gt;&gt;<br>
&gt;&gt; If a user space process with a real-time policy starts to misbehav=
e<br>
&gt;&gt; by never relinquishing the CPU while ksoftirqd is in state TASK_RU=
NNING,<br>
&gt;&gt; what will happen is that all softirqs will get deferred, while kso=
ftirqd,<br>
&gt;&gt; which is supposed to handle the deferred softirqs, will never get =
to run.<br>
&gt;&gt;<br>
&gt;&gt; To make sure that the watchdog is able to fire even when we do not=
 get<br>
&gt;&gt; to run softirqs, replace the timers with hrtimers.<br>
&gt;&gt;<br>
&gt;<br>
&gt; This makes the driver dependent on HIGH_RES_TIMERS, which is not avail=
able<br>
&gt; on all architectures. Before adding that restriction, I would like to =
see<br>
&gt; some discussion if this is the only feasible solution.<br>
&gt;<br>
&gt; Is this driver the only one with this problem, or is anything using<br=
>
&gt; timers affected ?<br>
<br>
</span>Anything using timers is affected.<br>
The timers will still get incremented, but the code checking for timer<br>
expiration is run from a softirq, which in this case never gets to run,<br>
so the timers will never expire.<br>
<br>
Before 4cd13c21b207 (&quot;softirq: Let ksoftirqd do its job&quot;), softir=
qs<br>
were never deferred, so they always got to run when exiting an irq.<br>
<br>
So previously with a user space process using all the CPU, like:<br>
chrt -r 99 sh -c &quot;while :; do :; done&quot;<br>
the softdog would still fire.<br>
<br></blockquote><div><br></div><div>So the question is :</div><div><br></d=
iv><div>If some RT process does an infinite loop, should we care about syst=
em being functional ?</div><div><br></div><div>Looks like the OS is now WAI=
 (Working As Intended)</div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
If we ask the system to run something all the time,<br>
and the system does that, I don&#39;t think we can blame the system.<br>
It is however important that the watchdog can still detect and<br>
fire when this happens. Other drivers, not so much.<br>
<br>
I guess another solution would be to modify the if-statements in<br>
kernel/softirq.c to sometimes do the softirq directly, even if ksoftirqd<br=
>
is in state TASK_RUNNING, if we also meet some other condition.<br>
However, do we want to add that extra complexity?<br>
Perhaps someone with more softirq/scheduler knowledge can give<br>
some input on this.<br>
</blockquote></div><br></div></div>

--001a11439ad41e380f0548f7d660--
