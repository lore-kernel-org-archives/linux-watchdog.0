Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170130165359.GA20288@roeck-us.net>
References: <1485312289-18354-1-git-send-email-baoyou.xie@linaro.org>
 <1485312289-18354-3-git-send-email-baoyou.xie@linaro.org> <20170125162346.GA591@linaro.org>
 <CA+DQWkxpcHqVfDSGuUK-i4DOVXsYEYo60MG5y_oBDNp+ykEdLQ@mail.gmail.com>
 <20170126161729.GA1515@linaro.org> <CA+DQWkyPtndGEz-QYvmKaXoGNKQ69Zqu-aG7tCKnT-Mrmx5Wsw@mail.gmail.com>
 <20170130165359.GA20288@roeck-us.net>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Wed, 1 Feb 2017 11:29:15 +0800
Message-ID: <CA+DQWkyfgx7U4GPkCKhg0zCyOkAT3z3pRU57uu6ccZSZG5d8mA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, Jun Nie <jun.nie@linaro.org>, wim@iguana.be,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a1144ca223fce0305476fa7f3
List-ID: <linux-watchdog@vger.kernel.org>

--001a1144ca223fce0305476fa7f3
Content-Type: text/plain; charset=UTF-8

On 31 January 2017 at 00:53, Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Jan 27, 2017 at 10:40:09AM +0800, Baoyou Xie wrote:
> > On 27 January 2017 at 00:17, Mathieu Poirier <mathieu.poirier@linaro.org
> >
> > wrote:
> >
> > > On Thu, Jan 26, 2017 at 09:32:56AM +0800, Baoyou Xie wrote:
> > > > On 26 January 2017 at 00:23, Mathieu Poirier <
> mathieu.poirier@linaro.org
> > > >
> > > > wrote:
> > > >
> > > > > On Wed, Jan 25, 2017 at 10:44:49AM +0800, Baoyou Xie wrote:
> > > > > > This patch adds watchdog controller driver for ZTE's zx2967
> family.
> > > > > >
> > > > > > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > > > > > ---
> [ ... ]
> > > > > > +     reset_control_assert(rstc);
> > > > > > +     usleep_range(500, 20000);
> > > > >
> > > > > Alright, I'm officially confused.
> > > > >
> > > > > First and foremost you still haven't provided an explanation as to
> why
> > > > > this is
> > > > > required.  Second, in your previous submission you had:
> > > > >
> > > > >         mdelay(10);
> > > > >
> > > > > That is a busy loop of 10ms.  In this post using usleep_range() is
> a
> > > step
> > > > > in the
> > > > > right direction but the min and max values to wait for don't make
> > > sense.
> > > > > Here
> > > > > you have 500 and 20000, which is 0.5ms and 20ms.
> > > > >
> > > > > In fact, sleeping for 0.5ms is enough.
> > > > we extended the sleeping time to 20ms, the purpose is merging the
> timer
> > > > interrupts. of course, it's happy to replace it with
> usleep_range(500,
> > > > 1000).
> > >
> > > "merging the timer interrupts" - you mean trying to get the WD tick to
> be
> > > closer
> > > to other timers?  If so I really don't see why.  Timers are
> asynchronous by
> > > nature and there can be dozens of them enabled at any given time.
> > >
> > > Really?
> > Even if the system runs asynchronously, early process may trigger delayed
> > process, for example delayed work queue or timers, we can merge our
> > watchdog timer and those delayed work's timers.
> >
> In the probe function ?
>
> > Furthermore, what happen if we build this driver as module?
> >
> If every driver writer would use that line of argument, booting would
> take much longer than necessary, with every process sitting on unnecessary
> wait or sleep calls for perceived "optimization" purposes. Probe functions
> run exactly once, and should be time optimized. You should have an idea
> what the minimum reset hold time is, and follow it.
>
> > But, as i said early, it's a trial optimization but can be instead with
> > usleep_range(500, 1000).
> >
> > In some case, such optimization is helpful. I'd like to talk a story
> here,
> > about before ten years, I pressed a return key in console, you know, in
> > this case, a process be created and exited, so the cpu core that process
> > run at sent an IPI to other CPU, IPI interrupt resulted in the
> performance
> > decreased by 20%, so sad:)
> >
> It appears to be somewhat unlikely that each keypress resulted in a driver
> being instantiated. If it did, a sleep in its probe function was the least
> of your problems.
>
> > Unless there is a H/W constraint requiring a delay between the
> > > assert/deassert
> > > of the WD, I don't think adding a wait operation (of any kind) make
> sense.
>
> Correct.
>
>
I have discussed with hardware and reset driver engineers, It's better to
place usleep_range call into reset driver, so we're happy to remove
usleep_range
here.

So, I will send a new patch that remove it.


> Guenter
>

