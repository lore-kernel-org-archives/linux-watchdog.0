Return-Path: <groeck7@gmail.com>
Return-path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@pr.hu>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/12] watchdog: sp5100_tco: Various improvements
Date: Sun, 24 Dec 2017 13:04:05 -0800
Message-Id: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

The sp5100_tco watchdog driver does not really support recent AMD CPUs,
even though it claims to do so. On top of that, it doesn't use the
watchdog subsystem, and various other problems have crept in. Let's
clean it up for good.

The code was tested on AMD Ryzen 1700 with motherboards from MSI and
Gigabyte. Tests on older hardware would be useful to make sure that
nothing broke.

----------------------------------------------------------------
Guenter Roeck (12):
      watchdog: sp5100_tco: Always use SP5100_IO_PM_{INDEX_REG,DATA_REG}
      watchdog: sp5100_tco: Fix watchdog disable bit
      watchdog: sp5100_tco: Use request_muxed_region where possible
      watchdog: sp5100_tco: Use standard error codes
      watchdog: sp5100_tco: Clean up sp5100_tco_setupdevice
      watchdog: sp5100_tco: Match PCI device early
      watchdog: sp5100_tco: Use dev_ print functions where possible
      watchdog: sp5100_tco: Clean up function and variable names
      watchdog: sp5100_tco: Convert to use watchdog subsystem
      watchdog: sp5100_tco: Use bit operations
      watchdog: sp5100-tco: Abort if watchdog is disabled by hardware
      watchdog: sp5100_tco: Add support for recent FCH versions

 drivers/watchdog/sp5100_tco.c | 710 ++++++++++++++++++------------------------
 drivers/watchdog/sp5100_tco.h |  57 ++--
 2 files changed, 344 insertions(+), 423 deletions(-)
