Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58147 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaA0GmU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 01:42:20 -0500
Message-ID: <52E5FFCB.5000802@roeck-us.net>
Date: Sun, 26 Jan 2014 22:42:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 04/15] watchdog: orion: Handle IRQ
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com> <52DE84A6.6090909@roeck-us.net> <20140127063040.GA17506@localhost>
In-Reply-To: <20140127063040.GA17506@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/26/2014 10:30 PM, Ezequiel Garcia wrote:
> Hi Guenter,
>
> On Tue, Jan 21, 2014 at 06:31:02AM -0800, Guenter Roeck wrote:
> [..]
>>> @@ -131,6 +138,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
>>>    	if (!wdt_reg)
>>>    		return -ENOMEM;
>>>
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq > 0) {
>>
>> 0 is a valid interrupt number, and platform_get_irq returns an error code on errors.
>> Should be >= 0.
>>
>
> I'm revisiting this one. I believe this is not the hardware interrupt
> number, but the one mapped into virq space. So, 0 is not a valid
> interrupt number.
>
> Right?
>

Hi,

If so, the entire interrupt numbering scheme appears broken. Conceptually it should
not make a difference where the interrupt is coming from. If the virq system
returns 0 for invalid (non-configured) interrupts, and non-configured 'real'
interrupts are reported as -ENXIO, all bets are off. How would a driver know
what to expect ? And how would one be expected to review such non-deterministic
code ?

FWIW, platform_get_irq() does return -ENXIO for invalid interrupts. If there
is an independent notion of "0 is an invalid interrupt", it is well hidden.

Anyway, if you think the driver should treat 0 as invalid interrupt, go ahead.
Who am I to know. Just please don't use my Reviewed-by in this case.

Thanks,
Guenter

