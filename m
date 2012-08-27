Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Mingarelli, Thomas" <Thomas.Mingarelli@hp.com>
To: "Kani, Toshimitsu" <toshi.kani@hp.com>, "wim@iguana.be" <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] hpwdt: Fix kdump issue in hpwdt
Date: Mon, 27 Aug 2012 18:59:27 +0000
Message-ID: <9774516974AF5F4C8A2C3C69CD34123323352FF9@G1W3651.americas.hpqcorp.net>
References: <1346093544-12007-1-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1346093544-12007-1-git-send-email-toshi.kani@hp.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Wim:

I acknowledge and accept this patch.


Thanks,
Tom

-----Original Message-----
From: Kani, Toshimitsu 
Sent: Monday, August 27, 2012 1:52 PM
To: wim@iguana.be; linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org; Mingarelli, Thomas; Kani, Toshimitsu; stable@vger.kernel.org
Subject: [PATCH] hpwdt: Fix kdump issue in hpwdt

kdump can be interrupted by watchdog timer when the timer is left
activated on the crash kernel. Changed the hpwdt driver to disable
watchdog timer at boot-time. This assures that watchdog timer is
disabled until /dev/watchdog is opened, and prevents watchdog timer
to be left running on the crash kernel.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
Tested-by: Lisa Mitchell <lisa.mitchell@hp.com>
Cc: stable@vger.kernel.org 
---
 drivers/watchdog/hpwdt.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 1eff743..ae60406 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -814,6 +814,9 @@ static int __devinit hpwdt_init_one(struct pci_dev *dev,
 	hpwdt_timer_reg = pci_mem_addr + 0x70;
 	hpwdt_timer_con = pci_mem_addr + 0x72;
 
+	/* Make sure that timer is disabled until /dev/watchdog is opened */
+	hpwdt_stop();
+
 	/* Make sure that we have a valid soft_margin */
 	if (hpwdt_change_timer(soft_margin))
 		hpwdt_change_timer(DEFAULT_MARGIN);
-- 
1.7.7.6
