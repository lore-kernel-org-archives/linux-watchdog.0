Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:52832 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751136AbbBRNEM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 08:04:12 -0500
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: boris.brezillon@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv3 0/2] watchdog: Introduce "early-timeout-sec" property
Date: Wed, 18 Feb 2015 14:57:20 +0200
Message-Id: <cover.1424262664.git.timo.kokkonen@offcode.fi>
In-Reply-To: <54B53160.6060309@roeck-us.net>
References: <54B53160.6060309@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently we have no means to adjust the watchdog behavior on early
start up before user space has opened the device. The generic behavior
among the watchdog drivers is to not start the watchdog at all (or
disable it, if possible, or in case at91sam9_wdt, start a kernel timer
that keeps on pinging the watchdog on behalf of user space until a
watchdog daemon opens it). This unfortunately opens a time window
between starting the driver and starting the user space watchdog
daemon where a crash of the kernel or user space might prevent the
watchdog from ever resetting the device at all. This is obviously bad
on production systems.

Introduce a new device tree property that, when set, changes the
watchdog driver behavior in such way that there no longer is any
window where crash is not caught by the watchdog.

This is the third version of this patch. Previous versions of the
patch were using an atmel specific property name. This patch uses a
generic name instead as the functionality itself has nothing atmel
related. I am also introducing watchdog.txt for describing the generic
watchdog device tree bindings as there was no such file before.

Timo Kokkonen (2):
  devicetree: Document generic watchdog properties
  at91sam9_wdt: Allow watchdog to reset device at early boot

 .../devicetree/bindings/watchdog/watchdog.txt         | 19 +++++++++++++++++++
 drivers/watchdog/at91sam9_wdt.c                       |  9 ++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.txt

-- 
2.1.0

