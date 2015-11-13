Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48877 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846AbbKMS2K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Nov 2015 13:28:10 -0500
Subject: Re: [RESEND][PATCH] watchdog: add support for Sigma Designs SMP86xx
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
References: <1447420459-5301-1-git-send-email-mans@mansr.com>
 <56461155.80808@roeck-us.net> <yw1x37w9lu26.fsf@unicorn.mansr.com>
 <5646240C.5070105@roeck-us.net> <yw1xpozdkcas.fsf@unicorn.mansr.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56462BB7.9000709@roeck-us.net>
Date: Fri, 13 Nov 2015 10:28:07 -0800
MIME-Version: 1.0
In-Reply-To: <yw1xpozdkcas.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/13/2015 10:02 AM, M=E5ns Rullg=E5rd wrote:
>>>>> +static const struct of_device_id tangox_wdt_dt_ids[] =3D {
>>>>> +	{ .compatible =3D "sigma,smp8642-wdt" },
>>>>
>>>> So this is really for smp8642 only, not for any other chips in the=
 series ?
>>>
>>> It's for about a dozen SMP86xx, SMP87xx, and SMP89xx chips.  Should=
 I
>>> list them all?  I don't even know where to find a comprehensive lis=
t of
>>> device numbers.
>>>
>> I thought so, but I am not a devicetree expert, and I see some "xx" =
in
>> existing devicetree bindings. Something to ask when you submit the
>> bindings to the devicetree mailing list. Either case, I think it wou=
ld
>> be either something like "sigma,smp86xx-wdt" or a list of all of the=
m,
>> but not "sigma,smp8642-wdt" to be used for all chips.
>
> The general advice is to not use wildcards in DT bindings since the n=
ext
> chip matching the pattern might not be compatible at all.  New chips
> known to be compatible with an old one can specify both the exact chi=
p
> and the older one such that existing drivers will work automatically.
> If at some point they are found not to be compatible after all (hardw=
are
> bugs, perhaps) a fixed driver will work with existing device trees.
>
So I think the best approach here would be to list the chips known to w=
ork.

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
