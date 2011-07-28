Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from exprod7og108.obsmtp.com ([64.18.2.169]:58178 "EHLO
	exprod7og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab1G1SPg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 28 Jul 2011 14:15:36 -0400
Message-ID: <4E319781.9000405@genband.com>
Date: Thu, 28 Jul 2011 11:08:17 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFC: generic support for two-stage watchdogs?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


When using kdump to store crash recovery information, it is frustrating 
when the watchdog timer fires and reboots the system under our feet.

Many hardware watchdogs support a two-stage operation where the initial 
stage expires and sends an NMI or other interrupt to the CPU.  Only once 
the second stage fires does it actually reboot the hardware.

Has anyone considered adding support for this sort of hardware to the 
/dev/watchdog API?  It seems like it would make sense to reset the 
watchdog timeout to some suitable period and trigger kdump.  This would 
let us preserve the crash information.

If the system is really fubared then the second stage will fire and 
reboot the machine.

Chris

-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
