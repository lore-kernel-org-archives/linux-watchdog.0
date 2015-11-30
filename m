Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59540 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbbK3QKv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Nov 2015 11:10:51 -0500
Subject: Re: [PATCH v4 1/2] watchdog: add Alphascale asm9260-wdt driver
To: Oleksij Rempel <linux@rempel-privat.de>,
	linux-watchdog@vger.kernel.org, wim@iguana.be,
	devicetree@vger.kernel.org, robh@kernel.org
References: <5652BFA5.9010101@roeck-us.net>
 <1448480003-8029-1-git-send-email-linux@rempel-privat.de>
 <1448480003-8029-2-git-send-email-linux@rempel-privat.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565C7509.4030702@roeck-us.net>
Date: Mon, 30 Nov 2015 08:10:49 -0800
MIME-Version: 1.0
In-Reply-To: <1448480003-8029-2-git-send-email-linux@rempel-privat.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/25/2015 11:33 AM, Oleksij Rempel wrote:
> Add WD support for Alphascale asm9260 SoC. This driver
> provide support for different function modes:
> - HW mode to trigger SoC reset on timeout
> - SW mode do soft reset if needed
> - DEBUG mode
>
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

