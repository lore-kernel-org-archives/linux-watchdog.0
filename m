Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 0/3] watchdog/hpwdt: Do not claim on unsupported hardware
Date: Wed,  5 Dec 2018 17:42:20 -0700
Message-Id: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

hpwdt driver isn't supported on all iLO hardware.


Changes in version 2:
1) Instead of having explicit if statement to check device IDs,
   provide a pci_device_id table of devices to blacklist.
2) Convert the current instance where SSID 0x1979 was being skipped.
3) Add new patch to add SSID 0x0289 to the blacklist table.
4) Print via dev_dbg instead of dev_info.


Jerry Hoemann (3):
  watchdog/hpwdt: Exclude via blacklist
  watchdog/hpwdt: Do not claim unsupported hardware
  watchdog/hpwdt: Update driver version.

 drivers/watchdog/hpwdt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
1.8.3.1
