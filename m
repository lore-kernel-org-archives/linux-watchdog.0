Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/3] watchdog: Drop pointer to watchdog device from struct watchdog_device
Date: Sun,  3 Jan 2016 15:11:55 -0800
Message-Id: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The lifetime of the watchdog device pointer is different from the lifetime
of its character device. Remove it entirely to avoid race conditions, and
to make sure that drivers don't start to use it again.
