Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:3886 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932371Ab1BYJtf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Feb 2011 04:49:35 -0500
Date: Fri, 25 Feb 2011 10:49:28 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Mike Waychison <mikew@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] [PATCH 3/10] Generic Watchdog Timer Driver
Message-ID: <20110225094928.GQ3790@infomag.iguana.be>
References: <20110223204253.GA7385@infomag.iguana.be> <4D657F24.2000402@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D657F24.2000402@google.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mike,

>> diff --git a/drivers/watchdog/core/watchdog_dev.c b/drivers/watchdog/core/watchdog_dev.c
>> index ad08a93..0d2ed1d 100644
>> --- a/drivers/watchdog/core/watchdog_dev.c
>> +++ b/drivers/watchdog/core/watchdog_dev.c
>> @@ -151,6 +151,11 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>>   		return put_user(val, p);
>>   	case WDIOC_GETBOOTSTATUS:
>>   		return put_user(wdd->bootstatus, p);
>> +	case WDIOC_KEEPALIVE:
>> +		if (!(wdd->info->options&  WDIOF_MAGICCLOSE))
>
> Is this meant to be WDIOF_KEEPALIVEPING ?

Yes it is. Fixed this in my code.

Thanks,
Wim.

