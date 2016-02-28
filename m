Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51131 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758013AbcB1PCY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 10:02:24 -0500
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: Wim Van Sebroeck <wim@iguana.be>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
References: <20160125190942.GA6824@sophia>
 <20160125192810.2487661b@lxorguk.ukuu.org.uk>
 <20160228140739.GA7577@spo001.leaseweb.nl>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D30BFE.7060805@roeck-us.net>
Date: Sun, 28 Feb 2016 07:02:22 -0800
MIME-Version: 1.0
In-Reply-To: <20160228140739.GA7577@spo001.leaseweb.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/28/2016 06:07 AM, Wim Van Sebroeck wrote:
>>> +static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
>>> +{
>>> +	/* resolution is in minutes for timeouts greater than 255 seconds */
>>> +	if (t > 255) {
>>> +		/* truncate second resolution to minute resolution */
>>> +		t /= 60;
>>> +		wdev->timeout = t * 60;
>>> +
>>> +		/* set watchdog timer for minutes */
>>> +		outb(0x00, CFG_ADDR);
>>
>> If ask for 299 seconds surely I should get 300 not 240 ?
>> (Whether to round off or round up is an interesting question for the
>> middle range - does it go off early or late - I'd have said late but...)
>
> This is my preference:
> 	if (t > 255)
> 		t = (((t - 1) / 60) + 1) * 60;
>

In case I am missing something: Why not just use DIV_ROUND_UP() ?

Thanks,
Guenter

