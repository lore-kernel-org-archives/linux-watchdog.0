Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44367 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbL2R2v (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Dec 2015 12:28:51 -0500
Date: Tue, 29 Dec 2015 09:28:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-watchdog@vger.kernel.org, Fu Wei <fu.wei@linaro.org>
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151229172848.GA14047@roeck-us.net>
References: <20151228152335.GA18627@roeck-us.net>
 <20151228152710.GA31482@spo001.leaseweb.nl>
 <20151228215709.GA30595@roeck-us.net>
 <20151228225427.GA2018@spo001.leaseweb.nl>
 <5681C2FE.7070100@mentor.com>
 <20151229071732.GA6292@spo001.leaseweb.nl>
 <20151229160411.GB30405@roeck-us.net>
 <20151229173705.1596cf1d@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151229173705.1596cf1d@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 29, 2015 at 05:37:05PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 29 Dec 2015 08:04:11 -0800, Guenter Roeck wrote:
> > Hi Wim,
> > 
> > On Tue, Dec 29, 2015 at 08:17:32AM +0100, Wim Van Sebroeck wrote:
> > [ ... ]
> > > 
> > > SBSA: What should be done is to create a correct driver without pretimeout and with just the normal watchdog (=reboot if we aren't kicked fast enough) behaviour and get that in.
> > > 
> > Absoutely agree.
> 
> Sorry to get into the conversation, but I got interested into the SBSA
> watchdog driver recently, and looked at the status of its merge in the
> kernel.
> 
> I've looked at Fu Wei's v9 from November which I believe is the latest
> version, and then looked at Vladimir's generic pretimeout patch set.
> 
> Vladimir, do you plan to rework the SBSA watchdog driver on top of your
> pretimeout patch series ? Or do Fu Wei intends do it ? Alternatively,
> as suggested by Wim and Guenter, submitting an initial version without
> pretimeout support would be a good thing. Are you, or Fu, interested in
> doing this, or should I work at updating Fu's patches in this
> direction ?
> 
Probem with SBSA and pretimeout is two-fold. First, it adds a quite a bit of
complexity to the driver, second, it adds a lot of risk to the driver.
Reason is that this is not one specific watchdog, but a watchdog implementation
based on a standard which, in my opinion, is less than well thought out
and leaves a lot of ambiguity when it comes to implementation details.
The more functionality is used, the higher the risk that some implementation
won't work.

I think we should stick with the basic implemementation and not support
pretimeout at all with the SBSA driver. If the maximum timeout is insufficient,
there are two options: Use the soft-timeout handled by the watchdog core,
which will hopefully make it for 4.6, or live with it. 

As for pretimeout itself, we will have multiple proposals to consider,
as well as integration order. At this point I would prefer to get the other
infrastructure changes in first, and then pick an implementation which
doesn't add too much complexity. Current proposals are, from my
perspective, either too heavy-weigt or too light-weight. I think we should
try to find a middle ground.

Thanks,
Guenter
