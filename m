Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rwright@hpe.com,
	maurice.a.saldivar@hpe.com,
	mingo@kernel.org,
	marcus.folkesson@gmail.com,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v4 04/10] watchdog/hpwdt: Update Module info.
Date: Sun, 25 Feb 2018 14:32:53 -0700
Message-Id: <20180225213259.2861-5-jerry.hoemann@hpe.com>
In-Reply-To: <20180225213259.2861-1-jerry.hoemann@hpe.com>
References: <20180225213259.2861-1-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

Update Module description to reflect branding changes.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 2a6f3be22c98..44c3038cc531 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -429,7 +429,7 @@ static struct pci_driver hpwdt_driver = {
 };
 
 MODULE_AUTHOR("Tom Mingarelli");
-MODULE_DESCRIPTION("hp watchdog driver");
+MODULE_DESCRIPTION("hpe watchdog driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HPWDT_VERSION);
 
-- 
2.13.6
