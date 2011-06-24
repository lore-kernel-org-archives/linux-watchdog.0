Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:37540 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752015Ab1FXTlm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Jun 2011 15:41:42 -0400
Date: Fri, 24 Jun 2011 21:41:36 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 7/10 v2] Generic Watchdog Timer Driver
Message-ID: <20110624194136.GZ23305@infomag.iguana.be>
References: <20110618172537.GH3441@infomag.iguana.be> <4E025DC8.9090202@udio.cujae.edu.cu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E025DC8.9090202@udio.cujae.edu.cu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alejandro,

>>   static int watchdog_stop(struct watchdog_device *wddev)
>>   {
>> -	int err;
>> +	int err = -1;
>> +
>> +	if (test_bit(WDOG_NO_WAY_OUT,&wdd->status))
>> +		return err;
>>
>
> If you return err at this point you never clean the bit WDOG_ACTIVE then  
> the timer will keep resetting the wdt because the bit is still active.

If WDOG_ACTIVE is never cleared, then you will need to keep pinging the watchdog
to not start the reboot. Even when you use the timer (with this code):
        if (time_before(jiffies, next_heartbeat) ||
           (!test_bit(WDOG_ACTIVE, &wdt_dev.status))) {

if WDOG_ACTIVE is set then you fall down to: if (time_before(jiffies, next_heartbeat))
which means that as long that the next_heartbeat time is not there we will keep pinging
the watchdog device, but as soon as jiffies > next_heartbeat, the watchdog device will
not be triggered anymore.

But I see another possible problem here. Will do some special tests first.

Kind regards,
Wim.

