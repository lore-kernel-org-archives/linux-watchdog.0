Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/5] watchdog: Replace driver based refcounting
Date: Sun, 20 Dec 2015 13:04:58 -0800
Message-Id: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

All variables required by the watchdog core to manage a watchdog are
currently stored in struct watchdog_device. The lifetime of those
variables is determined by the watchdog driver. However, the lifetime
of variables used by the watchdog core differs from the lifetime of
struct watchdog_device. To remedy this situation, watchdog drivers
can implement ref and unref callbacks, to be used by the watchdog
core to lock struct watchdog_device in memory. This mechanism was
introduced with commit e907df327252 ("watchdog: Add support for
dynamically allocated watchdog_device structs").

While this solves the immediate problem, it depends on watchdog drivers
to actually implement the ref/unref callbacks. This is error prone,
often not implemented in the first place, or not implemented correctly.

To solve the problem without requiring driver support, split the variables
in struct watchdog_device into two data structures - one for variables
associated with the watchdog driver, one for variables associated with
the watchdog core. With this approach, the watchdog core can keep track
of the variables it uses and no longer depends on ref/unref callbacks
in the driver. As a side effect, some of the variables originally in struct
watchdog_driver are now private to the watchdog core and no longer visible
in watchdog drivers.

The 'ref' and 'unref' callbacks in struct watchdog_driver are no longer
used and marked as deprecated.

Patch 1/5 moves watchdog device creation from watchdog_core.c to watchdog_dev.c
to simplify watchdog device handling.

Patch 2/5 separates variables in watchdog_device based on variable lifetime.

Patch 3/5 to 5/5 remove existing ref/unref functions from the drivers
implementing it.

The series applies on top of the current watchdog-next as well as the pending
patches introducing sysfs support ("watchdog: Use static struct class
watchdog_class in stead of pointer" and "watchdog: Read device status through
sysfs attributes") by Pratyush Anand.