--001a1144ca223fce0305476fa7f3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 31 January 2017 at 00:53, Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span =
class=3D"gmail-">On Fri, Jan 27, 2017 at 10:40:09AM +0800, Baoyou Xie wrote=
:<br>
&gt; On 27 January 2017 at 00:17, Mathieu Poirier &lt;<a href=3D"mailto:mat=
hieu.poirier@linaro.org">mathieu.poirier@linaro.org</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Thu, Jan 26, 2017 at 09:32:56AM +0800, Baoyou Xie wrote:<br>
&gt; &gt; &gt; On 26 January 2017 at 00:23, Mathieu Poirier &lt;<a href=3D"=
mailto:mathieu.poirier@linaro.org">mathieu.poirier@linaro.org</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Wed, Jan 25, 2017 at 10:44:49AM +0800, Baoyou Xie wr=
ote:<br>
&gt; &gt; &gt; &gt; &gt; This patch adds watchdog controller driver for ZTE=
&#39;s zx2967 family.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Baoyou Xie &lt;<a href=3D"mailto:ba=
oyou.xie@linaro.org">baoyou.xie@linaro.org</a>&gt;<br>
&gt; &gt; &gt; &gt; &gt; ---<br>
</span>[ ... ]<br>
<div><div class=3D"gmail-h5">&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0=
reset_control_assert(rstc);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0usleep_range(500, 20000);<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Alright, I&#39;m officially confused.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; First and foremost you still haven&#39;t provided an ex=
planation as to why<br>
&gt; &gt; &gt; &gt; this is<br>
&gt; &gt; &gt; &gt; required.=C2=A0 Second, in your previous submission you=
 had:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(10);<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; That is a busy loop of 10ms.=C2=A0 In this post using u=
sleep_range() is a<br>
&gt; &gt; step<br>
&gt; &gt; &gt; &gt; in the<br>
&gt; &gt; &gt; &gt; right direction but the min and max values to wait for =
don&#39;t make<br>
&gt; &gt; sense.<br>
&gt; &gt; &gt; &gt; Here<br>
&gt; &gt; &gt; &gt; you have 500 and 20000, which is 0.5ms and 20ms.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; In fact, sleeping for 0.5ms is enough.<br>
&gt; &gt; &gt; we extended the sleeping time to 20ms, the purpose is mergin=
g the timer<br>
&gt; &gt; &gt; interrupts. of course, it&#39;s happy to replace it with usl=
eep_range(500,<br>
&gt; &gt; &gt; 1000).<br>
&gt; &gt;<br>
&gt; &gt; &quot;merging the timer interrupts&quot; - you mean trying to get=
 the WD tick to be<br>
&gt; &gt; closer<br>
&gt; &gt; to other timers?=C2=A0 If so I really don&#39;t see why.=C2=A0 Ti=
mers are asynchronous by<br>
&gt; &gt; nature and there can be dozens of them enabled at any given time.=
<br>
&gt; &gt;<br>
&gt; &gt; Really?<br>
&gt; Even if the system runs asynchronously, early process may trigger dela=
yed<br>
&gt; process, for example delayed work queue or timers, we can merge our<br=
>
&gt; watchdog timer and those delayed work&#39;s timers.<br>
&gt;<br>
</div></div>In the probe function ?<br>
<span class=3D"gmail-"><br>
&gt; Furthermore, what happen if we build this driver as module?<br>
&gt;<br>
</span>If every driver writer would use that line of argument, booting woul=
d<br>
take much longer than necessary, with every process sitting on unnecessary<=
br>
wait or sleep calls for perceived &quot;optimization&quot; purposes. Probe =
functions<br>
run exactly once, and should be time optimized. You should have an idea<br>
what the minimum reset hold time is, and follow it.<br>
<span class=3D"gmail-"><br>
&gt; But, as i said early, it&#39;s a trial optimization but can be instead=
 with<br>
&gt; usleep_range(500, 1000).<br>
&gt;<br>
&gt; In some case, such optimization is helpful. I&#39;d like to talk a sto=
ry here,<br>
&gt; about before ten years, I pressed a return key in console, you know, i=
n<br>
&gt; this case, a process be created and exited, so the cpu core that proce=
ss<br>
&gt; run at sent an IPI to other CPU, IPI interrupt resulted in the perform=
ance<br>
&gt; decreased by 20%, so sad:)<br>
&gt;<br>
</span>It appears to be somewhat unlikely that each keypress resulted in a =
driver<br>
being instantiated. If it did, a sleep in its probe function was the least<=
br>
of your problems.<br>
<span class=3D"gmail-"><br>
&gt; Unless there is a H/W constraint requiring a delay between the<br>
&gt; &gt; assert/deassert<br>
&gt; &gt; of the WD, I don&#39;t think adding a wait operation (of any kind=
) make sense.<br>
<br>
</span>Correct.<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div>=C2=A0</div><div>I have discussed with hardware and reset dri=
ver engineers, It&#39;s better to place <span class=3D"gmail-">usleep_range=
 call</span> into reset driver, so we&#39;re happy to remove <span class=3D=
"gmail-">usleep_range here.<br><br></span>So, I will send a new patch that =
remove it. <br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><span class=3D"gmail-HOEnZb"><font color=3D"#888888">
Guenter<br>
</font></span></blockquote></div><br></div></div>

--001a1144ca223fce0305476fa7f3--
