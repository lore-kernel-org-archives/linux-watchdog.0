Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mtaext1.cujae.edu.cu ([200.55.139.24]:59367 "EHLO
	mtaext1.cujae.edu.cu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab1FXUGH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Jun 2011 16:06:07 -0400
Received: from newton.cujae.edu.cu (mtaint1.cujae.edu.cu [10.8.1.212])
	by mtaext1.cujae.edu.cu (Postfix) with ESMTP id 0C9603E049
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jun 2011 15:57:31 -0400 (EDT)
Received: from udio.cujae.edu.cu (udio.cujae.edu.cu [10.8.57.5])
	by newton.cujae.edu.cu (Postfix) with ESMTP id 497A524068
	for <linux-watchdog@vger.kernel.org>;
	Fri, 24 Jun 2011 16:09:49 -0400 (EDT)
Received: from [10.9.3.110] by udio.cujae.edu.cu (MDaemon PRO v10.1.2)
	with ESMTP id md50000188023.msg
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jun 2011 16:00:40 -0400
Message-ID: <4E04EF51.6070604@udio.cujae.edu.cu>
Date: Fri, 24 Jun 2011 16:10:57 -0400
From: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 7/10 v2] Generic Watchdog Timer Driver
References: <20110618172537.GH3441@infomag.iguana.be>
	<4E025DC8.9090202@udio.cujae.edu.cu>
	<20110624194136.GZ23305@infomag.iguana.be>
In-Reply-To: <20110624194136.GZ23305@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim

>>>    static int watchdog_stop(struct watchdog_device *wddev)
>>>    {
>>> -	int err;
>>> +	int err = -1;
>>> +
>>> +	if (test_bit(WDOG_NO_WAY_OUT,&wdd->status))
>>> +		return err;
>>>
>> If you return err at this point you never clean the bit WDOG_ACTIVE then
>> the timer will keep resetting the wdt because the bit is still active.
> If WDOG_ACTIVE is never cleared, then you will need to keep pinging the watchdog
> to not start the reboot. Even when you use the timer (with this code):
>          if (time_before(jiffies, next_heartbeat) ||
>             (!test_bit(WDOG_ACTIVE,&wdt_dev.status))) {
>
> if WDOG_ACTIVE is set then you fall down to: if (time_before(jiffies, next_heartbeat))
> which means that as long that the next_heartbeat time is not there we will keep pinging
> the watchdog device, but as soon as jiffies>  next_heartbeat, the watchdog device will
> not be triggered anymore.
>
> But I see another possible problem here. Will do some special tests first.
>
Sorry, I didn't see the ! operator before test_bit, my mistake !! ;)

best regards
Alejandro

PS: I send a patch some days ago (xilinx watchdog....)...and anyone 
comment it :(. Should I send it again to the list ?



Participe en Universidad 2012, del 13 al 17 de febrero de 2012.
Habana, Cuba: http://www.congresouniversidad.cu
Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu

Participe en el Segundo Congreso Medio Ambiente Construido y 
Desarrollo Sustentable (MACDES 2011) del 6 al 9 de diciembre de 2011, 
Hotel Nacional, Habana, Cuba: http://macdes.cujae.edu.cu
