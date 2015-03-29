Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44822 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbbC2Ddw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 28 Mar 2015 23:33:52 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Yc3yx-000Ej5-Lf
	for linux-watchdog@vger.kernel.org; Sun, 29 Mar 2015 03:33:51 +0000
Message-ID: <55177292.3060003@roeck-us.net>
Date: Sat, 28 Mar 2015 20:33:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Wim Van Sebroeck <wim@iguana.be>,
	David Daney <david.daney@cavium.com>,
	linux-watchdog@vger.kernel.org
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] watchdog: octeon: convert to WATCHDOG_CORE API
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/28/2015 11:05 AM, Aaro Koskinen wrote:
> Convert OCTEON watchdog to WATCHDOG_CORE API. This enables support
> for multiple watchdogs on OCTEON boards.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


