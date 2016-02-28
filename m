Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34675 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247AbcB1N4t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 08:56:49 -0500
MIME-Version: 1.0
In-Reply-To: <56AA79DA.2010305@timesys.com>
References: <1446758362-11702-1-git-send-email-akshay.bhat@timesys.com>
	<1446758362-11702-2-git-send-email-akshay.bhat@timesys.com>
	<20151105222325.GA26159@roeck-us.net>
	<CAJ+vNU2fSxRJ7YvxOfNzoEoiKgzv-dHj=+eksKxH48ekHiUw2Q@mail.gmail.com>
	<20151106220249.GA19791@roeck-us.net>
	<565F4244.7090502@timesys.com>
	<CAJ+vNU00Bf97HUqkkW9KqOUzHXh482R9O1gasz6ju3Pn-_5chA@mail.gmail.com>
	<CAJ+vNU2qHQPSJ1KWp_3f3vAdeuOcF0ooZHmHsdafabZLXJv=Bw@mail.gmail.com>
	<20151228162923.GA31680@spo001.leaseweb.nl>
	<56AA79DA.2010305@timesys.com>
Date: Sun, 28 Feb 2016 10:56:49 -0300
Message-ID: <CAOMZO5DrTY3ho0Z_jXxeYMqbd6GmUKRwD1LB61vM1ZTGQAYOrg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset-output' dt prop
From: Fabio Estevam <festevam@gmail.com>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Tim Harvey <tharvey@gateworks.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Justin Waters <justin.waters@timesys.com>,
	Lucas Stach <l.stach@pengutronix.de>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Rob,

On Thu, Jan 28, 2016 at 6:28 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:

>> I have no objections against the idea and the code itself.
>> But as Guenter pointed out: it would be handy to get feedback from the
>> devicetree maintainers on the above discussion.
>>
>> Kind regards,
>> Wim.
>>
>
> Any suggestions on whether a vendor specific prefix is necessary?

Any comments?
