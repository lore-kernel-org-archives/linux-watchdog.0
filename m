Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39322 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947587AbdDYVFa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 25 Apr 2017 17:05:30 -0400
Date: Tue, 25 Apr 2017 14:05:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        linux-watchdog@vger.kernel.org, wim@iguana.be,
        a.zummo@towertech.it, rtc-linux@googlegroups.com,
        alex.williams@ni.com
Subject: Re: [PATCH 0/2] DS1374 Watchdog fixes
Message-ID: <20170425210526.GA1629@roeck-us.net>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
 <5f8fac22-4037-9983-436a-da8ff87d4b17@roeck-us.net>
 <CAJYdmeP+XEBPpUECO1rWpRDs-RVihc_va970jtv6iau3OuWMWA@mail.gmail.com>
 <20170425161743.GA8443@roeck-us.net>
 <20170425163204.rj6on6phtbfuvcd7@piout.net>
 <20170425165824.GA10024@roeck-us.net>
 <CAJYdmePpHcYgjiCf=eWCkBBNBTTw4jW59_VNR6w44Yj_QDQqng@mail.gmail.com>
 <20170425202210.GA20929@roeck-us.net>
 <20170425203418.GA5198@tyrael.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425203418.GA5198@tyrael.amer.corp.natinst.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 25, 2017 at 01:34:18PM -0700, Moritz Fischer wrote:
> On Tue, Apr 25, 2017 at 01:22:10PM -0700, Guenter Roeck wrote:
> > On Tue, Apr 25, 2017 at 12:58:36PM -0700, Moritz Fischer wrote:
> > > On Tue, Apr 25, 2017 at 09:58:24AM -0700, Guenter Roeck wrote:
> > > 
> > > > Ah, I missed the "n" in various #ifndef statements.
> > > >
> > > > I can't really comment on how to solve that; I simply don't know.
> > > > Also, even with a dt property, it still would be necessary to have
> > > > a non-DT means to configure one or the other. Making whatever solution
> > > > backward compatible also seems tricky; I don't have a solution for that
> > > > problem either.
> > > 
> > > How does one do these things in a non-dt context? Platform data? I'd let
> > 
> > Platform data is out of favor. You'd probably want to use device properties
> > (see drivers/base/property.c). Question though is if this is considered
> > configuration, hardware description, or both. Presumably the watchdog
> > only makes sense if the reset signal is wired, and the alarm only makes
> > sense if the interrupt is wired, but what if both are wired ?
> 
> To make things worse you can even remap the reset output to the INT pin
> (which my platform does).
> 

So that is what the weird 250ms "interrupt signal" is for. I had wondered
what that is supposed to be used for.

> I'll look at device properties. Thanks for the pointer.
> 
> > 
> > > the MFD select the 'mode'. Maybe being backwards compatible isn't
> > > possible in any case. Is there a rule somewhere that we guarantee you'll
> > > never have to change your CONFIG_FOO options?
> > > 
> > 
> > That would be nice, but no, there is no such rule. You can probably argue
> > that no published kernel configuration enables the watchdog flag,
> > so there is nothing to be concerned about.
> 
> Alright, cool. Thanks
> 
> Moritz
> 
> PS: Haven't forgotten about the cros-ec-hwmon patch that I sent out ...

No, still trying to get internal feedback. I'll have to ask again.

Guenter
