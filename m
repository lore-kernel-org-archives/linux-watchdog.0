Return-path: <krzk@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] watchdog: s3c2410: Minor cleanups
Date: Sat, 11 Mar 2017 19:42:52 +0200
Message-Id: <20170311174255.23327-1-krzk@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

Continuation of previous [1] with patches just rebased
on current linux-next.

[1] http://lkml.iu.edu/hypermail/linux/kernel/1702.3/00673.html

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  watchdog: s3c2410: Constify local structures
  watchdog: s3c2410: Simplify getting driver data
  watchdog: s3c2410: Minor code cleanup

 drivers/watchdog/s3c2410_wdt.c | 58 +++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

-- 
2.9.3
