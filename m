Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34736 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbcC1UTY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Mar 2016 16:19:24 -0400
Received: by mail-qg0-f54.google.com with SMTP id c67so84488854qgc.1
        for <linux-watchdog@vger.kernel.org>; Mon, 28 Mar 2016 13:19:24 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset-output' dt prop
To: Fabio Estevam <festevam@gmail.com>
References: <1446758362-11702-1-git-send-email-akshay.bhat@timesys.com>
 <1446758362-11702-2-git-send-email-akshay.bhat@timesys.com>
 <20151105222325.GA26159@roeck-us.net>
 <CAJ+vNU2fSxRJ7YvxOfNzoEoiKgzv-dHj=+eksKxH48ekHiUw2Q@mail.gmail.com>
 <20151106220249.GA19791@roeck-us.net> <565F4244.7090502@timesys.com>
 <CAJ+vNU00Bf97HUqkkW9KqOUzHXh482R9O1gasz6ju3Pn-_5chA@mail.gmail.com>
 <CAJ+vNU2qHQPSJ1KWp_3f3vAdeuOcF0ooZHmHsdafabZLXJv=Bw@mail.gmail.com>
 <20151228162923.GA31680@spo001.leaseweb.nl> <56AA79DA.2010305@timesys.com>
 <CAOMZO5DrTY3ho0Z_jXxeYMqbd6GmUKRwD1LB61vM1ZTGQAYOrg@mail.gmail.com>
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
From: Akshay Bhat <akshay.bhat@timesys.com>
Message-ID: <56F991C3.8030201@timesys.com>
Date: Mon, 28 Mar 2016 16:19:15 -0400
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DrTY3ho0Z_jXxeYMqbd6GmUKRwD1LB61vM1ZTGQAYOrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Shawn,

On 02/28/2016 08:56 AM, Fabio Estevam wrote:
> Rob,
>
> On Thu, Jan 28, 2016 at 6:28 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
>
>>> I have no objections against the idea and the code itself.
>>> But as Guenter pointed out: it would be handy to get feedback from the
>>> devicetree maintainers on the above discussion.
>>>
>>> Kind regards,
>>> Wim.
>>>
>>
>> Any suggestions on whether a vendor specific prefix is necessary?
>
> Any comments?
>

Is this something you can help with, since you are the iMX 
architecture/devicetree maintainer? Appreciate any feedback.

Thanks,
Akshay
