Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47675 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbcEJNZ1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 May 2016 09:25:27 -0400
Subject: Re: [PATCH 2/2] watchdog: Add Aspeed watchdog driver
To: Joel Stanley <joel@jms.id.au>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1462797277-14969-3-git-send-email-joel@jms.id.au>
 <5730A339.80006@roeck-us.net>
 <CACPK8XfK4Qt2GaSL7eVoNkCawbtXqFX9bGRcgyAyq7R2yuSZkA@mail.gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jeremy Kerr <jk@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5731E135.8000100@roeck-us.net>
Date: Tue, 10 May 2016 06:25:09 -0700
MIME-Version: 1.0
In-Reply-To: <CACPK8XfK4Qt2GaSL7eVoNkCawbtXqFX9bGRcgyAyq7R2yuSZkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Joel,

On 05/10/2016 04:10 AM, Joel Stanley wrote:

[ ... ]

>>> +
>>> +       /*
>>> +        * The ast2400 wdt can run at PCLK, or 1MHz. The ast2500 only
>>> +        * runs at 1MHz. We chose to always run at 1MHz, as there's no
>>> +        * good reason to have a faster watchdog counter.
>>> +        */
>>> +       wdt->rate = 1000000;
>>
>>
>> Why not just use a define ?
>
> I will add one.
>
> The comment is informative though for people who read the ast2400
> datasheet and wonder why we don't provide the option clocking with
> pclk, I will leave it in.
>

The comment is ok. I just find it unnecessary to have a variable
instead of a constant.

[ ... ]
>
>> ctrl is really static except for the enable flag. Not really sure
>> if having a variable for it has any real benefits - you might as well
>> just read the register and update the enable flag instead as needed when
>> starting or stopping the watchdog. Is there a reason for not doing that ?
>
> Not really. I find it cleaner to keep a copy of the register instead
> of read-modify-write, but if you feel strongly about it I can change.
>

No worries. Not worth arguing about.

Guenter

