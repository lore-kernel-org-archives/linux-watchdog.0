Return-path: <fixed-term.Oleksij.Rempel@de.bosch.com>
To: Guenter Roeck <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
	Dirk.Behme <Dirk.Behme@de.bosch.com>
From: fixed-term.Oleksij.Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: watchdoug group ping
Message-ID: <57172B7C.4060407@de.bosch.com>
Date: Wed, 20 Apr 2016 09:10:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hallo all,

my target is to provide pretimout support for devices which do not have
this functionality.

Pre-requirement is this patchset (i contacted the author to rebase it
against latest watchdog core branch):
https://www.mail-archive.com/linux-watchdog@vger.kernel.org/msg02394.html

The idea is to use different watchdogs/timers or what ever as one group
- one virtual device.
One driver will be responsible for reseting the system, other for
generating an interrupt on pre-timout.
It can be also useful for systems which require redundant watchdogs -
two or more watchdog pinged over one /dev/watchdog

I assume i would need to create a master virtual watchdog driver to
bypass/broadcast all pings to child devices.

Do you have some ideas or suggestions?
-- 
Best regards,
Oleksij Rempel
CM-AI/ECO3
Tel.: +49(5121)49-2962
