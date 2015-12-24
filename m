Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/5] watchdog: Do not use 'dev' from watchdog_device in watchdog drivers
Date: Wed, 23 Dec 2015 21:11:28 -0800
Message-Id: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The 'dev' variable in watchdog drivers has a different lifetime than the
watchdog character device and should therefore not be used by watchdog
drivers.

Some of the drivers use the variable to print kernel messages. Those are
either dropped or converted to use pr_ functions. One driver sets the
variable during initialization to the watchdog driver's parent device,
which is wrong and also removed.
