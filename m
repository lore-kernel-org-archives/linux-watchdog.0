Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48577 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753872AbdA3QyN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 30 Jan 2017 11:54:13 -0500
Date: Mon, 30 Jan 2017 08:53:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, wim@iguana.be,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
Subject: Re: [PATCH v6 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
Message-ID: <20170130165359.GA20288@roeck-us.net>
References: <1485312289-18354-1-git-send-email-baoyou.xie@linaro.org>
 <1485312289-18354-3-git-send-email-baoyou.xie@linaro.org>
 <20170125162346.GA591@linaro.org>
 <CA+DQWkxpcHqVfDSGuUK-i4DOVXsYEYo60MG5y_oBDNp+ykEdLQ@mail.gmail.com>
 <20170126161729.GA1515@linaro.org>
 <CA+DQWkyPtndGEz-QYvmKaXoGNKQ69Zqu-aG7tCKnT-Mrmx5Wsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DQWkyPtndGEz-QYvmKaXoGNKQ69Zqu-aG7tCKnT-Mrmx5Wsw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 27, 2017 at 10:40:09AM +0800, Baoyou Xie wrote:
> On 27 January 2017 at 00:17, Mathieu Poirier <mathieu.poirier@linaro.org>
> wrote:
> 
> > On Thu, Jan 26, 2017 at 09:32:56AM +0800, Baoyou Xie wrote:
> > > On 26 January 2017 at 00:23, Mathieu Poirier <mathieu.poirier@linaro.org
> > >
> > > wrote:
> > >
> > > > On Wed, Jan 25, 2017 at 10:44:49AM +0800, Baoyou Xie wrote:
> > > > > This patch adds watchdog controller driver for ZTE's zx2967 family.
> > > > >
> > > > > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > > > > ---
[ ... ]
> > > > > +     reset_control_assert(rstc);
> > > > > +     usleep_range(500, 20000);
> > > >
> > > > Alright, I'm officially confused.
> > > >
> > > > First and foremost you still haven't provided an explanation as to why
> > > > this is
> > > > required.  Second, in your previous submission you had:
> > > >
> > > >         mdelay(10);
> > > >
> > > > That is a busy loop of 10ms.  In this post using usleep_range() is a
> > step
> > > > in the
> > > > right direction but the min and max values to wait for don't make
> > sense.
> > > > Here
> > > > you have 500 and 20000, which is 0.5ms and 20ms.
> > > >
> > > > In fact, sleeping for 0.5ms is enough.
> > > we extended the sleeping time to 20ms, the purpose is merging the timer
> > > interrupts. of course, it's happy to replace it with usleep_range(500,
> > > 1000).
> >
> > "merging the timer interrupts" - you mean trying to get the WD tick to be
> > closer
> > to other timers?  If so I really don't see why.  Timers are asynchronous by
> > nature and there can be dozens of them enabled at any given time.
> >
> > Really?
> Even if the system runs asynchronously, early process may trigger delayed
> process, for example delayed work queue or timers, we can merge our
> watchdog timer and those delayed work's timers.
> 
In the probe function ?

> Furthermore, what happen if we build this driver as module?
> 
If every driver writer would use that line of argument, booting would
take much longer than necessary, with every process sitting on unnecessary
wait or sleep calls for perceived "optimization" purposes. Probe functions
run exactly once, and should be time optimized. You should have an idea
what the minimum reset hold time is, and follow it.

> But, as i said early, it's a trial optimization but can be instead with
> usleep_range(500, 1000).
> 
> In some case, such optimization is helpful. I'd like to talk a story here,
> about before ten years, I pressed a return key in console, you know, in
> this case, a process be created and exited, so the cpu core that process
> run at sent an IPI to other CPU, IPI interrupt resulted in the performance
> decreased by 20%, so sad:)
> 
It appears to be somewhat unlikely that each keypress resulted in a driver
being instantiated. If it did, a sleep in its probe function was the least
of your problems.

> Unless there is a H/W constraint requiring a delay between the
> > assert/deassert
> > of the WD, I don't think adding a wait operation (of any kind) make sense.

Correct.

Guenter
