Return-Path: <joel.stan@gmail.com>
Return-path: <joel.stan@gmail.com>
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v3 0/2] watchdog: Add Nuvoton NPCM (Poleg) driver
Date: Fri,  9 Mar 2018 15:21:05 +1030
Message-Id: <20180309045107.8515-1-joel@jms.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

v3: Address comments from Guneter and Tomer, add Rob's review
v2: Address comments from Guenter and Marcus

This is a driver for the Poleg board that is in the process of being
upstreamed. I have tested it on an evaluation board.

The watchdog is a single register inside of the timer IP. This made me
think about how to describe the device tree bindings for a while, but
after some discussion I settled on describing the watchdog separately,
and giving it's own compatible string, and it's own driver.

The timer is being reviewed over here:

 https://lkml.org/lkml/2018/2/26/492

Joel Stanley (2):
  dt-bindings: watchdog: Add Nuvoton NPCM description
  watchdog: Add Nuvoton NPCM watchdog driver

 .../bindings/watchdog/nuvoton,npcm-wdt.txt         |  28 +++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/npcm_wdt.c                        | 254 +++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
 create mode 100644 drivers/watchdog/npcm_wdt.c

-- 
2.15.1
