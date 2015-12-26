Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/6] watchdog: Replace driver based refcounting
Date: Fri, 25 Dec 2015 16:01:39 -0800
Message-Id: <1451088105-1722-1-git-send-email-linux@roeck-us.net>
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
used and marked as deprecated for the time being.

Patch 1/6 moves watchdog device creation from watchdog_core.c to
watchdog_dev.c to simplify watchdog device handling.

Patch 2/6 modifies the diag288 watchdog to no longer use and overload
watchdog core internal flags.

Patch 3/6 separates variables in watchdog_device based on variable
lifetime.

Patch 4/6 to 6/6 remove existing ref/unref functions from the drivers
implementing it. Two of those patches (for da9052 and da9055) fix a
previously introduced bug as side effect.

The series applies on top of the current watchdog-next as well as the
pending patches introducing sysfs support ("watchdog: Use static struct
class watchdog_class in stead of pointer" and "watchdog: Read device
status through sysfs attributes") by Pratyush Anand.

---
v2: Add patch 2/6.
    Add more detailed description to patch 3/6.
    Rename internal data structure to watchdog_core_data, and the variable
    pointing to it to wd_data. Move its declaration into watchdog_dev.c.
    Reorder include files in watchdog_dev.c to alphabetic order.
    Remove _watchdog_ping helper function and call watchdog_ping()
    directly. Handle locks in the calling code.
    Drop locking from watchdog_open(). It is already protected against
    parallel device removal in the driver core code, and file access
    functions won't be called before the function returns.
    Remove previously added message "watchdog still running". It wasn't
    there before, and we should avoid user visible changes.
    Add missing kfree() to the sch56xx patch.
    Add comments to da9052 and da9055 patches indicating that the
    patches fix a bug.
