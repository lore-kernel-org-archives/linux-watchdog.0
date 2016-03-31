Return-path: <tharvey@gateworks.com>
MIME-Version: 1.0
In-Reply-To: <20160331015714.GM28207@tiger>
References: <20151106220249.GA19791@roeck-us.net>
	<565F4244.7090502@timesys.com>
	<CAJ+vNU00Bf97HUqkkW9KqOUzHXh482R9O1gasz6ju3Pn-_5chA@mail.gmail.com>
	<CAJ+vNU2qHQPSJ1KWp_3f3vAdeuOcF0ooZHmHsdafabZLXJv=Bw@mail.gmail.com>
	<20151228162923.GA31680@spo001.leaseweb.nl>
	<56AA79DA.2010305@timesys.com>
	<CAOMZO5DrTY3ho0Z_jXxeYMqbd6GmUKRwD1LB61vM1ZTGQAYOrg@mail.gmail.com>
	<56F991C3.8030201@timesys.com>
	<20160330012226.GD28207@tiger>
	<20160330210916.GB21993@roeck-us.net>
	<20160331015714.GM28207@tiger>
Date: Thu, 31 Mar 2016 11:01:58 -0700
Message-ID: <CAJ+vNU2zBCAF8hJfmSa31CyD9XcOCxYWqH9LKRm1S_sunqkgOg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset-output' dt prop
From: Tim Harvey <tharvey@gateworks.com>
To: Shawn Guo <shawnguo@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Akshay Bhat <akshay.bhat@timesys.com>, Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Justin Waters <justin.waters@timesys.com>, Lucas Stach <l.stach@pengutronix.de>,
	Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Mar 30, 2016 at 6:57 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Wed, Mar 30, 2016 at 02:09:16PM -0700, Guenter Roeck wrote:
>> The question was if the property name should be ext-reset-output or
>> fsl,ext-reset-output. In my opinion, it should be fsl,ext-reset-output
>> because it is not a generic property. Tim disagrees.
>>

Guenter,

My issue regarding the vendor prefix was not a hard dissagreement but
was more about me understanding the rational behind using vendor
prefixes. In this case the imx2_wdt driver 'is' a vendor specific
driver as its compatible strings are prefixed with 'fsl,' so isn't
'any' property added to devicetree/bindings/watchdog/fsl-imx-wdt.txt
inherently a vendor specific properly already? I assume that is why
the 'big-endian' property isn't 'fsl,big-endian'.

Maybe it's more about if it 'is' marked as a vendor specific property
its much easier to get approval and accepted by a vendor-specific
maintainer?

>> So we have two options: Change the property name to fsl,ext-reset-output,
>> which I would accept, or wait for a devicetree maintainer to make a decision.
>
> Guenter,
>
> I agree with you on this point.  Before everyone agrees that this is a
> generic binding, we should have vendor prefix for the property.
>
> Tim,
>
> This is a small change which, IMO, shouldn't hold an useful patch from being
> merged.  Care to resend with the suggested change?
>
> Shawn

Shawn,

Sure - I'll rebase and re-submit.

Tim
