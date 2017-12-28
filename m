Return-Path: <paul@crapouillou.net>
Return-path: <paul@crapouillou.net>
From: Paul Cercueil <paul@crapouillou.net>
To: Ralf Baechle <ralf@linux-mips.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 0/7] jz4740 watchdog driver & platform cleanups
Date: Thu, 28 Dec 2017 17:29:32 +0100
Message-Id: <20171228162939.3928-1-paul@crapouillou.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

This patchset is meant to drop the platform code that handles the system
reset, since the watchdog driver can be used for this task.

Some fixes and cleanups are also included.

Thanks,
-Paul Cercueil
