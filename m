Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mtaext1.cujae.edu.cu ([200.55.139.24]:46380 "EHLO
	mtaext1.cujae.edu.cu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758023Ab1FVVVS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 17:21:18 -0400
Received: from newton.cujae.edu.cu (mtaint1.cujae.edu.cu [10.8.1.212])
	by mtaext1.cujae.edu.cu (Postfix) with ESMTP id E666E3E004
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jun 2011 17:18:15 -0400 (EDT)
Received: from udio.cujae.edu.cu (udio.cujae.edu.cu [10.8.57.5])
	by newton.cujae.edu.cu (Postfix) with ESMTP id 9589A240F9
	for <linux-watchdog@vger.kernel.org>;
	Wed, 22 Jun 2011 17:24:26 -0400 (EDT)
Received: from [10.9.3.110] by udio.cujae.edu.cu (MDaemon PRO v10.1.2)
	with ESMTP id md50000186281.msg
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jun 2011 17:15:35 -0400
Message-ID: <4E025DC2.3050900@udio.cujae.edu.cu>
Date: Wed, 22 Jun 2011 17:25:22 -0400
From: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org
Subject: Re: About internal heartbeat timer
References: <4DFFB0BD.3050101@udio.cujae.edu.cu>
	<20110622202318.GG26745@infomag.iguana.be>
In-Reply-To: <20110622202318.GG26745@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim

>> I have a doubt about the use of internal timer to reset the wdt when the
>> watchdog device was closed from userspace and it doesn't support
>> stopping the wdt.
>> I think, in my modest opinion, that if the watchdog device was closed at
>> userspace it means that something is wrong at userspace and the system
>> needs to be rebooted.
> No. the reason why magic_close was introduced in the past is because
> there was a need to be able to tell the driver that it could correctly stop.
> For instance for maintenance work, where the watchdog device should NOT reboot
> the system during the maintenance.
> So the reason why we sent that magic char is because we want to tell the driver
> that a watchdog daemon will stop working. In that case you do need that timer.
>

I see...but as I can see in the Generic Watchdog Framework patch series, 
the timer only needs that the bit WDOG_ACTIVE active to keep resetting 
the wdt....please take a look at my comment about patch number 7

>> I think that  the internal timer can be useful in the following scenario:
>> If an user reboot the system, then the internal timer must ensure that
>> the watchdog didn't reset the system during the reboot process and it
>> send ticks to the wdt until the user/clean reboot process get finished.
>> Maybe a reboot notifier can be used to detect when the user reboot the
>> system manually.
> If a system is rebooted then the watchdog device is also resetted.
> So until you start the watchdog, it will not be activated...

Yes, but I'm thinking in the following case: if the system was 
restarting (clean reboot) and it take more than the watchdog timeout or 
the  timeleft was very small to do a clean reboot....then the wdt reset 
the system and maybe it can be corrupt it.
Maybe this case is weird and uncommon, but it has a chance to occur.

Best regards
Alejandro


Participe en Universidad 2012, del 13 al 17 de febrero de 2012.
Habana, Cuba: http://www.congresouniversidad.cu
Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu

Participe en el Segundo Congreso Medio Ambiente Construido y 
Desarrollo Sustentable (MACDES 2011) del 6 al 9 de diciembre de 2011, 
Hotel Nacional, Habana, Cuba: http://macdes.cujae.edu.cu
