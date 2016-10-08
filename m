Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 8 Oct 2016 16:10:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v5] watchdog: ziirave_wdt: Add support to upload the firmware.
Message-ID: <20161008141046.GF23290@spo001.leaseweb.nl>
References: <1470845883-28569-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470845883-28569-1-git-send-email-enric.balletbo@collabora.com>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Enric,

> This patch adds and entry to the sysfs to start firmware upload process
> on the specified device with the requested firmware.
> 
> The uploading of the firmware needs only to happen once per firmware
> upgrade, as the firmware is stored in persistent storage. If the
> firmware upload or the firmware verification fails then we print and
> error message and exit.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

This patch was added to linux-watchdog-next almost 2 weeks ago.

Kind regards,
Wim.
