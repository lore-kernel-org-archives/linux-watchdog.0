Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37540 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbbFOHYr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jun 2015 03:24:47 -0400
MIME-Version: 1.0
In-Reply-To: <1434101718.2271.166.camel@x220>
References: <1434055734-3602-1-git-send-email-christian.gmeiner@gmail.com>
 <1434055734-3602-2-git-send-email-christian.gmeiner@gmail.com> <1434101718.2271.166.camel@x220>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 15 Jun 2015 09:24:25 +0200
Message-ID: <CAH9NwWfJS7e_=NFUQgiDB4BOETxYn9oreKT0Md9q6N9eLJd3Rw@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: Add basic support for the Congatec CGEB BIOS interface
To: Paul Bolle <pebolle@tiscali.nl>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>, jdelvare@suse.de,
	linux-i2c@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, jingoohan1@gmail.com,
	Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Paul

Thanks for looking over my patches!

2015-06-12 11:35 GMT+02:00 Paul Bolle <pebolle@tiscali.nl>:
> A few nits.
>
> On Thu, 2015-06-11 at 22:48 +0200, Christian Gmeiner wrote:
>> --- /dev/null
>> +++ b/drivers/mfd/congatec-cgeb.c
>
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>
>> +/*
>> + * cgeb_invoke - invoke CGEB BIOS call.
>
> s/cgeb_invoke/cgeb_call/
>

ok

>> + *
>> + * @board:     board context data
>> + * @p:         CGEB parameters for this call
>> + * @fct:       CGEB function code
>> + * @return:    0 on success or negative error code on failure.
>> + *
>> + * Call the CGEB BIOS code with the given parameters.
>> + */
>> +unsigned int cgeb_call(struct cgeb_board_data *board,
>> +              struct cgeb_function_parameters *p, cgeb_function_t fct)
>> +{
>> +     [...]
>> +}
>
>> +static int __init cgeb_init(void)
>> +{
>> +     [...]
>> +}
>> +
>> +static void cgeb_exit(void)
>> +{
>> +     [...]
>> +}
>> +
>> +module_init(cgeb_init);
>> +module_exit(cgeb_exit);
>
> cgeb_exit is only used through module_exit(). So I guess it could be
> marked __exit, right?
>

That is correct - will be fixed in v2.

>> +MODULE_LICENSE("GPL");
>
> The comment at the top of this file states the license is GPL v2. The
> MODULE_LICENSE() macro states, according to include/linux/module.h, that
> the license is GPL v2 or later. So I think one of these two needs to
> change.
>
> I spotted the same license mismatch in 2/4, 3/4 and 4/4.
>

Will be fixed in v2.

Thanks
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
