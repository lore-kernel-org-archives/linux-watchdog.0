Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55841 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932404AbbERUOu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 16:14:50 -0400
Date: Mon, 18 May 2015 13:14:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fu Wei <fu.wei@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
Message-ID: <20150518201445.GA21230@roeck-us.net>
References: <=fu.wei@linaro.org>
 <CADyBb7u=HjZO5CBzZLxw1aWDx0tKdVKBuTrrhrRF9bAQr7pADQ@mail.gmail.com>
 <20150518172329.GA17202@roeck-us.net>
 <2729872.Fp4939suL0@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2729872.Fp4939suL0@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 18, 2015 at 10:03:52PM +0200, Arnd Bergmann wrote:
> On Monday 18 May 2015 10:23:30 Guenter Roeck wrote:
> > > 
> > > integrate watchdog_init_pretimeout and watchdog_init_timeout will be a
> > > little hard,
> > > we may need to change this API to :
> > > 
> > > watchdog_init_timeouts(struct watchdog_device *wdd, unsigned int timeout_parm,
> > >                              unsigned int pretimeout_parm, struct device *dev)
> > > 
> > > then we need to update all the watchdog drivers which use this API,
> > > maybe we can do this in a individual patchset, after this pretimeout
> > > patch is merged.
> > > 
> > > Is that OK  ?   any thought?
> > > 
> > That is what I would recommend.
> > 
> 
> The API change is fine, but I don't think you need to change all drivers.
> 
> Just add a small wrapper function in the header file doing the conversion:
> 
> static inline int watchdog_init_timeout(struct watchdog_device *wdd,
>                                 unsigned int timeout_parm, struct device *dev)
> {
> 	return watchdog_init_timeouts(wdd, timeout_parm, ~0ul, dev);
> }
> 
> Then you can update the drivers that actually use the pretimeout to
> use the new function at some point, and leave all other drivers calling
> the wrapper function.
> 
Excellent idea.

Guenter
