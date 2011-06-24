Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:34994 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752170Ab1FXTqV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Jun 2011 15:46:21 -0400
Date: Fri, 24 Jun 2011 21:46:19 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: About internal heartbeat timer
Message-ID: <20110624194619.GA23305@infomag.iguana.be>
References: <4DFFB0BD.3050101@udio.cujae.edu.cu> <20110622202318.GG26745@infomag.iguana.be> <4E025DC2.3050900@udio.cujae.edu.cu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E025DC2.3050900@udio.cujae.edu.cu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alejandro,

>>> I think that  the internal timer can be useful in the following scenario:
>>> If an user reboot the system, then the internal timer must ensure that
>>> the watchdog didn't reset the system during the reboot process and it
>>> send ticks to the wdt until the user/clean reboot process get finished.
>>> Maybe a reboot notifier can be used to detect when the user reboot the
>>> system manually.
>> If a system is rebooted then the watchdog device is also resetted.
>> So until you start the watchdog, it will not be activated...
>
> Yes, but I'm thinking in the following case: if the system was  
> restarting (clean reboot) and it take more than the watchdog timeout or  
> the  timeleft was very small to do a clean reboot....then the wdt reset  
> the system and maybe it can be corrupt it.
> Maybe this case is weird and uncommon, but it has a chance to occur.

Don't forget that most watchdog drivers allready use a reboot_notifier or
a platform shutdown method, to stop the watchdog before rebooting.
And secondly, when watchdog devices are initialised the default behaviour
is to stop the watchdog during initialisation (but it is allowed to have
an option to manually change this behaviour so that the user can choose).

Kind regards,
Wim.

