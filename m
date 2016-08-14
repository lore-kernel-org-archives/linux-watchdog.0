Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38748 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbcHNKdG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 14 Aug 2016 06:33:06 -0400
Subject: Re: [PATCH v5] watchdog: ziirave_wdt: Add support to upload the
 firmware.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1470845883-28569-1-git-send-email-enric.balletbo@collabora.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e3dbe7bd-221c-77f6-ec35-7b599769a062@roeck-us.net>
Date: Sun, 14 Aug 2016 03:33:02 -0700
MIME-Version: 1.0
In-Reply-To: <1470845883-28569-1-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/10/2016 09:18 AM, Enric Balletbo i Serra wrote:
> This patch adds and entry to the sysfs to start firmware upload process
> on the specified device with the requested firmware.
>
> The uploading of the firmware needs only to happen once per firmware
> upgrade, as the firmware is stored in persistent storage. If the
> firmware upload or the firmware verification fails then we print and
> error message and exit.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

