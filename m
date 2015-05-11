Return-path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-watchdog@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Wim
 Van Sebroeck <wim@iguana.be>
CC: Andrew Bresticker <abrestic@chromium.org>, James Hogan
	<james.hogan@imgtec.com>, James Hartley <james.hartley@imgtec.com>, "Naidu
 Tellapati" <naidu.tellapati@imgtec.com>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH 0/2] watchdog: imgpdc_wdt assorted fixes
Date: Mon, 11 May 2015 14:41:03 -0300
Message-ID: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

A couple more fixes for IMG watchdog driver.

This first patch corrects the max_timeout setting which was wrongly
set in cycles.

The second patch documents the driver's timeout round-up, which
might seem a bit unintuitive. See the patch for more details.

Both patches are based on the three imgpdc patches sent recently by
Andrew Bresticker [1].

[1] http://www.spinics.net/lists/linux-watchdog/msg06107.html

Thanks!

Ezequiel Garcia (2):
  watchdog: imgpdc: Fix max timeout
  watchdog: imgpdc: Add some documentation about the timeout

 drivers/watchdog/imgpdc_wdt.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

-- 
2.3.3
