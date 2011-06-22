Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:56415 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932181Ab1FVUXU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 16:23:20 -0400
Date: Wed, 22 Jun 2011 22:23:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: About internal heartbeat timer
Message-ID: <20110622202318.GG26745@infomag.iguana.be>
References: <4DFFB0BD.3050101@udio.cujae.edu.cu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DFFB0BD.3050101@udio.cujae.edu.cu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alejandro,

> I have a doubt about the use of internal timer to reset the wdt when the  
> watchdog device was closed from userspace and it doesn't support  
> stopping the wdt.
> I think, in my modest opinion, that if the watchdog device was closed at  
> userspace it means that something is wrong at userspace and the system  
> needs to be rebooted.

No. the reason why magic_close was introduced in the past is because
there was a need to be able to tell the driver that it could correctly stop.
For instance for maintenance work, where the watchdog device should NOT reboot
the system during the maintenance.
So the reason why we sent that magic char is because we want to tell the driver
that a watchdog daemon will stop working. In that case you do need that timer.

> I think that  the internal timer can be useful in the following scenario:
> If an user reboot the system, then the internal timer must ensure that  
> the watchdog didn't reset the system during the reboot process and it  
> send ticks to the wdt until the user/clean reboot process get finished.
> Maybe a reboot notifier can be used to detect when the user reboot the  
> system manually.

If a system is rebooted then the watchdog device is also resetted.
So until you start the watchdog, it will not be activated...

Kind regards,
Wim.

