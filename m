Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34472 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbcEWVTw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 17:19:52 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 0/4] Allow ISA-style drivers on modern systems
Date: Mon, 23 May 2016 17:19:43 -0400
Message-Id: <cover.1464029828.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Changes in v2:
  - Adjusted preprocessor compilation conditional in include/linux/isa.h
    to use CONFIG_ISA_BUS_API in order to link the correct ISA bus
    driver function definitions when available
  - Move ISA_BUS_API Kconfig option to arch/Kconfig, thus making it
    available to all architectures instead of just X86
  - X86 ISA_BUS Kconfig option should be disabled by default; ISA
    devices typically do not have a way to be probed, so users should
    be required to explicitly enable ISA bus driver support, lest a
    selected driver be loaded with the misguided expectation of a safe
    hardware probe

Several modern devices, such as PC/104 cards, are expected to run on
modern systems via an ISA bus interface. Since ISA is a legacy interface
for most modern architectures, ISA support should remain disabled in
general. Support for ISA-style drivers should be enabled on a per driver
basis.

To allow ISA-style drivers on modern systems, this patchset introduces
the ISA_BUS_API and ISA_BUS Kconfig options. The ISA bus driver will now
build conditionally on the ISA_BUS_API Kconfig option, which defaults to
the legacy ISA Kconfig option. The ISA_BUS Kconfig option allows the
ISA_BUS_API Kconfig option to be selected on architectures which do not
enable ISA (e.g. X86_64).

The ISA_BUS Kconfig option is currently only implemented for X86
architectures. Other architectures may have their own ISA_BUS Kconfig
option added as required.

An earlier attempt to allow the ISA bus driver to build for X86_64 took
an inappropriate approach resulting in legacy ISA drivers becoming
enabled unconditionally on untested and unsupported architectures.
Commit 51e68d055cba ("x86 isa: add back X86_32 dependency on
CONFIG_ISA"), added to restrict the ISA bus driver to only X86_32,
causes several drivers intended for X86_64 to be restricted to X86_32 as
well.

This patchset replaces the ISA Kconfig option dependency of several
drivers to ISA_BUS_API, so that they may build for X86_64 as intended.
The respective drivers are as follows:
    * ACCES 104-IDIO-16 GPIO driver
    * ACCES 104-IDI-48 GPIO driver
    * ACCES 104-DIO-48E GPIO driver
    * Apex Embedded Systems STX104 DAC driver
    * WinSystems EBC-C384 watchdog timer driver
    * WinSystems WS16C48 GPIO driver

William Breathitt Gray (4):
  isa: Allow ISA-style drivers on modern systems
  gpio: Allow PC/104 devices on X86_64
  iio: stx104: Allow build for X86_64
  watchdog: ebc-c384_wdt: Allow build for X86_64

 arch/Kconfig             |  3 +++
 arch/x86/Kconfig         | 10 ++++++++++
 drivers/base/Makefile    |  2 +-
 drivers/gpio/Kconfig     |  8 ++++----
 drivers/iio/dac/Kconfig  |  2 +-
 drivers/watchdog/Kconfig |  2 +-
 include/linux/isa.h      |  2 +-
 7 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.7.3

