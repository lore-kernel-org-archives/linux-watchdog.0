Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:51026 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756Ab2FIPTV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 9 Jun 2012 11:19:21 -0400
Date: Sat, 9 Jun 2012 15:39:46 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: linux-watchdog@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Driver: Super IO Chip access Locking issue
Message-ID: <Pine.LNX.4.61.1206091443230.9142@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

I have recently noticed a flaw in the design of linux drivers for SuperIO 
chips.

I have a dual core board with two SuperIO chips.

Winbond W83627DFG: watchdog/w83627hf_wdt, hwmon/w83627ehf
Fintek F81216:

The existing driver for the currently supported SuperIO chip is split 
into two kernel modules each with its own private IO lock.

If I continue this model and implement drivers to use the Fintek F81216 
watchdog and the Winbond W83627DFG GPIO then I end up with more private IO 
locks and more potential to get a clash when two or more drivers are 
trying to access the same ports at the same time.

What is needed for SuperIO chips is a common way of locking the port 
resource while the SuperIO chip is being accessed. A single common io_lock 
would be the first and simplest approach. This is at least safe unlike the 
current situation.

A better and longer term solution would be to update all the affected 
drivers to use the existing recource allocation system for the SuperIO 
ports (usually 0x2E/2F and 0x4E/4F) to reserve the port while it is in 
use.

If this is considered too slow/complex and/or too much work then an 
alternative SuperIO port locking system may be need that dynamically 
provides locks for a specified SuperIO port address. A driver for a 
SuperIO chip would request a lock for the desired port address during 
initialisation and free it up on exit. If scanning for a SuperIO chip, 
the port lock would be requested and then freed for each port scanned, 
untill the IO chip is located. This would involve minimal changes 
to the existing drivers without single treading access to SuperIO chips on 
different ports.

If any of you think that this needs a wider ordiance, please forward to 
the appropriate mailing lists.

Please CC me on any followups.

Regards
 	Mark Fortescue.

mark @ mtfhpc . demon . co . uk
