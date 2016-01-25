Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51926 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbcAYUmK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jan 2016 15:42:10 -0500
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	William Breathitt Gray <vilhelm.gray@gmail.com>
References: <20160125190942.GA6824@sophia>
 <20160125192810.2487661b@lxorguk.ukuu.org.uk>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A6889E.60208@roeck-us.net>
Date: Mon, 25 Jan 2016 12:42:06 -0800
MIME-Version: 1.0
In-Reply-To: <20160125192810.2487661b@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/25/2016 11:28 AM, One Thousand Gnomes wrote:
>> +static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
>> +{
>> +	/* resolution is in minutes for timeouts greater than 255 seconds */
>> +	if (t > 255) {
>> +		/* truncate second resolution to minute resolution */
>> +		t /= 60;
>> +		wdev->timeout = t * 60;
>> +
>> +		/* set watchdog timer for minutes */
>> +		outb(0x00, CFG_ADDR);
>
> If ask for 299 seconds surely I should get 300 not 240 ?
> (Whether to round off or round up is an interesting question for the
> middle range - does it go off early or late - I'd have said late but...)
>

Matter of endless discussion. Some argue that the value should be rounded
up, some argue that it should be rounded down, some argue that it should
be rounded to the closest match. Each camp has its own valid arguments.
I usually leave it up to the driver's author to decide, with a slight
preference to never select a value larger than requested.

>> +static int __init ebc_c384_wdt_init(void)
>> +{
>> +	int err;
>> +
>> +	if (!dmi_match(DMI_BOARD_NAME, "EBC-C384 SBC"))
>> +		return -ENODEV;
>> +
>
> Is there no ACPI entry for it ?
>
Same here. As long as the board is identified, I tend to leave it up
to the driver author to decide _how_ to identify it.

Only question for me would be if the watchdog timer is implemented
in a Super-IO chip, and if so, if it would be possible to use the chip
identification instead of a DMI (or ACPI) entry to instantiate the driver.

Thanks,
Guenter

