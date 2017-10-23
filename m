Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 3/3] watchdog: hpwdt: add ioctl WDIOC_GETPRETIMEOUT
Date: Mon, 23 Oct 2017 16:46:18 -0600
Message-Id: <8683001075d79d84212c94b6f361c9fb34062012.1508797127.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508797127.git.jerry.hoemann@hpe.com>
References: <cover.1508797127.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508797127.git.jerry.hoemann@hpe.com>
References: <cover.1508797127.git.jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add support for WDIOC_GETPRETIMEOUT ioctl so that user applications
can determine when the NMI should arrive.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index e616583..b64ce43 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -50,6 +50,7 @@
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static char expect_release;
 static unsigned long hpwdt_is_open;
+static const int pretimeout = 9;
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
 static unsigned long __iomem *hpwdt_nmistat;
@@ -631,6 +632,12 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
 		}
 		break;
 
+	case WDIOC_GETPRETIMEOUT:
+		ret = copy_to_user(argp, &pretimeout, sizeof(pretimeout));
+		if (ret)
+			ret = -EFAULT;
+		break;
+
 	case WDIOC_SETTIMEOUT:
 		ret = get_user(new_margin, p);
 		if (ret)
-- 
1.8.3.1
