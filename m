Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:36200 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758017AbcAKV3U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jan 2016 16:29:20 -0500
Date: Mon, 11 Jan 2016 22:29:18 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] watchdog: Drop pointer to watchdog device from struct watchdog_device
Message-ID: <20160111212918.GD6613@spo001.leaseweb.nl>
References: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> The lifetime of the watchdog device pointer is different from the lifetime
> of its character device. Remove it entirely to avoid race conditions, and
> to make sure that drivers don't start to use it again.

This patchset has been added to linux-watchdog-next.

Kind regards,
Wim.

