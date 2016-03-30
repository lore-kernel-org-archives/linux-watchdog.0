Return-path: <shawnguo@kernel.org>
Date: Wed, 30 Mar 2016 09:22:33 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Tim Harvey <tharvey@gateworks.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Justin Waters <justin.waters@timesys.com>,
	Lucas Stach <l.stach@pengutronix.de>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
Message-ID: <20160330012226.GD28207@tiger>
References: <20151105222325.GA26159@roeck-us.net>
 <CAJ+vNU2fSxRJ7YvxOfNzoEoiKgzv-dHj=+eksKxH48ekHiUw2Q@mail.gmail.com>
 <20151106220249.GA19791@roeck-us.net>
 <565F4244.7090502@timesys.com>
 <CAJ+vNU00Bf97HUqkkW9KqOUzHXh482R9O1gasz6ju3Pn-_5chA@mail.gmail.com>
 <CAJ+vNU2qHQPSJ1KWp_3f3vAdeuOcF0ooZHmHsdafabZLXJv=Bw@mail.gmail.com>
 <20151228162923.GA31680@spo001.leaseweb.nl>
 <56AA79DA.2010305@timesys.com>
 <CAOMZO5DrTY3ho0Z_jXxeYMqbd6GmUKRwD1LB61vM1ZTGQAYOrg@mail.gmail.com>
 <56F991C3.8030201@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56F991C3.8030201@timesys.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Mar 28, 2016 at 04:19:15PM -0400, Akshay Bhat wrote:
> Hi Shawn,
> 
> On 02/28/2016 08:56 AM, Fabio Estevam wrote:
> >Rob,
> >
> >On Thu, Jan 28, 2016 at 6:28 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
> >
> >>>I have no objections against the idea and the code itself.
> >>>But as Guenter pointed out: it would be handy to get feedback from the
> >>>devicetree maintainers on the above discussion.
> >>>
> >>>Kind regards,
> >>>Wim.
> >>>
> >>
> >>Any suggestions on whether a vendor specific prefix is necessary?
> >
> >Any comments?
> >
> 
> Is this something you can help with, since you are the iMX
> architecture/devicetree maintainer? Appreciate any feedback.

FWIW,

Acked-by: Shawn Guo <shawnguo@kernel.org>

Guenter,

I think it's reasonable to pick up the patch, if we have it copied to DT
maintainers and on the list for a long period of time, and do not see
any objection from anyone.

Shawn
