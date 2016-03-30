Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44913 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbcC3VJS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2016 17:09:18 -0400
Date: Wed, 30 Mar 2016 14:09:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Akshay Bhat <akshay.bhat@timesys.com>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tim Harvey <tharvey@gateworks.com>,
	linux-watchdog@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Justin Waters <justin.waters@timesys.com>,
	Lucas Stach <l.stach@pengutronix.de>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
Message-ID: <20160330210916.GB21993@roeck-us.net>
References: <CAJ+vNU2fSxRJ7YvxOfNzoEoiKgzv-dHj=+eksKxH48ekHiUw2Q@mail.gmail.com>
 <20151106220249.GA19791@roeck-us.net>
 <565F4244.7090502@timesys.com>
 <CAJ+vNU00Bf97HUqkkW9KqOUzHXh482R9O1gasz6ju3Pn-_5chA@mail.gmail.com>
 <CAJ+vNU2qHQPSJ1KWp_3f3vAdeuOcF0ooZHmHsdafabZLXJv=Bw@mail.gmail.com>
 <20151228162923.GA31680@spo001.leaseweb.nl>
 <56AA79DA.2010305@timesys.com>
 <CAOMZO5DrTY3ho0Z_jXxeYMqbd6GmUKRwD1LB61vM1ZTGQAYOrg@mail.gmail.com>
 <56F991C3.8030201@timesys.com>
 <20160330012226.GD28207@tiger>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160330012226.GD28207@tiger>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 30, 2016 at 09:22:33AM +0800, Shawn Guo wrote:
> On Mon, Mar 28, 2016 at 04:19:15PM -0400, Akshay Bhat wrote:
> > Hi Shawn,
> > 
> > On 02/28/2016 08:56 AM, Fabio Estevam wrote:
> > >Rob,
> > >
> > >On Thu, Jan 28, 2016 at 6:28 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
> > >
> > >>>I have no objections against the idea and the code itself.
> > >>>But as Guenter pointed out: it would be handy to get feedback from the
> > >>>devicetree maintainers on the above discussion.
> > >>>
> > >>>Kind regards,
> > >>>Wim.
> > >>>
> > >>
> > >>Any suggestions on whether a vendor specific prefix is necessary?
> > >
> > >Any comments?
> > >
> > 
> > Is this something you can help with, since you are the iMX
> > architecture/devicetree maintainer? Appreciate any feedback.
> 
> FWIW,
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> 
> Guenter,
> 
> I think it's reasonable to pick up the patch, if we have it copied to DT
> maintainers and on the list for a long period of time, and do not see
> any objection from anyone.
> 
The question was if the property name should be ext-reset-output or
fsl,ext-reset-output. In my opinion, it should be fsl,ext-reset-output
because it is not a generic property. Tim disagrees.

So we have two options: Change the property name to fsl,ext-reset-output,
which I would accept, or wait for a devicetree maintainer to make a decision.

Guenter
